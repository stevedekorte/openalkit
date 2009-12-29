//metadoc ALSource copyright Steve Dekorte 2009
//metadoc ALSource license BSD revised

#import "ALObject.h"
#import "ALBuffer.h"

@interface ALSource : ALObject
{
	ALuint alcSource;
	ALBuffer *buffer;
}

+ (ALSource *)sourceWithPath:(NSString *)path;

- (void)setBuffer:(ALBuffer *)buffer;
- (ALBuffer *)buffer;

- (void)setVolume:(float)v;
- (float)volume;

- (void)setLooping:(BOOL)aBool;
- (BOOL)isLooping;

- (void)setReferenceDistance:(float)d;
- (float)referenceDistance;

- (void)setPosition:(ALpoint)p;
- (ALpoint)position;

- (void)setVelocity:(ALpoint)p;
- (ALpoint)velocity;

- (void)setDirection:(ALpoint)p;
- (ALpoint)direction;

- (BOOL)play;
- (void)pause;
- (void)rewind;
- (void)stop;

- (BOOL)isActive;
- (BOOL)isInitializing;
- (BOOL)isPlaying;
- (BOOL)isPaused;
- (BOOL)isStopped;


@end
