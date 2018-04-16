//
//  fypLineContainer.h
//  fyp
//
//  Created by Tse Siu Fai on 13年3月12日.
//  Copyright (c) 2013年 cityu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/MusicPlayer.h>
#import "fypScrollbar.h"
#import "AwesomeMenu.h"

@interface fypLineContainer : UIScrollView <AwesomeMenuDelegate> {
    NSMutableArray *allBoxes;
    NSMutableArray *selectedLine;
    NSMutableArray *selectedBoxes;
    
    NSMutableArray *chords;
    
    NSMutableArray *chordBoxes;
    Boolean isSelectChord;
    
    NSMutableArray *mementoUndoList;
    NSMutableArray *mementoRedoList;
    
    fypScrollbar *scrollBar;
    
    NSMutableArray *colors;
    AwesomeMenu *_menu;
}


@property(readwrite) AudioUnit samplerUnit;

- (void)setupScrollbar:(int)y width:(int)w;
- (void)generate_20_Boxes_A_Line;

- (void)undo;
- (void)redo;

- (void)convertNotesToMIDI;

@end
