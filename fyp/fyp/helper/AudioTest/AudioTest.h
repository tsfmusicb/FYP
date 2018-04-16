//
//  AudioTest.h
//
//  Created by Tse Siu Fai on 15/03/2013.


#import <AudioToolbox/MusicPlayer.h>

@interface AudioTest : NSObject {
    
}

+(id) audioTest;

-(void) midiTest:(NSString *)fileName isInResource:(BOOL)isInResource;

@end
