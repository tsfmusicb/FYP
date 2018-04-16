#import "fypAppDelegate.h"

#import "fypViewController.h"

@implementation fypAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.viewController = [[fypViewController alloc] init];
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    
    //Generate File
    NSString *outFile = @"test.mid";

    outFile = [NSTemporaryDirectory() stringByAppendingString:outFile];
    
    // Config tableview
    readfileViewController *readfile = [[readfileViewController alloc] initWithStyle:UITableViewStylePlain];
    Controller = [[UINavigationController alloc] initWithRootViewController:readfile];
    [Controller setTitle:@"Select Midi"];
    [Controller.view setFrame:CGRectMake(0, self.viewController.view.bounds.size.width, self.viewController.view.bounds.size.width, self.viewController.view.bounds.size.height)];
    Controller.navigationItem.hidesBackButton = YES;
    UIButton *btnBack = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btnBack setFrame:CGRectMake(3, 3, 50, 25)];
    [btnBack setTitle:@"Back" forState:UIControlStateNormal];
    [btnBack addTarget:self action:@selector(btnBack_onClick) forControlEvents:UIControlEventTouchUpInside];
    [Controller.view addSubview:btnBack];
    
    
    
    tunerView = [[fypTuner alloc] initWithFrame:CGRectMake(0, self.viewController.view.bounds.size.width, self.viewController.view.bounds.size.height, self.viewController.view.bounds.size.width)];
    
    return YES;
}

- (void)changeToTuner {
    [tunerView setFrame:CGRectMake(0, self.viewController.view.bounds.size.width, self.viewController.view.bounds.size.height, self.viewController.view.bounds.size.width)];
    [self.window addSubview:tunerView];
    [UIView beginAnimations:@"animateTableView" context:nil];
    [UIView setAnimationDuration:0.5];
    [tunerView setFrame:CGRectMake( 0, 0, self.viewController.view.bounds.size.height, self.viewController.view.bounds.size.width)];
    [UIView commitAnimations];
}



- (void)openFile {
    [self.viewController.view addSubview:Controller.view];
    
    [UIView beginAnimations:@"animateTableView" context:nil];
    [UIView setAnimationDuration:0.5];
    [Controller.view setFrame:CGRectMake( 0, 0, self.viewController.view.bounds.size.width, self.viewController.view.bounds.size.height)];
    [UIView commitAnimations];
}

- (void)btnBack_onClick {
    [UIView beginAnimations:@"animateTableView" context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDidStopSelector:@selector(removeTableView)];
    [Controller.view setFrame:CGRectMake( 0, self.viewController.view.bounds.size.height, self.viewController.view.bounds.size.width, self.viewController.view.bounds.size.height)];
    [UIView commitAnimations];
}

- (void)removeTableView {
    [Controller.view removeFromSuperview];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
