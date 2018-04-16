//
//  AudioTest.m

//  Created by Tse Siu Fai on 15/03/2013.
//

#import "AudioTest.h"


#define kLowNote  48
#define kHighNote 72
#define kMidNote  60

@interface AudioTest ()

@property (readwrite) AUGraph   processingGraph;
@property (readwrite) AudioUnit samplerUnit;
@property (readwrite) AudioUnit ioUnit;


@end

@implementation AudioTest


@synthesize processingGraph     = _processingGraph;
@synthesize samplerUnit         = _samplerUnit;
@synthesize ioUnit              = _ioUnit;


+ audioTest {
    return [[self alloc] initAudioTest];
}


-(id) initAudioTest {
	if((self = [self init] )) {
        
	}
	return self;
}

- (BOOL) createAUGraph {
    
	OSStatus result = noErr;
    
	AUNode samplerNode, ioNode;
    
	AudioComponentDescription cd = {};
	cd.componentManufacturer     = kAudioUnitManufacturer_Apple;
    
	result = NewAUGraph (&_processingGraph);
    NSCAssert (result == noErr, @"Unable to create an AUGraph object. Error code: %d '%.4s'", (int) result, (const char *)&result);
    
	cd.componentType = kAudioUnitType_MusicDevice; 
	cd.componentSubType = kAudioUnitSubType_Sampler; 
	
	result = AUGraphAddNode (self.processingGraph, &cd, &samplerNode);
    NSCAssert (result == noErr, @"Unable to add the Sampler unit to the audio processing graph. Error code: %d '%.4s'", (int) result, (const char *)&result);
    
	cd.componentType = kAudioUnitType_Output;  
	cd.componentSubType = kAudioUnitSubType_RemoteIO;  
    
	result = AUGraphAddNode (self.processingGraph, &cd, &ioNode);
    NSCAssert (result == noErr, @"Unable to add the Output unit to the audio processing graph. Error code: %d '%.4s'", (int) result, (const char *)&result);
    
	result = AUGraphOpen (self.processingGraph);
    NSCAssert (result == noErr, @"Unable to open the audio processing graph. Error code: %d '%.4s'", (int) result, (const char *)&result);
    
	result = AUGraphConnectNodeInput (self.processingGraph, samplerNode, 0, ioNode, 0);
    NSCAssert (result == noErr, @"Unable to interconnect the nodes in the audio processing graph. Error code: %d '%.4s'", (int) result, (const char *)&result);
    
	result = AUGraphNodeInfo (self.processingGraph, samplerNode, 0, &_samplerUnit);
    NSCAssert (result == noErr, @"Unable to obtain a reference to the Sampler unit. Error code: %d '%.4s'", (int) result, (const char *)&result);
    
	result = AUGraphNodeInfo (self.processingGraph, ioNode, 0, &_ioUnit);
    NSCAssert (result == noErr, @"Unable to obtain a reference to the I/O unit. Error code: %d '%.4s'", (int) result, (const char *)&result);
    
    return YES;
}

- (void) configureAndStartAudioProcessingGraph: (AUGraph) graph {
    
    OSStatus result = noErr;
    if (graph) {
        
        result = AUGraphInitialize (graph);
        NSAssert (result == noErr, @"Unable to initialze AUGraph object. Error code: %d '%.4s'", (int) result, (const char *)&result);
        
        result = AUGraphStart (graph);
        NSAssert (result == noErr, @"Unable to start audio processing graph. Error code: %d '%.4s'", (int) result, (const char *)&result);

    }
}

void MyMIDINotifyProc (const MIDINotification  *message, void *refCon) {
    //printf("MIDI Notify, messageId=%ld,", message->messageID);
}

static void MyMIDIReadProc(const MIDIPacketList *pktlist,
                           void *refCon,
                           void *connRefCon) {
    
    
    AudioUnit *player = (AudioUnit*) refCon;
    
    MIDIPacket *packet = (MIDIPacket *)pktlist->packet;
    for (int i=0; i < pktlist->numPackets; i++) {
        Byte midiStatus = packet->data[0];
        Byte midiCommand = midiStatus >> 4;
        
        
        if (midiCommand == 0x09) {
            Byte note = packet->data[1] & 0x7F;
            Byte velocity = packet->data[2] & 0x7F;
            
            int noteNumber = ((int) note) % 12;
            NSString *noteType;
            switch (noteNumber) {
                case 0:
                    noteType = @"C";
                    break;
                case 1:
                    noteType = @"C#";
                    break;
                case 2:
                    noteType = @"D";
                    break;
                case 3:
                    noteType = @"D#";
                    break;
                case 4:
                    noteType = @"E";
                    break;
                case 5:
                    noteType = @"F";
                    break;
                case 6:
                    noteType = @"F#";
                    break;
                case 7:
                    noteType = @"G";
                    break;
                case 8:
                    noteType = @"G#";
                    break;
                case 9:
                    noteType = @"A";
                    break;
                case 10:
                    noteType = @"Bb";
                    break;
                case 11:
                    noteType = @"B";
                    break;
                default:
                    break;
            }
            
            OSStatus result = noErr;
            result = MusicDeviceMIDIEvent (player, midiStatus, note, velocity, 0);
        }
        packet = MIDIPacketNext(packet);
    }
}



// this method assumes the class has a member called mySamplerUnit
// which is an instance of an AUSampler
-(OSStatus) loadFromDLSOrSoundFont: (NSURL *)bankURL withPatch: (int)presetNumber {
    
    OSStatus result = noErr;
    
    // fill out a bank preset data structure
    AUSamplerBankPresetData bpdata;
    bpdata.bankURL  = (__bridge CFURLRef) bankURL;
    bpdata.bankMSB  = kAUSampler_DefaultMelodicBankMSB;
    bpdata.bankLSB  = kAUSampler_DefaultBankLSB;
    bpdata.presetID = (UInt8) presetNumber;
    
    // set the kAUSamplerProperty_LoadPresetFromBank property
    result = AudioUnitSetProperty(self.samplerUnit,
                                  kAUSamplerProperty_LoadPresetFromBank,
                                  kAudioUnitScope_Global,
                                  0,
                                  &bpdata,
                                  sizeof(bpdata));
    
    // check for errors
    NSCAssert (result == noErr,
               @"Unable to set the preset property on the Sampler. Error code:%d '%.4s'",
               (int) result,
               (const char *)&result);
    
    return result;
}

-(void) midiTest:(NSString*) fileName isInResource:(BOOL)isInResource{
	if(fileName == nil){
        fileName = @"simpletest";
    }
    
    OSStatus result = noErr;
    
    
    [self createAUGraph];
    [self configureAndStartAudioProcessingGraph: self.processingGraph];
    
    // Create a client
    MIDIClientRef virtualMidi;
    result = MIDIClientCreate(CFSTR("Virtual Client"),
                              MyMIDINotifyProc,
                              NULL,
                              &virtualMidi);
    
    NSAssert( result == noErr, @"MIDIClientCreate failed. Error code: %d '%.4s'", (int) result, (const char *)&result);
    
    // Create an endpoint
    MIDIEndpointRef virtualEndpoint;
    result = MIDIDestinationCreate(virtualMidi, @"Virtual Destination", MyMIDIReadProc, self.samplerUnit, &virtualEndpoint);
    
    NSAssert( result == noErr, @"MIDIDestinationCreate failed. Error code: %d '%.4s'", (int) result, (const char *)&result);
    
    
    
    // Create a new music sequence
    MusicSequence s;
    // Initialise the music sequence
    NewMusicSequence(&s);
    NSString *midiFilePath;
    if(isInResource){
        // Get a string to the path of the MIDI file which
        // should be located in the Resources folder
        midiFilePath = [[NSBundle mainBundle]
                                  pathForResource:fileName
                                  ofType:@"mid"];
    }else{
        midiFilePath = fileName;
    }
    
    NSURL * midiFileURL = [NSURL fileURLWithPath:midiFilePath];
    
    
    MusicSequenceFileLoad(s, (__bridge CFURLRef) midiFileURL, 0, 0);
    
    // Create a new music player
    MusicPlayer  p;
    NewMusicPlayer(&p);
    
    MusicSequenceSetMIDIEndpoint(s, virtualEndpoint);
    
    
    // Load the ound font from file
    NSURL *presetURL = [[NSURL alloc] initFileURLWithPath:[[NSBundle mainBundle] pathForResource:@"gorts_filters" ofType:@"sf2"]];
    
    // Initialise the sound font
    [self loadFromDLSOrSoundFont: (NSURL *)presetURL withPatch: (int)10];
    
    MusicPlayerSetSequence(p, s);
    MusicPlayerPreroll(p);
    MusicPlayerStart(p);
    
    MusicTrack t;
    MusicTimeStamp len;
    UInt32 sz = sizeof(MusicTimeStamp);
    MusicSequenceGetIndTrack(s, 0, &t);
    MusicTrackGetProperty(t, kSequenceTrackProperty_TrackLength, &len, &sz);
    
    
    while (1) { // kill time until the music is over
        usleep (1 * 500);
        MusicTimeStamp now = 0;
        MusicPlayerGetTime (p, &now);
        if (now >= len)
            break;
    }
    
    // Stop the player and dispose of the objects
    MusicPlayerStop(p);
    DisposeMusicSequence(s);
    DisposeMusicPlayer(p);
    
    
}

@end
