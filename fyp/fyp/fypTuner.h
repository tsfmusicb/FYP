#import <UIKit/UIKit.h>
#import <AudioUnit/AudioUnit.h>
#import "fypMenu.h"
#import "AudioTest.h"

@interface fypTuner : UIView
{
    fypMenu *_menu;
    
    NSMutableArray *notes;
    
	UIButton *g3Button;
	UIButton *d4Button;
	UIButton *a4Button;
	UIButton *e5Button;
	UIButton *e3Button;
	UIButton *a3Button;
	UIButton *g4Button;
	UIButton *b4Button;
	UIButton *c4Button;
	UIButton *e4Button;
	UIButton *c2Button;
	UIButton *g2Button;
    UIButton *d3Button;
    UIButton *c3Button;
    UILabel *currentInstrument;
    UIImageView *img;
    
    AudioTest * at;
    
@public
	double frequency;
	double sampleRate;
	double theta;
}

@property (nonatomic, retain) IBOutlet UIButton *g3Button;
@property (nonatomic, retain) IBOutlet UIButton *d4Button;
@property (nonatomic, retain) IBOutlet UIButton *a4Button;
@property (nonatomic, retain) IBOutlet UIButton *e5Button;
@property (nonatomic, retain) IBOutlet UIButton *e3Button;
@property (nonatomic, retain) IBOutlet UIButton *a3Button;
@property (nonatomic, retain) IBOutlet UIButton *g4Button;
@property (nonatomic, retain) IBOutlet UIButton *b4Button;
@property (nonatomic, retain) IBOutlet UIButton *c4Button;
@property (nonatomic, retain) IBOutlet UIButton *e4Button;
@property (nonatomic, retain) IBOutlet UIButton *c2Button;
@property (nonatomic, retain) IBOutlet UIButton *g2Button;
@property (nonatomic, retain) IBOutlet UIButton *d3Button;
@property (nonatomic, retain) IBOutlet UIButton *c3Button;
@property (nonatomic, retain) IBOutlet UIImageView *img;

- (IBAction)togglePlay:(UIButton *)selectedButton;
- (IBAction)BtnViolin_onclick;
- (IBAction)BtnViola_onclick;
- (IBAction)BtnCello_onclick;
- (IBAction)BtnGuiter_onclick;
- (IBAction)BtnUkulele_onclick;

@end

