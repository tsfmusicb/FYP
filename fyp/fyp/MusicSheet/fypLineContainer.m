//  fypLineContainer.m
//  fyp
//
//  Created by Tse Siu Fai on 13年3月12日.
//  Copyright (c) 2013年 cityu. All rights reserved.
//

#import "fypLineContainer.h"
#import "fypLineBox.h"
#import "UIView+AUISelectiveBorder.h"
#import <QuartzCore/QuartzCore.h>
#import "MIDI.h"
#import "fypMIDIPlayer.h"
#import "GDSoundEngine.h"



@implementation fypLineContainer

@synthesize samplerUnit = _samplerUnit;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setShowsHorizontalScrollIndicator:NO];
        
        chords = [[NSMutableArray alloc] init];
        
        mementoUndoList = [[NSMutableArray alloc] init];
        mementoRedoList = [[NSMutableArray alloc] init];
        
        allBoxes = [[NSMutableArray alloc] init];
        for(int i=0; i<7; i++) {
            NSMutableArray *lineBoxes = [[NSMutableArray alloc] init];
            [allBoxes addObject:lineBoxes];
        }
        
        chordBoxes = [[NSMutableArray alloc] init];
        isSelectChord = NO;

    }
    return self;
}


- (void)setupScrollbar:(int)y width:(int)w {
    scrollBar = [[fypScrollbar alloc] initWithFrame:CGRectMake(5, y, w, 10)];
    [self.superview addSubview:scrollBar];
    [self.superview sendSubviewToBack:scrollBar];
}


- (void)generate_20_Boxes_A_Line {
    // A box width:70, height:30
    
    colors = [NSMutableArray array];
    for (float hue = 0.0; hue < 1.0; hue += 0.02) {
        UIColor *color = [UIColor colorWithHue:hue saturation:1.0 brightness:1.0 alpha:0.1];
        [colors addObject:color];
    }
    
    int currentX = 0, currentY = 0;
    for(int i=0; i<allBoxes.count; i++) {
        for(int j=0; j<50; j++) {
            fypLineBox *box = [[fypLineBox alloc] initWithFrame:CGRectMake(currentX, currentY, 70, 30)];
            [box setBackgroundColor:colors[j]];
            [box setColumn:j];
            [self addSubview:box];
            [box setLine:i+1];
            [allBoxes[i] addObject:box];
            currentX += 70;
        }
        currentX = 0;
        currentY += 30;
    }
    
    
    currentX = 0;
    for(int j=0; j<50; j++) {
        fypLineBox *box = [[fypLineBox alloc] initWithFrame:CGRectMake(currentX, currentY+20, 70, 30)];
        [box setBackgroundColor:colors[j]];
        [self addSubview:box];
        [box setLine:8];
        [box setColumn:j];
        [chordBoxes addObject:box];
        currentX += 70;
    }
    
    
    
    self.contentSize = CGSizeMake(self.contentSize.width + (50*70), self.bounds.size.height);
}

- (void)undo {
    if(mementoUndoList.count == 0) return;
    
    colors = [NSMutableArray array];
    for (float hue = 0.0; hue < 1.0; hue += 0.05) {
        UIColor *color = [UIColor colorWithHue:hue saturation:1.0 brightness:1.0 alpha:0.1];
        [colors addObject:color];
    }
    
    NSMutableArray *temp = mementoUndoList[mementoUndoList.count-1];
    for(fypLineBox *box in temp) {
        box.selectiveBorderFlag = AUISelectiveBordersFlagRight | AUISelectiveBordersFlagLeft | AUISelectiveBordersFlagTop | AUISelectiveBordersFlagBottom;
        [box setBackgroundColor:colors[box.getColumn]];
        
    }
    [mementoRedoList addObject:temp];
    [mementoUndoList removeLastObject];
}

- (void)redo {
    if(mementoRedoList.count == 0) return;
    NSMutableArray *temp = mementoRedoList[mementoRedoList.count-1];
    [self setBorderAndColorToBoxes: temp];
    [mementoUndoList addObject:temp];
    [mementoRedoList removeLastObject];
}

-(void) convertNotesToMIDI{
    NSMutableArray *notes = [[NSMutableArray alloc] init];
    NSMutableArray *times = [[NSMutableArray alloc] init];
    NSMutableArray *chordTimes = [[NSMutableArray alloc] init];

    for(NSMutableArray *boxSet in mementoUndoList) {
        NSString *noteStr = nil;
        switch (((fypLineBox *)boxSet[0]).getLine) {
            case 1:
                noteStr = @"b";
                break;
            case 2:
                noteStr = @"a";
                break;
            case 3:
                noteStr = @"g";
                break;
            case 4:
                noteStr = @"f";
                break;
            case 5:
                noteStr = @"e";
                break;
            case 6:
                noteStr = @"d";
                break;
            case 7:
                noteStr = @"c";
                break;
            case 8:
                noteStr = @"chord";
                [chordTimes addObject:[NSString stringWithFormat:@"%.1f", boxSet.count*0.5]];
                break;
            default:
                break;
        }
        if(![noteStr isEqual: @"chord"]){
            [notes addObject:noteStr];
            [times addObject:[NSString stringWithFormat:@"%.1f", boxSet.count*0.5]];
        }
    }
    
    NSString *outFile = @"test.mid";
    
    MIDI *mid = [[MIDI alloc] initWithOut:outFile];
    [mid writeFile:notes times:times chord:chords chordTimes:chordTimes];
    
    NSString *midiFilePath = [NSTemporaryDirectory() stringByAppendingString:outFile];
    
    NSString *soundFontPath = [[NSBundle mainBundle] pathForResource:@"gs_instruments" ofType:@"dls"];
    
    //Play it
    GDSoundEngine *midiPlayer = [[GDSoundEngine alloc] init];
    [midiPlayer setSoundFontAndMidFile:midiFilePath SoundFont:soundFontPath];
    [midiPlayer playMIDIFile];
}

-(void) playLastNote{
    NSMutableArray *tempNotes = [[NSMutableArray alloc] init];
    NSMutableArray *tempTimes = [[NSMutableArray alloc] init];
    NSMutableArray *tempChordTimes = [[NSMutableArray alloc] init];
    NSMutableArray *tempChords = [[NSMutableArray alloc] init];

    NSMutableArray *boxSet = mementoUndoList[mementoUndoList.count-1];
    NSString *noteStr = nil;
    switch (((fypLineBox *)boxSet[0]).getLine) {
        case 1:
            noteStr = @"b";
            break;
        case 2:
            noteStr = @"a";
            break;
        case 3:
            noteStr = @"g";
            break;
        case 4:
            noteStr = @"f";
            break;
        case 5:
            noteStr = @"e";
            break;
        case 6:
            noteStr = @"d";
            break;
        case 7:
            noteStr = @"c";
            break;
        case 8:
            noteStr = @"chord";
            [tempChordTimes addObject:[NSString stringWithFormat:@"%.1f", boxSet.count*0.5]];
            [tempChords addObject:chords[chords.count-1]];
            break;
        default:
            break;
    }
    if(![noteStr isEqual: @"chord"]){
        [tempNotes addObject:noteStr];
        [tempTimes addObject:[NSString stringWithFormat:@"%.1f", boxSet.count*0.5]];
    }
    
    
    NSString *outFile = @"test.mid";

    MIDI *mid = [[MIDI alloc] initWithOut:outFile];
    [mid writeFile:tempNotes times:tempTimes chord:tempChords chordTimes:tempChordTimes];
    
    NSString *midiFilePath = [NSTemporaryDirectory() stringByAppendingString:outFile];
    
    //Play it
    //fypMIDIPlayer *midiPlayer = [[fypMIDIPlayer alloc] initWithMIDIFile:midiFilePath];
    //[midiPlayer playMIDI];
    
    
    //NSString *presetURLPath = [[NSBundle mainBundle] pathForResource:@"GortsMiniPianoJ1" ofType:@"SF2"];
    //NSURL * presetURL = [NSURL fileURLWithPath:presetURLPath];
    //[self loadFromDLSOrSoundFont: (NSURL *)presetURL withPatch: (int)3];
    
    NSString *soundFontPath = [[NSBundle mainBundle] pathForResource:@"gs_instruments" ofType:@"dls"];
    GDSoundEngine *midiPlayer = [[GDSoundEngine alloc] init];
    [midiPlayer setSoundFontAndMidFile:midiFilePath SoundFont:soundFontPath];
    [midiPlayer playMIDIFile];
}



-(OSStatus) loadFromDLSOrSoundFont: (NSURL *)bankURL withPatch: (int)presetNumber {

    OSStatus result = noErr;

    // fill out a bank preset data structure
    AUSamplerBankPresetData bpdata;
    bpdata.bankURL  = (CFURLRef) bankURL;
    bpdata.bankMSB  = kAUSampler_DefaultMelodicBankMSB;
    bpdata.bankLSB  = kAUSampler_DefaultBankLSB;
    bpdata.presetID = (UInt8) presetNumber;

    // set the kAUSamplerProperty_LoadPresetFromBank property
    result = AudioUnitSetProperty(self.samplerUnit,
                                  kAUSamplerProperty_LoadPresetFromBank,
                                  kAudioUnitScope_Global,
                                  0,
                                  &bpdata,
                                  sizeof(bpdata));

    // check for errors
    NSCAssert (result == noErr,
               @"Unable to set the preset property on the Sampler. Error code:%d '%.4s'",
               (int) result,
               (const char *)&result);

    return result;
}



- (void)AwesomeMenu:(AwesomeMenu *)menu didSelectIndex:(NSInteger)idx
{
    NSArray *chordMap = [[NSArray alloc] initWithObjects:@"c",@"d",@"e",@"d",@"g",@"a",@"b", nil];
    [chords addObject:chordMap[6-idx]];
    [_menu removeFromSuperview];
    [self playLastNote];
}
- (void)AwesomeMenuDidFinishAnimationClose:(AwesomeMenu *)menu {
    [_menu removeFromSuperview];
}





- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    Boolean isClickOnBoxes = false;
    for(NSMutableArray *lineBoxes in allBoxes) {
        for(fypLineBox *box in lineBoxes) {
            if(CGRectContainsPoint(box.frame, point)) {
                [mementoRedoList removeAllObjects];
                selectedLine = lineBoxes;
                isClickOnBoxes = true;
                self.scrollEnabled = NO;
                isSelectChord = NO;
                break;
            }
        }
        if(isClickOnBoxes) break;
    }
    if(!isClickOnBoxes) {
        for(fypLineBox *box in chordBoxes) {
            if(CGRectContainsPoint(box.frame, point)) {
                selectedLine = chordBoxes;
                isClickOnBoxes = true;
                self.scrollEnabled = NO;
                isSelectChord = YES;
                break;
            }
        }
    }
    if(!isClickOnBoxes) self.scrollEnabled = YES;
    return [super hitTest:point withEvent:event];
}




#pragma mark - DRAG AND DROP

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if(self.scrollEnabled == NO) {
        for(NSMutableArray *lineBoxes in allBoxes) {
            if(lineBoxes == selectedLine) continue;
            else {
                for(fypLineBox *box in lineBoxes) {
                    box.selectiveBordersColor = [UIColor lightGrayColor];
                }
            }
        }
    }
}

-(void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    for(fypLineBox *box in selectedLine) {
        if(CGRectContainsPoint(box.frame, [touch locationInView:self]) && !box.isFixed) {
            [box setBackgroundColor:[UIColor blackColor]];
            [box setFixed:true];
        }
    }
}

-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    selectedBoxes = [[NSMutableArray alloc] init];
    for(fypLineBox *box in selectedLine) {
        if(box.isFixed) {
            [selectedBoxes addObject:box];
        }
    }
    
    if(selectedBoxes.count == 3){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please Start Compose with <1> <2> <4> but not <3> Boxes"
                                                       delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }else if (selectedBoxes.count > 4){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please Do not Select the note longer than <4> Boxes"
                                                       delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }else{
        if(selectedBoxes.count != 0) [mementoUndoList addObject:selectedBoxes];

        [self setBorderAndColorToBoxes: selectedBoxes];
    
        for(NSMutableArray *lineBoxes in allBoxes) {
            if(lineBoxes == selectedLine) continue;
            else {
                for(fypLineBox *box in lineBoxes) {
                    box.selectiveBordersColor = [UIColor blackColor];
                }
            }
        }
    
        if(isSelectChord) {
            UIImage *storyMenuItemImage = [UIImage imageNamed:@"bg-menuitem.png"];
            UIImage *storyMenuItemImagePressed = [UIImage imageNamed:@"bg-menuitem-highlighted.png"];
            
            //UIImage *starImage = [UIImage imageNamed:@"icon-star.png"];
            UIImage *chordI_Image = [UIImage imageNamed:@"chordI.png"];
            UIImage *chordII_Image = [UIImage imageNamed:@"chordII.png"];
            UIImage *chordIII_Image = [UIImage imageNamed:@"chordIII.png"];
            UIImage *chordIV_Image = [UIImage imageNamed:@"chordIV.png"];
            UIImage *chordV_Image = [UIImage imageNamed:@"chordV.png"];
            UIImage *chordVI_Image = [UIImage imageNamed:@"chordVI.png"];
            UIImage *chordVII_Image = [UIImage imageNamed:@"chordVII.png"];
            
            AwesomeMenuItem *starMenuItem1 = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage
                                                                   highlightedImage:storyMenuItemImagePressed
                                                                       ContentImage:chordVII_Image
                                                            highlightedContentImage:nil];
            AwesomeMenuItem *starMenuItem2 = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage
                                                                   highlightedImage:storyMenuItemImagePressed
                                                                       ContentImage:chordVI_Image
                                                            highlightedContentImage:nil];
            AwesomeMenuItem *starMenuItem3 = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage
                                                                   highlightedImage:storyMenuItemImagePressed
                                                                       ContentImage:chordV_Image
                                                            highlightedContentImage:nil];
            AwesomeMenuItem *starMenuItem4 = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage
                                                                   highlightedImage:storyMenuItemImagePressed
                                                                       ContentImage:chordIV_Image
                                                            highlightedContentImage:nil];
            AwesomeMenuItem *starMenuItem5 = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage
                                                                   highlightedImage:storyMenuItemImagePressed
                                                                       ContentImage:chordIII_Image
                                                            highlightedContentImage:nil];
            AwesomeMenuItem *starMenuItem6 = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage
                                                                   highlightedImage:storyMenuItemImagePressed
                                                                       ContentImage:chordII_Image
                                                            highlightedContentImage:nil];
            AwesomeMenuItem *starMenuItem7 = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage
                                                                   highlightedImage:storyMenuItemImagePressed
                                                                       ContentImage:chordI_Image
                                                            highlightedContentImage:nil];
            
            
            NSArray *menus = [NSArray arrayWithObjects:starMenuItem1, starMenuItem2, starMenuItem3, starMenuItem4, starMenuItem5, starMenuItem6, starMenuItem7, nil];
            
            _menu = [[AwesomeMenu alloc] initWithFrame:self.window.bounds menus:menus];
            
            _menu.startPoint = CGPointMake(([[self.layer presentationLayer] bounds].origin.x + (self.bounds.size.width/2)), self.bounds.size.height/2+50);
            _menu.rotateAngle = M_PI/2.35;
            _menu.menuWholeAngle = -(M_PI);
            _menu.farRadius = 150.0f;
            _menu.endRadius = 100.0f;
            _menu.nearRadius = 80.0f;
            _menu.delegate = self;
            [self addSubview:_menu];
            [_menu setExpanding:YES];
        }else{
            [self playLastNote];
        }
    }
}


- (void) setBorderAndColorToBoxes:(NSMutableArray *)boxes {
    UIColor *randColor = [self darkerColor];
    
    if(boxes.count == 1) {
        [boxes[0] setFixed:false];
        [boxes[0] setBackgroundColor:randColor];
    } else {
        for(int i=0; i<boxes.count; i++) {
            [boxes[i] setFixed:false];
            if(i == 0) {
                ((fypLineBox *)boxes[i]).selectiveBorderFlag = AUISelectiveBordersFlagTop | AUISelectiveBordersFlagBottom | AUISelectiveBordersFlagLeft;
            } else if(i == boxes.count-1) {
                ((fypLineBox *)boxes[i]).selectiveBorderFlag = AUISelectiveBordersFlagTop | AUISelectiveBordersFlagBottom | AUISelectiveBordersFlagRight;
            } else {
                ((fypLineBox *)boxes[i]).selectiveBorderFlag = AUISelectiveBordersFlagTop | AUISelectiveBordersFlagBottom;
            }
            [boxes[i] setBackgroundColor:randColor];
            
        }
    }
}

- (UIColor *)darkerColor
{
    UIColor *color = [UIColor colorWithRed:((CGFloat)arc4random() / (CGFloat)RAND_MAX)
                                    green:((CGFloat)arc4random() / (CGFloat)RAND_MAX)
                                     blue:((CGFloat)arc4random() / (CGFloat)RAND_MAX)
                                    alpha:1.0];
    float h, s, b, a;
    if ([color getHue:&h saturation:&s brightness:&b alpha:&a])
        return [UIColor colorWithHue:h
                          saturation:s
                          brightness:b * 0.75
                               alpha:a];
    return nil;
}

@end
