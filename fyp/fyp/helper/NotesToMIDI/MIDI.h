#import <Foundation/Foundation.h>

@interface MIDI : NSObject {
	char *inData;
	int inLength, pos;
	NSString *outFile;
	NSMutableData *track, *contents, *chordTrack;
	NSString *lastChord;
	int DELTA, deltaDivide;
	int stepOffset, lastOffset;
	int volume, lastVolume;
}

- initWithIn:(NSString *)inFile out:(NSString *)outFile;
- initWithOut:(NSString *)outFileA;

- (void) writeFile:(NSMutableArray *)notes times:(NSMutableArray *)times;
- (void) writeFile:(NSMutableArray *)notes times:(NSMutableArray *)times chord:(NSMutableArray *)chords chordTimes:(NSMutableArray *)chordTimes;
- (void) buildTrack;
- (void) buildChordTrack:(NSMutableArray *)notes times:(NSMutableArray *)times;
- (void) writeVarTime:(int)value;
- (void) writeChord:(NSString *)chord atDelta:(int)delta;
- (void) closeLastChord:(int)delta;
- (void) appendNote:(int)note state:(BOOL)on;

@end
