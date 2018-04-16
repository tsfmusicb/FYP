//
//  fypMetronome.m
//  fyp
//
//  Created by Tse Siu Fai on 13年3月12日.
//  Copyright (c) 2013年 cityu. All rights reserved.
//

#import "fypMetronome.h"
#import <QuartzCore/QuartzCore.h>

@implementation fypMetronome

- (id)initWithFrameAndSetting:(CGRect)frame:(double)bpm:(int)beat
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.layer.borderColor = [[UIColor blackColor] CGColor];
        self.layer.borderWidth = 1.0f;
        self.layer.cornerRadius = 5.0;
        
        toggleMove = true;
        _BPM = bpm;
        _BEAT = beat;
        
        
        // init tick and tock sounds
        NSError *error;
        NSURL *tickURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"tick" ofType:@"caf"]];
        tickPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:tickURL error:&error];
        [tickPlayer prepareToPlay];
        NSURL *tockURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"tock" ofType:@"caf"]];
        tockPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:tockURL error:&error];
        [tockPlayer prepareToPlay];
        
        
        movingBox = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
        [movingBox setBackgroundColor:[UIColor blueColor]];
        movingBox.layer.cornerRadius = 10.0;
        [self addSubview:movingBox];
        
    }
    return self;
}



- (void)startBeat {
    toggleMove = false;
    currentBeatCount = 0; //reset the beat count
    [self movingToRight]; //start
}

- (void)stopBeat {
    toggleMove = true;
    //if you wanna stop immediately, command off following line
    //[movingBox.layer removeAllAnimations];
}


- (void)movingToRight {
    if(toggleMove) {
        CGRect newFrame = movingBox.frame;
        newFrame.origin.x = 0;
        
        [UIView beginAnimations:@"movingBox" context:nil];
        [UIView setAnimationDuration:_BPM/2];
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        [UIView setAnimationDelegate:self];
        
        currentBeatCount = 0;
        
        [movingBox setFrame:newFrame];
        [UIView commitAnimations];
        return;
    }
    
    if(++currentBeatCount == 1) {
        [tickPlayer play];
    } else {
        [tockPlayer play];
    }
    
    CGRect newFrame = movingBox.frame;
    newFrame.origin.x = self.bounds.size.width - 10;
    
    [UIView beginAnimations:@"movingBox" context:nil];
    [UIView setAnimationDuration:_BPM/2.0];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(movingToLeft)];
    
    if(currentBeatCount == _BEAT) {
        currentBeatCount = 0;
    }
    
    [movingBox setFrame:newFrame];
    [UIView commitAnimations];
}

- (void)movingToLeft {
    CGRect newFrame = movingBox.frame;
    
    if(currentBeatCount+1 == 1) {
        newFrame.origin.x = 0;
    } else {
        newFrame.origin.x = self.bounds.size.width/2;
    }
    
    [UIView beginAnimations:@"movingBox" context:nil];
    [UIView setAnimationDuration:_BPM/2.0];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(movingToRight)];
    
    [movingBox setFrame:newFrame];
    [UIView commitAnimations];
}


@end
