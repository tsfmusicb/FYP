//
//  fypMenu.m
//  fyp
//
//  Created by Tse Siu Fai on 13年3月23日.
//  Copyright (c) 2013年 cityu. All rights reserved.
//

#import "fypMenu.h"
#import "UIView+AUISelectiveBorder.h"
#import "fypViewController.h"

@implementation fypMenu

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        topLeft = [[UIView alloc] initWithFrame:CGRectMake(0, -(self.bounds.size.height/2), self.bounds.size.width/2, self.bounds.size.height/2)];
        UIImageView *topLeftMenuPic = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"menu_tl.jpg"]];
        [topLeftMenuPic setFrame:CGRectMake(0, 0, topLeft.bounds.size.width, topLeft.bounds.size.height)];
        [topLeft addSubview:topLeftMenuPic];
        topLeft.selectiveBorderFlag = AUISelectiveBordersFlagRight | AUISelectiveBordersFlagBottom;
        topLeft.selectiveBordersColor = [UIColor blackColor];
        topLeft.selectiveBordersWidth = 0;
        [self addSubview:topLeft];
        
        topRight = [[UIView alloc] initWithFrame:CGRectMake(self.bounds.size.width, 0, self.bounds.size.width/2, self.bounds.size.height/2)];
        UIImageView *topRightMenuPic = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"menu_tr.jpg"]];
        [topRightMenuPic setFrame:CGRectMake(0, 0, topRight.bounds.size.width, topRight.bounds.size.height)];
        [topRight addSubview:topRightMenuPic];
        topRight.selectiveBorderFlag = AUISelectiveBordersFlagLeft | AUISelectiveBordersFlagBottom;
        topRight.selectiveBordersColor = [UIColor blackColor];
        topRight.selectiveBordersWidth = 0;
        [self addSubview:topRight];
        
        bottomLeft = [[UIView alloc] initWithFrame:CGRectMake(-(self.bounds.size.width/2), self.bounds.size.height/2, self.bounds.size.width/2, self.bounds.size.height/2)];
        UIImageView *bottomLeftMenuPic = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"menu_bl.jpg"]];
        [bottomLeftMenuPic setFrame:CGRectMake(0, 0, bottomLeft.bounds.size.width, topLeft.bounds.size.height)];
        [bottomLeft addSubview:bottomLeftMenuPic];
        bottomLeft.selectiveBorderFlag = AUISelectiveBordersFlagRight | AUISelectiveBordersFlagTop;
        bottomLeft.selectiveBordersColor = [UIColor blackColor];
        bottomLeft.selectiveBordersWidth = 0;
        [self addSubview:bottomLeft];
        
        bottomRight = [[UIView alloc] initWithFrame:CGRectMake(self.bounds.size.width/2, self.bounds.size.height, self.bounds.size.width/2, self.bounds.size.height/2)];
        UIImageView *bottomRightMenuPic = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"menu_br.jpg"]];
        [bottomRightMenuPic setFrame:CGRectMake(0, 0, bottomRight.bounds.size.width, bottomRight.bounds.size.height)];
        [bottomRight addSubview:bottomRightMenuPic];
        bottomRight.selectiveBorderFlag = AUISelectiveBordersFlagLeft | AUISelectiveBordersFlagTop;
        bottomRight.selectiveBordersColor = [UIColor blackColor];
        bottomRight.selectiveBordersWidth = 0;
        [self addSubview:bottomRight];

        
        
        UIButton *btnClose = [[UIButton alloc] initWithFrame:CGRectMake(topRight.bounds.size.width-30, 10, 20, 20)];
        [btnClose setBackgroundImage:[UIImage imageNamed:@"menu_close"] forState:UIControlStateNormal];
        [btnClose addTarget:self action:@selector(btnClose_onclick) forControlEvents:UIControlEventTouchUpInside];
        [topRight addSubview:btnClose];
        
        
        
        UIButton *btnCreateMusic = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btnCreateMusic setFrame:CGRectMake(10, 10, 150, 40)];
        [btnCreateMusic setTitle:@"Create Music" forState:UIControlStateNormal];
        [btnCreateMusic addTarget:self action:@selector(btnCreateMusic_onclick) forControlEvents:UIControlEventTouchUpInside];
        [topLeft addSubview:btnCreateMusic];
        
        UIButton *btnMusicTraining = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btnMusicTraining setFrame:CGRectMake(10, 10, 150, 40)];
        [btnMusicTraining setTitle:@"Music Training" forState:UIControlStateNormal];
        [btnMusicTraining addTarget:self action:@selector(btnMusicTraining_onclick) forControlEvents:UIControlEventTouchUpInside];
        [topRight addSubview:btnMusicTraining];
        
        UIButton *btnEarTraining = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btnEarTraining setFrame:CGRectMake(10, 10, 150, 40)];
        [btnEarTraining setTitle:@"Ear Training" forState:UIControlStateNormal];
        [btnEarTraining addTarget:self action:@selector(btnEarTraining_onclick) forControlEvents:UIControlEventTouchUpInside];
        [bottomLeft addSubview:btnEarTraining];
        
        UIButton *btnTuner = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btnTuner setFrame:CGRectMake(10, 10, 150, 40)];
        [btnTuner setTitle:@"Tuner" forState:UIControlStateNormal];
        [btnTuner addTarget:self action:@selector(btnTuner_onclick) forControlEvents:UIControlEventTouchUpInside];
        [bottomRight addSubview:btnTuner];
    }
    return self;
}


-(void) btnCreateMusic_onclick {
    [(fypViewController *)_controller changeToCreateMusic];
}


-(void) btnMusicTraining_onclick {
    [(fypViewController *)_controller changeToMusicTraining];
}

-(void) btnEarTraining_onclick {
    [(fypViewController *)_controller changeToEarTraining];
}

-(void) btnTuner_onclick {
    [(fypViewController *)_controller changeToTuner];
}

-(void)setViewController:(UIViewController *)controller {
    _controller = controller;
}


-(void)openMenu {
    topLeft.selectiveBordersWidth = 1;
    topRight.selectiveBordersWidth = 1;
    bottomLeft.selectiveBordersWidth = 1;
    bottomRight.selectiveBordersWidth = 1;
    [self.superview bringSubviewToFront:self];
    
    CGRect newTopLeftFrame = topLeft.frame;
    newTopLeftFrame.origin.y = 0;
    CGRect newTopRightFrame = topRight.frame;
    newTopRightFrame.origin.x = self.bounds.size.width/2;
    CGRect newBottomLeftFrame = bottomLeft.frame;
    newBottomLeftFrame.origin.x = 0;
    CGRect newBottomRightFrame = bottomRight.frame;
    newBottomRightFrame.origin.y = self.bounds.size.height/2;
    
    [UIView beginAnimations:@"openMenu" context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDidStopSelector:@selector(removeBorder)];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationDelegate:self];
    
    [topLeft setFrame:newTopLeftFrame];
    [topRight setFrame:newTopRightFrame];
    [bottomLeft setFrame:newBottomLeftFrame];
    [bottomRight setFrame:newBottomRightFrame];
    
    [UIView commitAnimations];
}

-(void)removeBorder {
    topLeft.selectiveBordersWidth = 0;
    topRight.selectiveBordersWidth = 0;
    bottomLeft.selectiveBordersWidth = 0;
    bottomRight.selectiveBordersWidth = 0;
}


-(void)btnClose_onclick {
    [self closeMenu];
}


-(void)closeMenu {
    topLeft.selectiveBordersWidth = 1;
    topRight.selectiveBordersWidth = 1;
    bottomLeft.selectiveBordersWidth = 1;
    bottomRight.selectiveBordersWidth = 1;
    
    CGRect newTopLeftFrame = topLeft.frame;
    newTopLeftFrame.origin.y = -(self.bounds.size.height/2);
    CGRect newTopRightFrame = topRight.frame;
    newTopRightFrame.origin.x = self.bounds.size.width;
    CGRect newBottomLeftFrame = bottomLeft.frame;
    newBottomLeftFrame.origin.x = -(self.bounds.size.width/2);
    CGRect newBottomRightFrame = bottomRight.frame;
    newBottomRightFrame.origin.y = self.bounds.size.height;
    
    [UIView beginAnimations:@"closeMenu" context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDidStopSelector:@selector(addBorder)];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationDelegate:self];
    
    [topLeft setFrame:newTopLeftFrame];
    [topRight setFrame:newTopRightFrame];
    [bottomLeft setFrame:newBottomLeftFrame];
    [bottomRight setFrame:newBottomRightFrame];
    
    [UIView commitAnimations];
}

-(void) addBorder {
    [self.superview sendSubviewToBack:self];
    topLeft.selectiveBordersWidth = 0;
    topRight.selectiveBordersWidth = 0;
    bottomLeft.selectiveBordersWidth = 0;
    bottomRight.selectiveBordersWidth = 0;
}

@end
