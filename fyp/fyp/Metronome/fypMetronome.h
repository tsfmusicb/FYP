#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>

@interface fypMetronome : UIView {
    UIView *movingBox;
    
    BOOL toggleMove;
    double _BPM;
    int _BEAT, currentBeatCount;
    
    AVAudioPlayer *tockPlayer;
    AVAudioPlayer *tickPlayer;
}

- (id)initWithFrameAndSetting:(CGRect)frame:(double)bpm:(int)beat;

- (void)startBeat;
- (void)stopBeat;

@end
