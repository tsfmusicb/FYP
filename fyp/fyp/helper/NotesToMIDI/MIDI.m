#import "MIDI.h"

NSMutableDictionary *chords;	// load chords from file and store them here

@implementation MIDI

+ (void) initialize{
}

- initWithIn:(NSString *)inFile out:(NSString *)outFileA{
	self = [super init];
    
	self->outFile = outFileA;
	track = [[NSMutableData alloc] init];
    chordTrack = [[NSMutableData alloc] init];
	contents = [[NSMutableData alloc] init];
	volume = 100;
	
	return self;
}



- initWithOut:(NSString *)outFileA {
    self = [super init];
	self->outFile = outFileA;
	track = [[NSMutableData alloc] init];
	contents = [[NSMutableData alloc] init];
	volume = 100;
	
	return self;
}

- (void) buildChordTrack:(NSMutableArray *)notes times:(NSMutableArray *)times{
    NSMutableDictionary * chordDictionarys = [NSMutableDictionary dictionaryWithCapacity:7];
    
    [chordDictionarys setObject:[[NSMutableArray alloc] initWithObjects:@"C",@"E","G", nil] forKey:@"cChord"];
    [chordDictionarys setObject:[[NSMutableArray alloc] initWithObjects:@"D",@"F#","A", nil] forKey:@"dChord"];
    [chordDictionarys setObject:[[NSMutableArray alloc] initWithObjects:@"E",@"G#","B", nil] forKey:@"eChord"];
    [chordDictionarys setObject:[[NSMutableArray alloc] initWithObjects:@"F",@"A","C", nil] forKey:@"fChord"];
    [chordDictionarys setObject:[[NSMutableArray alloc] initWithObjects:@"G",@"B","D", nil] forKey:@"gChord"];
    [chordDictionarys setObject:[[NSMutableArray alloc] initWithObjects:@"A",@"C#","E", nil] forKey:@"aChord"];
    [chordDictionarys setObject:[[NSMutableArray alloc] initWithObjects:@"B",@"D#","F#", nil] forKey:@"bChord"];

    char chordtrackHeader[4] = {
        0x4D, 0x54, 0x72, 0x6B // MTrk
    };
    
    NSMutableData *chordContent = [[NSMutableData alloc] init];
    
    [chordContent appendBytes:chordtrackHeader length:4];
    
}

- (void) writeFile:(NSMutableArray *)notes times:(NSMutableArray *)times{
    char midiHeader[14] = { 0x4D, 0x54, 0x68, 0x64, 0x00, 0x00, 0x00, 0x06,
						0x00, 0x01, 0x00, 0x03, 0x00, 0x80};		// MThd header
    char trackHeader[4] = {0x4D, 0x54, 0x72, 0x6B}; //MTrk header
	char end[4] = { 0x00, 0xFF, 0x2F, 0x00 };		// end MTrk
	int length;

    //Melody Part
	[contents appendBytes:midiHeader length:14];
    [contents appendBytes:trackHeader length:4];

	[self buildTrack:notes times:times buildtype:0];
    length = NSSwapHostIntToBig([track length]+4);
	[contents appendBytes:&length length:4];
	//[contents appendBytes:guitar length:3];
	[contents appendData:track];
    [contents appendBytes:end length:4];

    
    //Chord Part1
    track = [[NSMutableData alloc] init];
    length = 0;
    
    //NSMutableArray *chordNotes = [[NSMutableArray alloc]initWithObjects:@"c",@"c",@"f",@"g", nil];
    [self buildTrack:notes times:times buildtype:1];

    [contents appendBytes:trackHeader length:4];
    length = NSSwapHostIntToBig([track length]+4);
	[contents appendBytes:&length length:4];
    [contents appendData:track];
    [contents appendBytes:end length:4];
    
    //Chord Part2
    track = [[NSMutableData alloc] init];
    length = 0;
    
    [self buildTrack:notes times:times buildtype:2];
    [contents appendBytes:trackHeader length:4];
    length = NSSwapHostIntToBig([track length]+4);
	[contents appendBytes:&length length:4];
    [contents appendData:track];
    [contents appendBytes:end length:4];

    //Generate File
    NSFileManager *fm = [NSFileManager defaultManager];

    outFile = [NSTemporaryDirectory() stringByAppendingString:outFile];
	
    if([fm createFileAtPath:outFile contents:contents attributes:nil] != YES)
        NSLog(@"Fail to create file: %@", outFile);

    /*if ([fm fileExistsAtPath: outFile ] == YES)
        NSLog (@"File exists: %@", outFile);
    else
        NSLog (@"File not found: %@", outFile);*/
}

- (void) writeFile:(NSMutableArray *)notes times:(NSMutableArray *)times chord:(NSMutableArray *)chords chordTimes:(NSMutableArray *)chordTimes{
    char midiHeader[14] = { 0x4D, 0x54, 0x68, 0x64, 0x00, 0x00, 0x00, 0x06,
        0x00, 0x01, 0x00, 0x03, 0x00, 0x80};		// MThd header
    char trackHeader[4] = {0x4D, 0x54, 0x72, 0x6B}; //MTrk header
	char end[4] = { 0x00, 0xFF, 0x2F, 0x00 };		// end MTrk
	int length;
    
    //Melody Part
	[contents appendBytes:midiHeader length:14];
    [contents appendBytes:trackHeader length:4];
    
	[self buildTrack:notes times:times buildtype:0];
    length = NSSwapHostIntToBig([track length]+4);
	[contents appendBytes:&length length:4];
	//[contents appendBytes:guitar length:3];
	[contents appendData:track];
    [contents appendBytes:end length:4];
    
    //Chord Part1
    track = [[NSMutableData alloc] init];
    length = 0;
    
    //NSMutableArray *chordNotes = [[NSMutableArray alloc]initWithObjects:@"c",@"c",@"f",@"g", nil];
    [self buildTrack:chords times:chordTimes buildtype:1];
    
    [contents appendBytes:trackHeader length:4];
    length = NSSwapHostIntToBig([track length]+4);
	[contents appendBytes:&length length:4];
    [contents appendData:track];
    [contents appendBytes:end length:4];
    
    //Chord Part2
    track = [[NSMutableData alloc] init];
    length = 0;
    
    [self buildTrack:chords times:chordTimes buildtype:2];
    [contents appendBytes:trackHeader length:4];
    length = NSSwapHostIntToBig([track length]+4);
	[contents appendBytes:&length length:4];
    [contents appendData:track];
    [contents appendBytes:end length:4];
    
    //Generate File
    NSFileManager *fm = [NSFileManager defaultManager];
    
    outFile = [NSTemporaryDirectory() stringByAppendingString:outFile];
	
    if([fm createFileAtPath:outFile contents:contents attributes:nil] != YES)
        NSLog(@"Fail to create file: %@", outFile);
    
    /*if ([fm fileExistsAtPath: outFile ] == YES)
     NSLog (@"File exists: %@", outFile);
     else
     NSLog (@"File not found: %@", outFile);*/
}

- (void) buildTrack:(NSMutableArray *)notes times:(NSMutableArray *)times buildtype:(int)typeNum{
    /*
     typeNum 0 - Melody
     typeNum 1 - Chord 1
     typeNum 2 - Chord 2
    */
    
    if(typeNum == 0 || typeNum == 2){
        //Melody
        int cnt = [notes count];
        char note = -1;
        for(int i = 0; i < cnt; i++){
            if(typeNum == 0){
                note = [self convertNoteFromStringToHex:notes[i]];
            }else if (typeNum == 2){
                note = [self convertBassNoteFromStringToHex:notes[i]];
            }
            
            [self writeVarTime:0x00 secondValue:-1];
            [self appendNote:note state:YES];
            
            if([[times objectAtIndex:i] doubleValue] == 0.5) {
                //For Time 0.5 (Mute the music after 0x60 time)
                [self writeVarTime:0x60 secondValue:-1];
            } else if([[times objectAtIndex:i] doubleValue] == 1.0) {
                //For Time 1.0 (Mute the music after 0x81 0x40 time)
                [self writeVarTime:0x81 secondValue:0x40];
            } else if([[times objectAtIndex:i] doubleValue] == 2.0) {
                //For Time 2.0 (Mute the music after 0x83 0x40 time)
                [self writeVarTime:0x83 secondValue:0x00];
            }
            
            [self appendNote:note state:NO];
        }
    }else if(typeNum == 1){
        //Chord 1
        NSMutableArray *chordNotes = [[NSMutableArray alloc] init];

        NSMutableDictionary * chordDictionarys = [NSMutableDictionary dictionaryWithCapacity:7];

        [chordDictionarys setObject:[NSArray arrayWithObjects:@"c", @"g", nil] forKey:@"c"];
        [chordDictionarys setObject:[NSArray arrayWithObjects:@"d", @"a", nil] forKey:@"d"];
        [chordDictionarys setObject:[NSArray arrayWithObjects:@"e", @"b", nil] forKey:@"e"];
        [chordDictionarys setObject:[NSArray arrayWithObjects:@"f", @"c", nil] forKey:@"f"];
        [chordDictionarys setObject:[NSArray arrayWithObjects:@"g", @"d", nil] forKey:@"g"];
        [chordDictionarys setObject:[NSArray arrayWithObjects:@"a", @"e", nil] forKey:@"a"];
        [chordDictionarys setObject:[NSArray arrayWithObjects:@"b", @"f", nil] forKey:@"b"];

        int cnt = [notes count];
        char note = -1;
        for(int i = 0; i < cnt; i++){
            chordNotes = [chordDictionarys objectForKey:notes[i]];
            for(int j = 0;j < [chordNotes count]; j++){
                note = [self convertNoteFromStringToHex:chordNotes[j]];
                if(note != -1){
                    [self writeVarTime:0x00 secondValue:-1];
                    [self accomAppendNote:note];
                }
            }

            for(int j = 0;j < [chordNotes count]; j++){
                note = [self convertNoteFromStringToHex:chordNotes[j]];
                if(note != -1){
                    if(j == 0){
                        if([[times objectAtIndex:i] doubleValue] == 0.5) {
                            //For Time 0.5 (Mute the music after 0x60 time)
                            [self writeVarTime:0x60 secondValue:-1];
                        } else if([[times objectAtIndex:i] doubleValue] == 1.0) {
                            //For Time 1.0 (Mute the music after 0x81 0x40 time)
                            [self writeVarTime:0x81 secondValue:0x40];
                        } else if([[times objectAtIndex:i] doubleValue] == 2.0) {
                            //For Time 2.0 (Mute the music after 0x83 0x40 time)
                            [self writeVarTime:0x83 secondValue:0x00];
                        }
                    }else{
                        [self writeVarTime:0x00 secondValue:-1];
                    }
                    
                    [self appendNote:note state:NO];
                }
            }
        }
    }
}

- (void) appendNote:(int)note state:(BOOL)on{
	char c[3];

	if( on ){
		c[0] = 0x90;
		c[2] = 0x76; // volume
	} else {
		c[0] = 0x80;
		c[2] = 0x00; // volume
	}
	c[1] = note;
	
	[track appendBytes:&c length:3];
}

- (void) accomAppendNote:(int)note{
	char c[3];
        c[0] = 0x90;
		c[2] = 0x30; // volume
        c[1] = note;
	
	[track appendBytes:&c length:3];
}

- (void) writeVarTime:(int)value{
	char c[2];
	if( value < 128 ){
		c[0] = value;
		[track appendBytes:&c length:1];
	} else {
		c[0] = value/128 | 0x80;
		c[1] = value % 128;
		[track appendBytes:&c length:2];
	}
}

- (void) writeVarTime:(char)value1 secondValue:(char) value2{
	char c[2];
    if(value2 == -1){
        // value 2 have nothing
        c[0] = value1;
        [track appendBytes:&c length:1];

    }else{
        c[0] = value1;
        c[1] = value2;
        [track appendBytes:&c length:2];

    }
}

- (char) convertNoteFromStringToHex:(NSString *) StringNote{
    char result = -1;
    if ([StringNote isEqualToString:@"c"]) {
        result = 0x3C;
    } else if([StringNote isEqualToString:@"d"]){
        result = 0x3E;
    } else if([StringNote isEqualToString:@"e"]){
        result = 0x40;
    } else if([StringNote isEqualToString:@"f"]){
        result = 0x41;
    } else if([StringNote isEqualToString:@"g"]){
        result = 0x43;
    } else if([StringNote isEqualToString:@"a"]){
        result = 0x45;
    } else if([StringNote isEqualToString:@"b"]){
        result = 0x47;
    }
    return result;
}

- (char) convertBassNoteFromStringToHex:(NSString *) StringNote{
    char result = -1;
    if ([StringNote isEqualToString:@"c"]) {
        result = 0x30;
    } else if([StringNote isEqualToString:@"d"]){
        result = 0x32;
    } else if([StringNote isEqualToString:@"e"]){
        result = 0x34;
    } else if([StringNote isEqualToString:@"f"]){
        result = 0x35;
    } else if([StringNote isEqualToString:@"g"]){
        result = 0x37;
    } else if([StringNote isEqualToString:@"a"]){
        result = 0x39;
    } else if([StringNote isEqualToString:@"b"]){
        result = 0x3B;
    }
    return result;
}
@end