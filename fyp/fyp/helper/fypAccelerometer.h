#import <UIKit/UIKit.h>
#import "AudioTest.h"
#import "MIDI.h"

@interface fypAccelerometer : UIView<UIAccelerometerDelegate> {

	UIBarButtonItem *pause;
	UILabel *filterLabel;
	BOOL isPaused, useAdaptive, isPlayingSound;
    AudioTest * at;
    int timePoint;
    NSMutableArray *notes;
    NSMutableArray *times;
}


- (id)init;

-(IBAction)pauseOrResume:(id)sender;

-(void)genMIDI;
-(void)playAndStop;

@end