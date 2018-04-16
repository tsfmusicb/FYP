//
//  fypCreateMusic.h
//  fyp
//
//  Created by Tse Siu Fai on 13年3月23日.
//  Copyright (c) 2013年 cityu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "fypMetronome.h"
#import "fypLineContainer.h"
#import "fypAccelerometer.h"
#import "fypMenu.h"

@interface fypCreateMusic : UIView {
    fypMenu *_menu;
    
    fypMetronome *metronome;
    fypLineContainer *lineContainer;
    fypAccelerometer *accelerometer;
}

-(void)setMenu:(fypMenu *)menu;

@end
