//
//  fypLineBox.m
//  fyp
//
//  Created by Tse Siu Fai on 13年3月12日.
//  Copyright (c) 2013年 cityu. All rights reserved.
//

#import "fypLineBox.h"
#import "UIView+AUISelectiveBorder.h"
#import <QuartzCore/QuartzCore.h>


@implementation fypLineBox

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _fixed = false;
        self.selectiveBorderFlag = AUISelectiveBordersFlagRight | AUISelectiveBordersFlagLeft | AUISelectiveBordersFlagTop | AUISelectiveBordersFlagBottom;
        self.selectiveBordersColor = [UIColor blackColor];
        self.selectiveBordersWidth = 1;
        
        _line = -1;
    }
    return self;
}

- (void)setFixed:(Boolean)fixed {
    _fixed = fixed;
}

- (Boolean)isFixed {
    return _fixed;
}


- (void)setLine:(int)line {
    _line = line;
}

- (int)getLine {
    return _line;
}


- (void) setBackgroundColor:(UIColor *)backgroundColor {
    if(!_fixed) {
        [super setBackgroundColor:backgroundColor];
    }
}

- (void)setColumn:(int)column {
    _column = column;
}

- (int)getColumn {
    return _column;
}


@end
