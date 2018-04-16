#import "fypTuner.h"
#import <QuartzCore/QuartzCore.h>

@implementation fypTuner

@synthesize g3Button, d4Button, a4Button, e5Button, e3Button, a3Button, g4Button, b4Button, c4Button, e4Button, c2Button, g2Button, d3Button,c3Button;
@synthesize img;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        at = [AudioTest audioTest];

        notes = [[NSMutableArray alloc] initWithObjects:@"g3Time4",@"d4Time4",@"a4Time4",@"e5Time4",@"e3Time4",@"a3Time4",@"g4Time4",@"b4Time4",@"c4Time4",@"e4Time4",@"c2Time4",@"g2Time4",@"d3Time4",@"c3Time4", nil];
        
        UIButton *btnMenu = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btnMenu setFrame:CGRectMake(5, frame.size.height-25, 70, 20)];
        [btnMenu setTitle:@"Menu" forState:UIControlStateNormal];
        [btnMenu addTarget:self action:@selector(btnMenu_onclick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnMenu];
        
        img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"main.jpg"]];
        [img setFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        [self addSubview:img];
        [self sendSubviewToBack:img];
        
        UILabel *instructionText = [[UILabel alloc] initWithFrame:CGRectMake(50, 20, 260, 15)];
        instructionText.text = @"Select Musical instruments";
        instructionText.backgroundColor = [UIColor clearColor];
        [self addSubview:instructionText];
        
        currentInstrument = [[UILabel alloc] initWithFrame:CGRectMake(0, 170, self.bounds.size.width, 15)];
        currentInstrument.backgroundColor = [UIColor clearColor];
        currentInstrument.textColor = [UIColor blueColor];
        currentInstrument.textAlignment = NSTextAlignmentCenter;
        [self addSubview:currentInstrument];
        
        //add button
        UIButton *btnViolin = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btnViolin setFrame:CGRectMake(5, 50, 90, 40)];
        [btnViolin setTitle:@"Violin" forState:UIControlStateNormal];
        [btnViolin addTarget:self action:@selector(btnViolin_onclick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnViolin];

        UIButton *btnViola = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btnViola setFrame:CGRectMake(105, 50, 90, 40)];
        [btnViola setTitle:@"Viola" forState:UIControlStateNormal];
        [btnViola addTarget:self action:@selector(btnViola_onclick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnViola];
        
        UIButton *btnCello = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btnCello setFrame:CGRectMake(200, 50, 90, 40)];
        [btnCello setTitle:@"Cello" forState:UIControlStateNormal];
        [btnCello addTarget:self action:@selector(btnCello_onclick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnCello];
        
        UIButton *btnGuiter = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btnGuiter setFrame:CGRectMake(25, 100, 130, 40)];
        [btnGuiter setTitle:@"Guiter" forState:UIControlStateNormal];
        [btnGuiter addTarget:self action:@selector(btnGuiter_onclick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnGuiter];
        
        UIButton *btnUkulele = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btnUkulele setFrame:CGRectMake(165, 100, 130, 40)];
        [btnUkulele setTitle:@"Ukulele" forState:UIControlStateNormal];
        [btnUkulele addTarget:self action:@selector(btnUkulele_onclick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnUkulele];
        
        
        g3Button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [g3Button setTitle:@"G3" forState:UIControlStateNormal];
        [g3Button addTarget:self action:@selector(btnG3_onclick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:g3Button];
        
        d4Button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [d4Button setTitle:@"D4" forState:UIControlStateNormal];
        [d4Button addTarget:self action:@selector(btnD4_onclick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:d4Button];
        
        a4Button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [a4Button setTitle:@"A4" forState:UIControlStateNormal];
        [a4Button addTarget:self action:@selector(btnA4_onclick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:a4Button];
        
        e5Button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [e5Button setTitle:@"E5" forState:UIControlStateNormal];
        [e5Button addTarget:self action:@selector(btnE5_onclick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:e5Button];
        
        e3Button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [e3Button setTitle:@"E3" forState:UIControlStateNormal];
        [e3Button addTarget:self action:@selector(btnE3_onclick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:e3Button];
        
        a3Button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [a3Button setTitle:@"A3" forState:UIControlStateNormal];
        [a3Button addTarget:self action:@selector(btnA3_onclick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:a3Button];
        
        g4Button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [g4Button setTitle:@"G4" forState:UIControlStateNormal];
        [g4Button addTarget:self action:@selector(btnG4_onclick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:g4Button];
        
        b4Button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [b4Button setTitle:@"B4" forState:UIControlStateNormal];
        [b4Button addTarget:self action:@selector(btnB4_onclick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:b4Button];
        
        c4Button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [c4Button setTitle:@"C4" forState:UIControlStateNormal];
        [c4Button addTarget:self action:@selector(btnC4_onclick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:c4Button];
        
        e4Button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [e4Button setTitle:@"E4" forState:UIControlStateNormal];
        [e4Button addTarget:self action:@selector(btnE4_onclick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:e4Button];
        
        c2Button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [c2Button setTitle:@"C2" forState:UIControlStateNormal];
        [c2Button addTarget:self action:@selector(btnC2_onclick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:c2Button];
        
        g2Button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [g2Button setTitle:@"G2" forState:UIControlStateNormal];
        [g2Button addTarget:self action:@selector(btnG2_onclick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:g2Button];
        
        d3Button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [d3Button setTitle:@"D3" forState:UIControlStateNormal];
        [d3Button addTarget:self action:@selector(btnD3_onclick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:d3Button];
        
        c3Button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [c3Button setTitle:@"C3" forState:UIControlStateNormal];
        [c3Button addTarget:self action:@selector(btnC3_onclick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:c3Button];

}
    return self;
}
        
- (IBAction)togglePlay:(UIButton *)selectedButton
{
	/*if (toneUnit)
	{
		AudioOutputUnitStop(toneUnit);
		AudioUnitUninitialize(toneUnit);
		AudioComponentInstanceDispose(toneUnit);
		toneUnit = nil;
		
		[selectedButton setTitle:NSLocalizedString(@"Play", nil) forState:0];
	}
	else
	{
		//[self createToneUnit];
		
		// Stop changing parameters on the unit
		[selectedButton setTitle:NSLocalizedString(@"Stop", nil) forState:0];
	}*/
}

-(IBAction)btnViolin_onclick
{
    g3Button.hidden=FALSE;
    d4Button.hidden=FALSE;
    a4Button.hidden=FALSE;
    e5Button.hidden=FALSE;
    e3Button.hidden=TRUE;
    a3Button.hidden=TRUE;
    g4Button.hidden=TRUE;
    b4Button.hidden=TRUE;
    c4Button.hidden=TRUE;
    e4Button.hidden=TRUE;
    c2Button.hidden=TRUE;
    g2Button.hidden=TRUE;
    d3Button.hidden=TRUE;
    c3Button.hidden=TRUE;
    currentInstrument.text=@"Note for Violin";
    g3Button.frame = CGRectMake(16,285,67,44);
    d4Button.frame = CGRectMake(88,285,67,44);
    a4Button.frame = CGRectMake(163,285,67,44);
    e5Button.frame = CGRectMake(238,285,67,44);
    
    img.image = [UIImage imageNamed:@"Violin.jpg"];
    
    CATransition *transition = [CATransition animation];
    transition.duration = 1.0f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade;
    
    [img.layer addAnimation:transition forKey:nil];
}

-(IBAction)btnViola_onclick
{
    g3Button.hidden=FALSE;
    d4Button.hidden=FALSE;
    a4Button.hidden=FALSE;
    e5Button.hidden=TRUE;
    e3Button.hidden=TRUE;
    a3Button.hidden=TRUE;
    g4Button.hidden=TRUE;
    b4Button.hidden=TRUE;
    c4Button.hidden=TRUE;
    e4Button.hidden=TRUE;
    c2Button.hidden=TRUE;
    g2Button.hidden=TRUE;
    d3Button.hidden=TRUE;
    c3Button.hidden=FALSE;
    currentInstrument.text=@"Note for Viola";
    c3Button.frame = CGRectMake(16,285,67,44);
    g3Button.frame = CGRectMake(88,285,67,44);
    d4Button.frame = CGRectMake(163,285,67,44);
    a4Button.frame = CGRectMake(238,285,67,44);
    
    img.image = [UIImage imageNamed:@"viola.jpg"];
    
    CATransition *transition = [CATransition animation];
    transition.duration = 1.0f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade;
    
    [img.layer addAnimation:transition forKey:nil];
}

-(IBAction)btnCello_onclick
{
    g3Button.hidden=TRUE;
    d4Button.hidden=TRUE;
    a4Button.hidden=TRUE;
    e5Button.hidden=TRUE;
    e3Button.hidden=TRUE;
    a3Button.hidden=FALSE;
    g4Button.hidden=TRUE;
    b4Button.hidden=TRUE;
    c4Button.hidden=TRUE;
    e4Button.hidden=TRUE;
    c2Button.hidden=FALSE;
    g2Button.hidden=FALSE;
    d3Button.hidden=FALSE;
    c3Button.hidden=TRUE;
    currentInstrument.text=@"Note for Cello";
    c2Button.frame = CGRectMake(16,285,67,44);
    g2Button.frame = CGRectMake(88,285,67,44);
    d3Button.frame = CGRectMake(163,285,67,44);
    a3Button.frame = CGRectMake(238,285,67,44);
    
    img.image = [UIImage imageNamed:@"cello.jpg"];
    
    CATransition *transition = [CATransition animation];
    transition.duration = 1.0f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade;
    
    [img.layer addAnimation:transition forKey:nil];
}

-(IBAction)btnGuiter_onclick
{
    g3Button.hidden=TRUE;
    d4Button.hidden=FALSE;
    a4Button.hidden=FALSE;
    e5Button.hidden=FALSE;
    e3Button.hidden=FALSE;
    a3Button.hidden=TRUE;
    g4Button.hidden=FALSE;
    b4Button.hidden=FALSE;
    c4Button.hidden=TRUE;
    e4Button.hidden=TRUE;
    c2Button.hidden=TRUE;
    g2Button.hidden=TRUE;
    d3Button.hidden=TRUE;
    c3Button.hidden=TRUE;
    currentInstrument.text=@"Note for Guiter";
    e3Button.frame = CGRectMake(36,285,55,44);
    a4Button.frame = CGRectMake(93,285,55,44);
    d4Button.frame = CGRectMake(152,285,55,44);
    g4Button.frame = CGRectMake(36,335,55,44);
    b4Button.frame = CGRectMake(93,335,55,44);
    e5Button.frame = CGRectMake(152,335,55,44);
    
    img.image = [UIImage imageNamed:@"Guitar.jpg"];
    
    CATransition *transition = [CATransition animation];
    transition.duration = 1.0f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade;
    
    [img.layer addAnimation:transition forKey:nil];
}

-(IBAction)btnUkulele_onclick
{
    g3Button.hidden=TRUE;
    d4Button.hidden=TRUE;
    a4Button.hidden=FALSE;
    e5Button.hidden=TRUE;
    e3Button.hidden=TRUE;
    a3Button.hidden=TRUE;
    g4Button.hidden=FALSE;
    b4Button.hidden=TRUE;
    c4Button.hidden=FALSE;
    e4Button.hidden=FALSE;
    c2Button.hidden=TRUE;
    g2Button.hidden=TRUE;
    d3Button.hidden=TRUE;
    c3Button.hidden=TRUE;
    currentInstrument.text=@"Note for Ukulele";
    g4Button.frame = CGRectMake(16,285,67,44);
    c4Button.frame = CGRectMake(88,285,67,44);
    e4Button.frame = CGRectMake(163,285,67,44);
    a4Button.frame = CGRectMake(238,285,67,44);
    
    img.image = [UIImage imageNamed:@"uku.jpg"];
    
    CATransition *transition = [CATransition animation];
    transition.duration = 1.0f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade;
    
    [img.layer addAnimation:transition forKey:nil];
}


-(void)btnMenu_onclick {
    [UIView beginAnimations:@"animateTunerView" context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDidStopSelector:@selector(closeTuner)];
    [self setFrame:CGRectMake( 0, -self.bounds.size.height, self.bounds.size.width, self.bounds.size.height)];
    [UIView commitAnimations];
}

-(void)closeTuner {
    [self removeFromSuperview];
}

-(void)btnG3_onclick{
    [at midiTest:notes[0] isInResource:YES];
}

-(void)btnD4_onclick{
    [at midiTest:notes[1] isInResource:YES];
}

-(void)btnA4_onclick{
    [at midiTest:notes[2] isInResource:YES];
}

-(void)btnE5_onclick{
    [at midiTest:notes[3] isInResource:YES];
}

-(void)btnE3_onclick{
    [at midiTest:notes[4] isInResource:YES];
}

-(void)btnA3_onclick{
    [at midiTest:notes[5] isInResource:YES];
}

-(void)btnG4_onclick{
    [at midiTest:notes[6] isInResource:YES];
}

-(void)btnB4_onclick{
    [at midiTest:notes[7] isInResource:YES];
}

-(void)btnC4_onclick{
    [at midiTest:notes[8] isInResource:YES];
}

-(void)btnE4_onclick{
    [at midiTest:notes[9] isInResource:YES];
}

-(void)btnC2_onclick{
    [at midiTest:notes[10] isInResource:YES];
}

-(void)btnG2_onclick{
    [at midiTest:notes[11] isInResource:YES];
}

-(void)btnD3_onclick{
    [at midiTest:notes[12] isInResource:YES];
}

-(void)btnC3_onclick{
    [at midiTest:notes[13] isInResource:YES];
}

@end
