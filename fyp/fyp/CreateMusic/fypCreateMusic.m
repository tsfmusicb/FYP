//
//  fypCreateMusic.m
//  fyp
//
//  Created by Tse Siu Fai on 13年3月23日.
//  Copyright (c) 2013年 cityu. All rights reserved.
//

#import "fypCreateMusic.h"
#import "UIView+AUISelectiveBorder.h"
#import "readfileViewController.h"
#import "fypAppDelegate.h"

@implementation fypCreateMusic

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        //////////////////////////add MusicSheet////////////////////////////
        
        //Notes Label
        NSArray *txt_notes = [[NSArray alloc] initWithObjects:@"B", @"A", @"G", @"F", @"E", @"D", @"C", nil];
        int currentY = 5;
        for(int i=0; i<txt_notes.count; i++) {
            UILabel *lblNote = [[UILabel alloc] initWithFrame:CGRectMake(5, currentY, 20, 30)];
            [lblNote setText:txt_notes[i]];
            lblNote.selectiveBorderFlag = AUISelectiveBordersFlagRight;
            lblNote.selectiveBordersColor = [UIColor blackColor];
            lblNote.selectiveBordersWidth = 3;
            [self addSubview:lblNote];
            currentY += 30;
        }
        
        //Chord Label
        UILabel *lblNote = [[UILabel alloc] initWithFrame:CGRectMake(5, currentY+20, 20, 30)];
        [lblNote setText:@"ch."];
        lblNote.font = [lblNote.font fontWithSize:12];
        lblNote.selectiveBorderFlag = AUISelectiveBordersFlagRight;
        lblNote.selectiveBordersColor = [UIColor blackColor];
        lblNote.selectiveBordersWidth = 3;
        [self addSubview:lblNote];
        
        //MusicSheet
        lineContainer = [[fypLineContainer alloc] initWithFrame:CGRectMake(25, 5, self.bounds.size.width-25, currentY+45)];
        [self addSubview:lineContainer];
        //Gen 20 columns boxes at first
        [lineContainer generate_20_Boxes_A_Line];
        
        ////////////////////////////////////////////////////////////////////
        
        
        
        
        ///////////add MiddleLine(scrollbar & metronome & undo/redo)////////
        
        //Scrollbar
        [lineContainer setupScrollbar:currentY+5 width:self.bounds.size.width-55-55-100-65 ];
        
        //Metronome
        double bpm = 60.0/80.0; int beat = 4;
        metronome = [[fypMetronome alloc] initWithFrameAndSetting:CGRectMake(self.bounds.size.width-55-55-155, currentY+5, 95, 10) :bpm :beat];
        [self addSubview:metronome];
        
        //Undo Button
        UIButton *btnUndoMusicSheet = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btnUndoMusicSheet setFrame:CGRectMake(self.bounds.size.width-55-55, currentY+5, 50, 12)];
        [btnUndoMusicSheet setTitle:@"Undo" forState:UIControlStateNormal];
        btnUndoMusicSheet.titleLabel.font = [UIFont systemFontOfSize:12];
        [btnUndoMusicSheet addTarget:self action:@selector(btnUndoMusicSheet_onclick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnUndoMusicSheet];
        
        //Redo Button
        UIButton *btnRedoMusicSheet = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btnRedoMusicSheet setFrame:CGRectMake(self.bounds.size.width-55, currentY+5, 50, 12)];
        [btnRedoMusicSheet setTitle:@"Redo" forState:UIControlStateNormal];
        btnRedoMusicSheet.titleLabel.font = [UIFont systemFontOfSize:12];
        [btnRedoMusicSheet addTarget:self action:@selector(btnRedoMusicSheet_onclick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnRedoMusicSheet];
        
        //Open File
        UIButton *btnOpenFile = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btnOpenFile setFrame:CGRectMake(self.bounds.size.width-55-55-55, currentY+5, 50, 12)];
        [btnOpenFile setTitle:@"Open" forState:UIControlStateNormal];
        btnOpenFile.titleLabel.font = [UIFont systemFontOfSize:12];
        [btnOpenFile addTarget:self action:@selector(btnOpenFile_onclick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnOpenFile];
        ////////////////////////////////////////////////////////////////////
        
        UIView *bottomBar = [[UIView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height-30, self.bounds.size.width, 30)];
        [bottomBar setBackgroundColor:[UIColor blackColor]];
        [self addSubview: bottomBar];
        
        
        UIButton *btnMenu = [[UIButton alloc] initWithFrame:CGRectMake(5, 5, 20, 20)];
        [btnMenu setBackgroundImage:[UIImage imageNamed:@"menu"] forState:UIControlStateNormal];
        [btnMenu addTarget:self action:@selector(btnMenu_onclick) forControlEvents:UIControlEventTouchUpInside];
        [bottomBar addSubview:btnMenu];

        
        UIButton *btnOutputMusicSheet = [[UIButton alloc] initWithFrame:CGRectMake(bottomBar.bounds.size.width-20-5, 5, 20, 20)];
        [btnOutputMusicSheet setBackgroundImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
        [btnOutputMusicSheet addTarget:self action:@selector(btnOutputMusicSheet_onclick) forControlEvents:UIControlEventTouchUpInside];
        [bottomBar addSubview:btnOutputMusicSheet];
        
        
        UIButton *btnMetronome = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btnMetronome setFrame:CGRectMake(100, 5, 140, 20)];
        [btnMetronome setTitle:@"Metronome" forState:UIControlStateNormal];
        [btnMetronome addTarget:self action:@selector(btnMetronome_onclick:) forControlEvents:UIControlEventTouchUpInside];
        [bottomBar addSubview:btnMetronome];
        
        
        // -- Accelerometer
        
        accelerometer = [[fypAccelerometer alloc] init];
        UIButton *btnAccelerometer = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btnAccelerometer setFrame:CGRectMake(250, 5, 140, 20)];
        [btnAccelerometer setTitle:@"Accelerometer" forState:UIControlStateNormal];
        [btnAccelerometer addTarget:self action:@selector(btnAccelerometer_onclick:) forControlEvents:UIControlEventTouchUpInside];
        [bottomBar addSubview:btnAccelerometer];
    }
    return self;
}


-(void)setMenu:(fypMenu *)menu {
    _menu = menu;
}


- (void) btnMenu_onclick {
    [_menu openMenu];
}

/*- (void) btnAccelerometer_onclick {
    
    [accelerometer playAndStop];
}*/

- (void) btnUndoMusicSheet_onclick {
    [lineContainer undo];
}
- (void) btnRedoMusicSheet_onclick {
    [lineContainer redo];
}

- (void) btnOutputMusicSheet_onclick {
    [lineContainer convertNotesToMIDI];
}

- (void) btnOpenFile_onclick {
    fypAppDelegate *appDelegate = (fypAppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate openFile];
}

- (IBAction)btnMetronome_onclick: (id)sender {
    if([[[(UIButton *) sender titleLabel] text] isEqualToString:@"Metronome"]) {
        [(UIButton *) sender setTitle:@"Stop" forState:UIControlStateNormal];
        [metronome startBeat];
    } else {
        [(UIButton *) sender setTitle:@"Metronome" forState:UIControlStateNormal];
        [metronome stopBeat];
    }
}

- (IBAction)btnAccelerometer_onclick: (id)sender {
    if([[[(UIButton *) sender titleLabel] text] isEqualToString:@"Accelerometer"]) {
        [(UIButton *) sender setTitle:@"Stop" forState:UIControlStateNormal];
    } else {
        [(UIButton *) sender setTitle:@"Accelerometer" forState:UIControlStateNormal];
    }
    [accelerometer playAndStop];
}

@end
