//
//  fypMusicTraining.m
//  fyp
//
//  Created by Tse Siu Fai on 13年3月23日.
//  Copyright (c) 2013年 cityu. All rights reserved.
//

#import "fypMusicTraining.h"

@implementation fypMusicTraining

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //init value
        notes = [[NSArray alloc] initWithObjects:@"C",@"D",@"E",@"F",@"G",@"A",@"B", nil];
        currentNotePointer = 0;
        secCounter = 60; //defualt 60
        percentCounter = 0;
        userAnsNum = 0;
        userCorrectAnsNum = 0;
        
        timeLable = [[UILabel alloc] initWithFrame:CGRectMake(10, 220, 120, 80)];
        timeLable.text = [NSString stringWithFormat:@"Time: %d Sec", secCounter];
        [self addSubview:timeLable];
        
        scoreLable = [[UILabel alloc] initWithFrame:CGRectMake(140, 220, 120, 80)];
        scoreLable.text = [NSString stringWithFormat:@"Score: %d", scoreCounter];
        [self addSubview:scoreLable];
        
        percentLable = [[UILabel alloc] initWithFrame:CGRectMake(240, 220, 150, 80)];
        percentLable.text = [NSString stringWithFormat:@"Correct: %d%%", percentCounter];
        [self addSubview:percentLable];
        
        trainingNotePic = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"A4"]];
        [self ranPic];
        [self addSubview:trainingNotePic];
        
        UIButton *btnMenu = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btnMenu setFrame:CGRectMake(5, frame.size.height-25, 70, 20)];
        [btnMenu setTitle:@"Menu" forState:UIControlStateNormal];
        [btnMenu addTarget:self action:@selector(btnMenu_onclick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnMenu];
        
        UIButton *btnStart = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btnStart setFrame:CGRectMake(120, frame.size.height-25, 70, 20)];
        [btnStart setTitle:@"Start" forState:UIControlStateNormal];
        [btnStart addTarget:self action:@selector(btnStart_onclick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnStart];
        
        UIButton *btnStop = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btnStop setFrame:CGRectMake(235, frame.size.height-25, 70, 20)];
        [btnStop setTitle:@"Stop" forState:UIControlStateNormal];
        [btnStop addTarget:self action:@selector(btnStop_onclick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnStop];
        
        
        int btnXPos = 5;
        UIButton *btnCNote = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btnCNote setFrame:CGRectMake(btnXPos, 185, 50, 30)];
        [btnCNote setTitle:@"C" forState:UIControlStateNormal];
        [btnCNote addTarget:self action:@selector(btnC_onclick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnCNote];
        
        btnXPos += 55;
        UIButton *btnDNote = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btnDNote setFrame:CGRectMake(btnXPos, 185, 50, 30)];
        [btnDNote setTitle:@"D" forState:UIControlStateNormal];
        [btnDNote addTarget:self action:@selector(btnD_onclick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnDNote];
        
        btnXPos += 55;
        UIButton *btnENote = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btnENote setFrame:CGRectMake(btnXPos, 185, 50, 30)];
        [btnENote setTitle:@"E" forState:UIControlStateNormal];
        [btnENote addTarget:self action:@selector(btnE_onclick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnENote];
        
        btnXPos += 55;
        UIButton *btnFNote = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btnFNote setFrame:CGRectMake(btnXPos, 185, 50, 30)];
        [btnFNote setTitle:@"F" forState:UIControlStateNormal];
        [btnFNote addTarget:self action:@selector(btnF_onclick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnFNote];
        
        btnXPos += 55;
        UIButton *btnGNote = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btnGNote setFrame:CGRectMake(btnXPos, 185, 50, 30)];
        [btnGNote setTitle:@"G" forState:UIControlStateNormal];
        [btnGNote addTarget:self action:@selector(btnG_onclick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnGNote];
        
        btnXPos += 55;
        UIButton *btnANote = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btnANote setFrame:CGRectMake(btnXPos, 185, 50, 30)];
        [btnANote setTitle:@"A" forState:UIControlStateNormal];
        [btnANote addTarget:self action:@selector(btnA_onclick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnANote];
        
        btnXPos += 55;
        UIButton *btnBNote = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btnBNote setFrame:CGRectMake(btnXPos, 185, 50, 30)];
        [btnBNote setTitle:@"B" forState:UIControlStateNormal];
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
        
        int viewPosx = 22.5;
        [cIdxView setFrame:CGRectMake(viewPosx, 220, 15, 15)];
        [self addSubview:cIdxView];
        
        viewPosx += 55;
        [dIdxView setFrame:CGRectMake(viewPosx, 220, 15, 15)];
        [self addSubview:dIdxView];
        
        viewPosx += 55;
        [eIdxView setFrame:CGRectMake(viewPosx, 220, 15, 15)];
        [self addSubview:eIdxView];

        viewPosx += 55;
        [fIdxView setFrame:CGRectMake(viewPosx, 220, 15, 15)];
        [self addSubview:fIdxView];
        
        viewPosx += 55;
        [gIdxView setFrame:CGRectMake(viewPosx, 220, 15, 15)];
        [self addSubview:gIdxView];

        viewPosx += 55;
        [aIdxView setFrame:CGRectMake(viewPosx, 220, 15, 15)];
        [self addSubview:aIdxView];
        
        viewPosx += 55;
        [bIdxView setFrame:CGRectMake(viewPosx, 220, 15, 15)];
        [self addSubview:bIdxView];
        
        //Instruction
        UIImageView *blueView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"blue"]];
        [blueView setFrame:CGRectMake(360, 130, 15, 15)];
        [self addSubview:blueView];
        UILabel *blueText = [[UILabel alloc] initWithFrame:CGRectMake(380, 130, 100, 15)];
        blueText.text = @"Possible";
        [self addSubview:blueText];
        
        UIImageView *redView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"red"]];
        [redView setFrame:CGRectMake(360, 150, 15, 15)];
        [self addSubview:redView];
        UILabel *redText = [[UILabel alloc] initWithFrame:CGRectMake(380, 150, 100, 15)];
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

-(void) btnStart_onclick{
    if(!isRunning)
        [self setStart];
}

-(void)setStart{
    [self resetTimer];
    [self resetScoreAndCorrect];
    [self changeAllIndicateToBlue];
    [self startTimer];
    isRunning = YES;
}

-(void) btnStop_onclick{
    if(isRunning)
        [self setStop];
}

-(void)setStop{
    [self stopTimer];
    isRunning = NO;
    [self alertUserScore];
}

-(void) btnC_onclick{
    [self makeAnswer:0 idxView:cIdxView];
}

-(void) btnD_onclick{
    [self makeAnswer:1 idxView:dIdxView];
}

-(void) btnE_onclick{
    [self makeAnswer:2 idxView:eIdxView];
}

-(void) btnF_onclick{
    [self makeAnswer:3 idxView:fIdxView];
}

-(void) btnG_onclick{
    [self makeAnswer:4 idxView:gIdxView];
}

-(void) btnA_onclick{
    [self makeAnswer:5 idxView:aIdxView];
}

-(void) btnB_onclick{
    [self makeAnswer:6 idxView:bIdxView];
}

-(void) makeAnswer:(int)userAns idxView:(UIImageView*) idxView{
    if(isRunning){
        userAnsNum++;
        if(userAns == currentNotePointer){
            //correct
            userCorrectAnsNum++;
            idxView.image = [UIImage imageNamed:@"green"];
            [self ranPic];
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

-(void) alertUserStart{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please Start"
                                                   delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
	[alert show];	
}

-(void) alertUserScore{
    UIAlertView *alert;
    if(scoreCounter > 600){
        alert = [[UIAlertView alloc] initWithTitle:@"Brilliant! You got very high mark." message:[NSString stringWithFormat:@"Your Score: %d.", scoreCounter]
                                          delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    }else if (scoreCounter > 100) {
        alert = [[UIAlertView alloc] initWithTitle:@"Congrats" message:[NSString stringWithFormat:@"Your Score: %d.", scoreCounter]
                                          delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    }else{
        alert = [[UIAlertView alloc] initWithTitle:@"Ops!Not Pass, please try again!" message:[NSString stringWithFormat:@"Your Score: %d.", scoreCounter]
                                          delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    }
	[alert show];
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

-(void) ranPic{
    int max = 7;
    int min = 0;
    int ran = (arc4random()%max)+min;
    NSString *picFileName = [notes[ran] stringByAppendingString:@"4"];
    currentNotePointer = ran;
    [trainingNotePic setImage:[UIImage imageNamed:picFileName]];
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
