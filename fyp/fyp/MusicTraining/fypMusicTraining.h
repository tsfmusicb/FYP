//
//  fypMusicTraining.h
//  fyp
//
//  Created by Tse Siu Fai on 13年3月23日.
//  Copyright (c) 2013年 cityu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "fypMenu.h"

@interface fypMusicTraining : UIView {
    fypMenu *_menu;
    UIImageView *trainingNotePic;
    NSArray *notes;
    int currentNotePointer;
    int secCounter, scoreCounter, percentCounter;
    int userAnsNum, userCorrectAnsNum;
    NSTimer *timer;
    UILabel *timeLable, *scoreLable, *percentLable;
    BOOL isRunning;
    UIImageView *cIdxView,*dIdxView,*eIdxView,*fIdxView,*gIdxView,*aIdxView,*bIdxView;

}

-(void)setMenu:(fypMenu *)menu;

@end
