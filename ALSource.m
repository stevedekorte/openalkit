#import "ALSource.h"
#import "ALContext.h"

@interface ALSource (Private)
- (BOOL)open;
- (void)close;
@end

@implementation ALSource

+ newWithPath:(NSString *)path
{
	ALSource *source = [[[ALSource alloc] init] autorelease];
	[source setBuffer:[ALBuffer bufferFromCacheForPath:path]];
	return source;
}

- (id)init
{	
	if (self = [super init]) 
	{
		[self open];
	}
	
	return self;
}

- (void)dealloc
{
	[self close];
	[self setBuffer:nil];
	[super dealloc];
}

- (void)setBuffer:(ALBuffer *)aBuffer
{
	[buffer autorelease];
	buffer = [aBuffer retain];
	
	if (buffer)
	{
		alSourcei(alcSource, AL_BUFFER, [buffer alcBuffer]);
		[self checkError];
	}
}

- (ALBuffer *)buffer
{
	return buffer;
}

- (void)setVolume:(float)v
{
	alSourcef(alcSource, AL_GAIN, v);
	[self checkError];
}

- (float)volume
{
	float v;
	alGetSourcef(alcSource, AL_GAIN, &v);
	[self checkError];
	return v;
}

- (void)setLooping:(BOOL)aBool
{
	alSourcei(alcSource, AL_LOOPING, aBool ? AL_TRUE : AL_FALSE);
	[self checkError];
}

- (BOOL)isLooping
{
	int v;
	alGetSourcei(alcSource, AL_LOOPING, &v);
	[self checkError];
	return v;
}

- (void)setReferenceDistance:(float)d
{
	alSourcef(alcSource, AL_REFERENCE_DISTANCE, d);
	[self checkError];
}

- (float)referenceDistance
{
	float v;
	alGetSourcef(alcSource, AL_REFERENCE_DISTANCE, &v);
	[self checkError];
	return v;
}

- (void)setPoint:(ALpoint)p forParam:(ALuint)param
{
	alSourcefv(alcSource, param, (ALfloat *)&p);
	[self checkError];
}

- (ALpoint)getPointForParam:(ALuint)param
{
	ALpoint p;
	alGetSourcefv(alcSource, AL_POSITION, (ALfloat *)&p);
	[self checkError];
	return p;
}

- (void)setPosition:(ALpoint)p
{
	[self setPoint:p forParam:AL_POSITION];
}

- (ALpoint)position
{
	return [self getPointForParam:AL_POSITION];
}

- (void)setVelocity:(ALpoint)p
{
	[self setPoint:p forParam:AL_VELOCITY];
}

- (ALpoint)velocity
{
	return [self getPointForParam:AL_VELOCITY];
}

- (void)setDirection:(ALpoint)p
{
	[self setPoint:p forParam:AL_DIRECTION];
}


- (ALpoint)direction
{
	return [self getPointForParam:AL_DIRECTION];
}


- (BOOL)open
{    			
	if (!alcSource)
	{
		alGenSources(1, &alcSource);
		if ([self checkError]) return NO;
	}
	
	return YES;
}

- (void)close
{	
    if (alcSource) 
	{
		alDeleteSources(1, &alcSource);
		alcSource = 0x0;
		[self checkError];
	}
}

- (BOOL)play
{
	alSourcePlay(alcSource);
	if ([self checkError]) return NO;
	return YES;
}

- (void)pause
{
	alSourcePause(alcSource);
	[self checkError];
}

- (void)rewind
{
	alSourceRewind(alcSource);
	[self checkError];
}


- (void)stop
{
	alSourceStop(alcSource);
	[self checkError];
}

- (int)state
{
	int state;
	alGetSourcei(alcSource, AL_SOURCE_STATE, &state);
	[self checkError];
	return state;
}

- (BOOL)isActive
{
	int state = [self state];
	return !(state == AL_INITIAL || state == AL_STOPPED);
}

- (BOOL)isInitializing
{
	return [self state] == AL_INITIAL;
}

- (BOOL)isPlaying
{
	return [self state] == AL_PLAYING;
}

- (BOOL)isPaused
{
	return [self state] == AL_PAUSED;
}

- (BOOL)isStopped
{
	return [self state] == AL_STOPPED;
}


@end
