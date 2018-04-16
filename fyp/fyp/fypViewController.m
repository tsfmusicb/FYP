#import "fypViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "AudioTest.h"
#import "fypAppDelegate.h"


@interface fypViewController ()

@end

@implementation fypViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];

    //add Menu
    menu = [[fypMenu alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.height, self.view.bounds.size.width)];
    [menu setViewController: self];
    [self.view addSubview:menu];
        
    //default CreateMusicView
    createMusicView = [[fypCreateMusic alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.height, self.view.bounds.size.width)];
    [createMusicView setMenu:menu];
    [self.view addSubview:createMusicView];
}


- (void) changeToCreateMusic {
    if(![self.view.subviews containsObject:createMusicView]) {
        createMusicView = [[fypCreateMusic alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
        [createMusicView setMenu:menu];
        [self.view addSubview:createMusicView];
        [self.view sendSubviewToBack:createMusicView];
        [musicTrainingView removeFromSuperview];
        [earTrainingView removeFromSuperview];
    }
    
    [menu closeMenu];
}

- (void) changeToMusicTraining {
    if(![self.view.subviews containsObject:musicTrainingView]) {
        musicTrainingView = [[fypMusicTraining alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
        [musicTrainingView setMenu:menu];
        [self.view addSubview:musicTrainingView];
        [self.view sendSubviewToBack:musicTrainingView];

        [createMusicView removeFromSuperview];
        [earTrainingView removeFromSuperview];
    }
    
    [menu closeMenu];
}

- (void) changeToEarTraining {
    if(![self.view.subviews containsObject:earTrainingView]) {
        earTrainingView = [[fypEarTraining alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
        [earTrainingView setMenu:menu];
        [self.view addSubview:earTrainingView];
        [self.view sendSubviewToBack:earTrainingView];
        [createMusicView removeFromSuperview];
        [musicTrainingView removeFromSuperview];
    }
    
    [menu closeMenu];
}

- (void) changeToTuner {
    fypAppDelegate *appDelegate = (fypAppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate changeToTuner];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
