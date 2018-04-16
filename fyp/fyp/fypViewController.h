#import <UIKit/UIKit.h>
#import "fypMenu.h"
#import "fypCreateMusic.h"
#import "fypMusicTraining.h"
#import "fypEarTraining.h"
#import "fypTuner.h"

@interface fypViewController : UIViewController {
    fypMenu *menu;
    
    fypCreateMusic *createMusicView;
    fypMusicTraining *musicTrainingView;
    fypEarTraining *earTrainingView;
    fypTuner *tunerView;
}


- (void) changeToCreateMusic;
- (void) changeToMusicTraining;
- (void) changeToEarTraining;
- (void) changeToTuner;

@end
