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
	ALfloat ori[] = {cos(radians + M_PI_2), sin(radians + M_PI_2), 0., 0., 0., 1.};
	[context makeCurrent];
	alListenerfv(AL_ORIENTATION, ori);
	[self checkError];
}

- (ALfloat)rotation
{
	ALfloat ori[6];
	alGetListenerfv(AL_ORIENTATION, ori);
	return (ALfloat)atan2((double)ori[1], (double)ori[0]);
}

- (void)setDirection:(ALpoint)d
{
	ALpoint p = [self position];
	ALfloat ori[] = {d.x, d.y, d.z, p.x, p.y, p.z};
	[context makeCurrent];
	alListenerfv(AL_ORIENTATION, ori);
	[self checkError];
}

- (ALpoint)direction
{
	ALpoint d;
	ALfloat ori[6];
	alGetListenerfv(AL_ORIENTATION, ori);
	d.x = ori[0];
	memcpy(&d, ori, sizeof(ALpoint));
	return d;
}

@end
