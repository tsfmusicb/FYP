//
//  fypScrollbar.m
//  fyp
//
//  Created by Tse Siu Fai on 13年3月23日.
//  Copyright (c) 2013年 cityu. All rights reserved.
//

#import "fypScrollbar.h"
#import "UIView+AUISelectiveBorder.h"

@implementation fypScrollbar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImage *img = [UIImage imageNamed:@"left_arrow"];
        UIImageView *leftArrowPic = [[UIImageView alloc] initWithImage:img];
        [leftArrowPic setFrame:CGRectMake(0, 0, 6, self.bounds.size.height)];
        [self addSubview:leftArrowPic];
        
        UILabel *lbl_bar = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.bounds.size.width - 20, self.bounds.size.height)];
        [lbl_bar setText:@" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - "];
        lbl_bar.adjustsFontSizeToFitWidth = NO;
        [lbl_bar setLineBreakMode:NSLineBreakByClipping];
        [self addSubview:lbl_bar];
        
        img = [UIImage imageNamed:@"right_arrow"];
        UIImageView *rightArrowPic = [[UIImageView alloc] initWithImage:img];
        [rightArrowPic setFrame:CGRectMake(self.bounds.size.width-6, 0, 6, self.bounds.size.height)];
        [self addSubview:rightArrowPic];
        
        self.userInteractionEnabled = NO;
    }
    return self;
}




@end
