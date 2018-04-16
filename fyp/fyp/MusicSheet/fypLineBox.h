//
//  fypLineBox.h
//  fyp
//
//  Created by Tse Siu Fai on 13年3月12日.
//  Copyright (c) 2013年 cityu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface fypLineBox : UIView {
    Boolean _fixed;
    int _line;
    int _column;
}

- (void)setFixed:(Boolean)fixed;
- (Boolean)isFixed;

- (void)setLine:(int)line;
- (int)getLine;

- (void)setColumn:(int)column;
- (int)getColumn;

@end
