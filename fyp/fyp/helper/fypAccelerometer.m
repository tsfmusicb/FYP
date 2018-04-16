#import "fypAccelerometer.h"

#define kUpdateFrequency	5.0
#define kLocalizedPause		NSLocalizedString(@"Pause","pause taking samples")
#define kLocalizedResume	NSLocalizedString(@"Resume","resume taking samples")

@implementation fypAccelerometer

-(id)init{
    self = [super init];
    isPlayingSound = NO;
    timePoint = 0;
    notes = [[NSMutableArray alloc]init];
    times = [[NSMutableArray alloc]init];
    isPaused = YES;
    
    at = [AudioTest audioTest];
    return self;
}

// UIAccelerometerDelegate method, called when the device accelerates.
-(void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration{

	if(!isPaused){
        //if(!isPlayingSound){
            //isPlayingSound = YES;
        NSString *time = @"Time1"; //default = 1
        NSString *note = nil;
        
        switch (timePoint) {
            case 0:
                time = @"Time05";
                [times addObject:[NSNumber numberWithDouble:0.5]];
                break;
            case 1:
                time = @"Time1";
                [times addObject:[NSNumber numberWithDouble:1.0]];
                break;
            case 2:
                time = @"Time2";
                [times addObject:[NSNumber numberWithDouble:2.0]];
                break;
            default:
                time = @"Time1";
                [times addObject:[NSNumber numberWithInt:1]];
                break;
        }
        
        NSString *fileName = nil;
        if(acceleration.x < -0.9){
            note = @"c";
        }else if(acceleration.x < -0.8){
            note = @"d";
        }else if(acceleration.x < -0.7){
            note = @"e";
        }else if(acceleration.x < -0.6){
            note = @"f";
        }else if(acceleration.x < -0.5){
            note = @"g";
        }else if(acceleration.x <= -0.4){
            note = @"a";
        }else if(acceleration.x > -0.4){
            note = @"b";
        }
        fileName = [note stringByAppendingString:time];
        //NSLog(@" X = %f, file name = %@", acceleration.x,fileName);
        [at midiTest:fileName isInResource:YES];
        isPlayingSound = NO;
        
        //Record the note for generate
        [notes addObject:note];
        //}
	}
}



-(void)genMIDI{    
    NSString *file = @"test.mid";
    
    MIDI *mid = [[MIDI alloc] initWithOut:file];
	[mid writeFile:notes times:times];
}

-(void)playAndStop{
    if(isPaused){
        //Play
        isPaused = NO;
        [[UIAccelerometer sharedAccelerometer] setUpdateInterval:0.8];
        [[UIAccelerometer sharedAccelerometer] setDelegate:self];
    }else{
        //Stop
        [[UIAccelerometer sharedAccelerometer] setDelegate:nil];
        isPaused = YES;
        
        //Play Back the music
        [self genMIDI];
        
        NSString *path = [NSTemporaryDirectory() stringByAppendingString:@"test.mid"];
        /*if ([[NSFileManager defaultManager] fileExistsAtPath: path ] == YES)
            NSLog (@"File exists: %@", path);
        else
            NSLog (@"File not found");*/
        
        //NSMutableData *content = [[NSMutableData alloc] initWithContentsOfFile:path];
        //NSLog(@"HERE-- content: %@",content);
        
        [at midiTest:path isInResource:NO];
    }
}
-(IBAction)pauseOrResume:(id)sender
{
	if(isPaused){
		isPaused = NO;
		//pause.title = kLocalizedPause;
	}else{
		// If we are not paused, then pause and set the title to "Resume"
		isPaused = YES;
        [self genMIDI];
      
        NSString *path = [NSTemporaryDirectory() stringByAppendingString:@"test.mid"];
        /*if ([[NSFileManager defaultManager] fileExistsAtPath: path ] == YES)
            NSLog (@"File exists: %@", path);
        else
            NSLog (@"File not found");*/

        //NSMutableData *content = [[NSMutableData alloc] initWithContentsOfFile:path];
        //NSLog(@"HERE-- content: %@",content);
        
        [at midiTest:path isInResource:NO];
      
	}
	
	// Inform accessibility clients that the pause/resume button has changed.
	UIAccessibilityPostNotification(UIAccessibilityLayoutChangedNotification, nil);
}

-(IBAction)timeSelect:(id)sender{
    timePoint = [sender selectedSegmentIndex];
}

-(void)dealloc
{
	// clean up everything.

	//[super dealloc];
}

@end
