

#import "fypMIDIPlayer.h"


@implementation fypMIDIPlayer

- initWithMIDIFile:(NSString *)midiFile {
	self = [super init];
        
    NSURL * midiFileURL = [NSURL fileURLWithPath:midiFile];
    NewMusicPlayer(&musicPlayer);
    NewMusicSequence(&musicSequence);
    MusicSequenceFileLoad(musicSequence, CFBridgingRetain(midiFileURL), 0, 0 != noErr);
    MusicPlayerSetSequence(musicPlayer, musicSequence);
    MusicPlayerPreroll(musicPlayer);
    
	return self;
}

- (void)playMIDI {
    MusicPlayerStart(musicPlayer);
}

- (void)stopMIDI {
    OSStatus result = noErr;
    
    result = MusicPlayerStop(musicPlayer);
    
    UInt32 trackCount;
    MusicSequenceGetTrackCount(musicSequence, &trackCount);
    
    MusicTrack track;
    for(int i=0;i<trackCount;i++)
    {
        MusicSequenceGetIndTrack (musicSequence,0,&track);
        result = MusicSequenceDisposeTrack(musicSequence, track);
    }
    
    result = DisposeMusicPlayer(musicPlayer);
    result = DisposeMusicSequence(musicSequence);
}

@end
