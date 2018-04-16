

#import <Foundation/Foundation.h>
#import "AudioToolbox/MusicPlayer.h"

@interface fypMIDIPlayer : NSObject {
    MusicSequence musicSequence;
    MusicPlayer musicPlayer;
}

- initWithMIDIFile:(NSString *)midiFile;

- (void)playMIDI;
- (void)stopMIDI;

@end
