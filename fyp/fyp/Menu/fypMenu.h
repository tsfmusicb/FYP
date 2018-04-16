//
//  fypMenu.h
//  fyp
//
//  Created by Tse Siu Fai on 13年3月23日.
//  Copyright (c) 2013年 cityu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface fypMenu : UIView {
    UIViewController *_controller;
    
    UIView *topLeft;
    UIView *topRight;
    UIView *bottomLeft;
    UIView *bottomRight;
}

-(void)setViewController:(UIViewController *)controller;

-(void)openMenu;
-(void)closeMenu;

@end
