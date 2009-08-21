#import "ALListener.h"
#import "ALContext.h"

@implementation ALListener

@synthesize context;

- (void)setPoint:(ALpoint)p forParam:(ALenum)param
{
	[context makeCurrent];
	alListener3f(param, p.x, p.y, p.z);
	[self checkError];
}

- (ALpoint)getPointForParam:(ALenum)param
{
	ALpoint p;
	[context makeCurrent];
	alGetListener3f(param, &p.x, &p.y, &p.z);
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

- (void)setRotation:(ALfloat)radians
{
	float ori[] = {cos(radians + M_PI_2), sin(radians + M_PI_2), 0., 0., 0., 1.};
	[context makeCurrent];
	alListenerfv(AL_ORIENTATION, ori);
	[self checkError];
}

- (ALfloat)rotation
{
	return 0;
}

@end
