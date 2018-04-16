//
//  fypEarTraining.m
//  fyp
//
//  Created by Tse Siu Fai on 13年3月23日.
//  Copyright (c) 2013年 cityu. All rights reserved.
//

#import "fypEarTraining.h"

@implementation fypEarTraining

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //init value
        notes = [[NSArray alloc] initWithObjects:@"c",@"d",@"e",@"f",@"g",@"a",@"b", nil];
        currentNotePointer = 0;
        secCounter = 60; //defualt 60
        percentCounter = 0;
        userAnsNum = 0;
        userCorrectAnsNum = 0;
        firstNoteNum = 0;
        secondNoteNum = 0;
        interval = 0;
        at = [AudioTest audioTest];
        isRunning = false;
        
        timeLable = [[UILabel alloc] initWithFrame:CGRectMake(10, 220, 120, 80)];
        timeLable.text = [NSString stringWithFormat:@"Time: %d Sec", secCounter];
        [self addSubview:timeLable];
        
        scoreLable = [[UILabel alloc] initWithFrame:CGRectMake(140, 220, 120, 80)];
        scoreLable.text = [NSString stringWithFormat:@"Score: %d", scoreCounter];
        [self addSubview:scoreLable];
        
        percentLable = [[UILabel alloc] initWithFrame:CGRectMake(240, 220, 120, 80)];
        percentLable.text = [NSString stringWithFormat:@"Correct: %d%%", percentCounter];
        [self addSubview:percentLable];
        
        UIButton *btnMenu = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btnMenu setFrame:CGRectMake(5, frame.size.height-25, 70, 20)];
        [btnMenu setTitle:@"Menu" forState:UIControlStateNormal];
        [btnMenu addTarget:self action:@selector(btnMenu_onclick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnMenu];
        
        UIButton *btnStart = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btnStart setFrame:CGRectMake(120, frame.size.height-25, 100, 20)];
        [btnStart setTitle:@"Start" forState:UIControlStateNormal];
        [btnStart addTarget:self action:@selector(btnStart_onclick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnStart];
        
        UIButton *btnPlaySound = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btnPlaySound setFrame:CGRectMake(360, frame.size.height-25, 100, 20)];
        [btnPlaySound setTitle:@"Play Sound" forState:UIControlStateNormal];
        [btnPlaySound addTarget:self action:@selector(btnPlaySound_onclick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnPlaySound];
        
        UIButton *btnStop = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btnStop setFrame:CGRectMake(240, frame.size.height-25, 70, 20)];
        [btnStop setTitle:@"Stop" forState:UIControlStateNormal];
        [btnStop addTarget:self action:@selector(btnStop_onclick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnStop];
        
        
        int btnXPos = 5;
        UIButton *btnCNote = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btnCNote setFrame:CGRectMake(btnXPos, 5, 96, 30)];
        [btnCNote setTitle:@"Unison" forState:UIControlStateNormal];
        [btnCNote addTarget:self action:@selector(btnC_onclick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnCNote];
        
        btnXPos += 96;
        UIButton *btnDNote = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btnDNote setFrame:CGRectMake(btnXPos, 5, 96, 30)];
        [btnDNote setTitle:@"Major 2nd" forState:UIControlStateNormal];
        [btnDNote addTarget:self action:@selector(btnD_onclick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnDNote];
        
        btnXPos += 96;
        UIButton *btnENote = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btnENote setFrame:CGRectMake(btnXPos, 5, 96, 30)];
        [btnENote setTitle:@"Major 3rd" forState:UIControlStateNormal];
        [btnENote addTarget:self action:@selector(btnE_onclick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnENote];
        
        btnXPos += 96;
        UIButton *btnFNote = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btnFNote setFrame:CGRectMake(btnXPos, 5, 90, 30)];
        [btnFNote setTitle:@"Perfect 4th" forState:UIControlStateNormal];
        [btnFNote addTarget:self action:@selector(btnF_onclick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnFNote];
        
        btnXPos = 5;
        UIButton *btnGNote = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btnGNote setFrame:CGRectMake(btnXPos, 100, 96, 30)];
        [btnGNote setTitle:@"Perfect 5th" forState:UIControlStateNormal];
        [btnGNote addTarget:self action:@selector(btnG_onclick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnGNote];
        
        btnXPos += 95;
        UIButton *btnANote = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btnANote setFrame:CGRectMake(btnXPos, 100, 96, 30)];
        [btnANote setTitle:@"Major 6th" forState:UIControlStateNormal];
        [btnANote addTarget:self action:@selector(btnA_onclick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnANote];
        
        btnXPos += 95;
        UIButton *btnBNote = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btnBNote setFrame:CGRectMake(btnXPos, 100, 96, 30)];
        [btnBNote setTitle:@"Major 7th" forState:UIControlStateNormal];
        [btnBNote addTarget:self action:@selector(btnB_onclick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnBNote];
        
        //--- indicator image
        cIdxView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"blue"]];
        dIdxView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"blue"]];
        eIdxView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"blue"]];
        fIdxView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"blue"]];
        gIdxView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"blue"]];
        aIdxView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"blue"]];
        bIdxView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"blue"]];

        int viewPosx = 48;
        [cIdxView setFrame:CGRectMake(viewPosx, 40, 20, 20)];
        [self addSubview:cIdxView];
        
        viewPosx += 96;
        [dIdxView setFrame:CGRectMake(viewPosx, 40, 20, 20)];
        [self addSubview:dIdxView];
        
        viewPosx += 96;
        [eIdxView setFrame:CGRectMake(viewPosx, 40, 20, 20)];
        [self addSubview:eIdxView];
        
        viewPosx += 96;
        [fIdxView setFrame:CGRectMake(viewPosx, 40, 20, 20)];
        [self addSubview:fIdxView];
        
        viewPosx = 48;
        [gIdxView setFrame:CGRectMake(viewPosx, 140, 20, 20)];
        [self addSubview:gIdxView];
        
        viewPosx += 96;
        [aIdxView setFrame:CGRectMake(viewPosx, 140, 20, 20)];
        [self addSubview:aIdxView];
        
        viewPosx += 96;
        [bIdxView setFrame:CGRectMake(viewPosx, 140, 20, 20)];
        [self addSubview:bIdxView];
        
        //Instruction
        UIImageView *blueView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"blue"]];
        [blueView setFrame:CGRectMake(350, 190, 15, 15)];
        [self addSubview:blueView];
        UILabel *blueText = [[UILabel alloc] initWithFrame:CGRectMake(370, 190, 100, 15)];
        blueText.text = @"Possible";
        [self addSubview:blueText];
        
        UIImageView *redView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"red"]];
        [redView setFrame:CGRectMake(350, 210, 15, 15)];
        [self addSubview:redView];
        UILabel *redText = [[UILabel alloc] initWithFrame:CGRectMake(370, 210, 100, 15)];
        redText.text = @"Incorrect";
        [self addSubview:redText];
    }
    return self;
}

-(void) btnMenu_onclick{
    [_menu openMenu];
}

-(void)setMenu:(fypMenu *)menu {
    _menu = menu;
}

-(void) btnPlaySound_onclick{
    [self playSound];
}

-(void)playSound{
    NSString *time = @"Time1";
    NSString *fileName = [notes[firstNoteNum] stringByAppendingString:time];
    [at midiTest:fileName isInResource:YES];
    fileName = [notes[secondNoteNum] stringByAppendingString:time];
    [at midiTest:fileName isInResource:YES];
}

-(void) btnStop_onclick{
    if(isRunning)
        [self setStop];
}

-(void) btnStart_onclick{
    if(!isRunning)
        [self setStart];
}

-(void)setStart{
    [self resetTimer];
    [self startTimer];
    [self resetScoreAndCorrect];
    [self changeAllIndicateToBlue];
    isRunning = YES;
    [self playSound];
}

-(void)setStop{
    [self stopTimer];
    isRunning = NO;
    [self alertUserScore];
}

-(void) btnC_onclick{
    [self makeAnswer:0 view:cIdxView];
}

-(void) btnD_onclick{
    [self makeAnswer:1 view:dIdxView];
}

-(void) btnE_onclick{
    [self makeAnswer:2 view:eIdxView];
}

-(void) btnF_onclick{
    [self makeAnswer:3 view:fIdxView];
}

-(void) btnG_onclick{
    [self makeAnswer:4 view:gIdxView];
}

-(void) btnA_onclick{
    [self makeAnswer:5 view:aIdxView];
}

-(void) btnB_onclick{
    [self makeAnswer:6 view:bIdxView];
}

-(void) makeAnswer:(int)userAns view:(UIImageView*)idxView{
    if(isRunning){
        userAnsNum++;
        if(userAns == interval){
            //correct
            userCorrectAnsNum++;
            [self ranNoteNum];
            idxView.image = [UIImage imageNamed:@"green"];
            [self playSound];
            [self changeAllIndicateToBlue];
        }else{
            idxView.image = [UIImage imageNamed:@"red"];
        }
        [self updatePercentage];
        [self updateScore];
    }else{
        [self alertUserStart];
    }
}

-(void) changeAllIndicateToBlue{
    cIdxView.image = [UIImage imageNamed:@"blue"];
    dIdxView.image = [UIImage imageNamed:@"blue"];
    eIdxView.image = [UIImage imageNamed:@"blue"];
    fIdxView.image = [UIImage imageNamed:@"blue"];
    gIdxView.image = [UIImage imageNamed:@"blue"];
    aIdxView.image = [UIImage imageNamed:@"blue"];
    bIdxView.image = [UIImage imageNamed:@"blue"];
}

-(void) alertUserStart{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please Start"
                                                   delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
	[alert show];
}

-(void) alertUserScore{
    UIAlertView *alert;
    if(scoreCounter > 500){
        alert = [[UIAlertView alloc] initWithTitle:@"Brilliant! You got very high mark." message:[NSString stringWithFormat:@"Your Score: %d.", scoreCounter]
                                              delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    }else if (scoreCounter > 0) {
        alert = [[UIAlertView alloc] initWithTitle:@"Congrats" message:[NSString stringWithFormat:@"Your Score: %d.", scoreCounter]
                                          delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    }else{
        alert = [[UIAlertView alloc] initWithTitle:@"Ops!Not Pass, please try again!" message:[NSString stringWithFormat:@"Your Score: %d.", scoreCounter]
                                          delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    }
    
	[alert show];
}

- (void)drawRect:(CGRect)rect color:(int)color{
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    switch (color) {
        case 0:
            CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
            break;
        case 1:
            CGContextSetStrokeColorWithColor(context, [UIColor greenColor].CGColor);
            break;
        case 2:
            CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
            break;
        default:
            break;
    }
    
    // Draw them with a 2.0 stroke width so they are a bit more visible.
    CGContextSetLineWidth(context, 2.0);
    
    CGContextMoveToPoint(context, 0,0); //start at this point
    
    CGContextAddLineToPoint(context, 20, 20); //draw to this point
    
    // and now draw the Path!
    CGContextStrokePath(context);
}

-(void) drawColorRect:(int)x y:(int)y color:(int)color{
    //if not green, will draw red
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect rect = CGRectMake(x, y, 20, 20);
    CGContextFillEllipseInRect(context, rect);

    switch (color) {
        case 0:
            [[UIColor blueColor] set];
            break;
        case 1:
            [[UIColor greenColor] set];
            break;
        case 2:
            [[UIColor redColor] set];
            break;
        default:
            break;
    }
    CGContextStrokeEllipseInRect(context, CGRectMake(100, 100, 25, 25));


}

-(void) ranNoteNum{
    int max = 7;
    int min = 0;
    //firstNoteNum = (arc4random()%max)+min;
    firstNoteNum = 0;
    secondNoteNum = (arc4random()%max)+min;
    if(firstNoteNum > secondNoteNum)
        interval = firstNoteNum - secondNoteNum;
    else
        interval = secondNoteNum - firstNoteNum;
}

-(void) updatePercentage{
    if(userAnsNum == 0)
        percentCounter = 0;
    else
        percentCounter = ((float)userCorrectAnsNum/(float)userAnsNum) * 100;
    percentLable.text = [NSString stringWithFormat:@"Correct: %d%%", percentCounter];
}

-(void) updateScore{
    scoreCounter = userCorrectAnsNum * 10 - (userAnsNum - userCorrectAnsNum) * 8;
    scoreLable.text = [NSString stringWithFormat:@"Score: %d", scoreCounter];
}

//Timer
- (void)startTimer {
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(runTimer) userInfo:nil repeats:YES];
}

- (void)stopTimer{
    [timer invalidate];
    timer = nil;
    secCounter = 0;
    timeLable.text = [NSString stringWithFormat:@"Time: %d Sec", secCounter];
}

- (void)runTimer{
    secCounter = secCounter - 1;
    if(secCounter == 0) {
        [self setStop];
    }else{
        [self showTimer];
    }
}
- (void)showTimer{
    timeLable.text = [NSString stringWithFormat:@"Time: %d Sec", secCounter];
}

- (void)resetTimer{
    secCounter = 60;
    [self showTimer];
}

- (void)resetScoreAndCorrect{
    scoreCounter = 0;
    userCorrectAnsNum = 0;
    userAnsNum = 0;
    [self updateScore];
    [self updatePercentage];
}
@end
