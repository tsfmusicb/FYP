#import <UIKit/UIKit.h>
#import "readfileViewController.h"
#import "fypTuner.h";

@class fypViewController;

@interface fypAppDelegate : UIResponder <UIApplicationDelegate>{
    UINavigationController *Controller;
    fypTuner *tunerView;
}

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) fypViewController *viewController;

- (void)openFile;
- (void)changeToTuner;

@end
