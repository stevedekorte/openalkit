#import "ALState.h"

@implementation ALState

+ (NSString *)vendor
{
	return [NSString stringWithCString:alGetString(AL_VENDOR)]; 
}

+ (NSString *)version
{
	return [NSString stringWithCString:alGetString(AL_VERSION)]; 
}

+ (NSString *)renderer
{
	return [NSString stringWithCString:alGetString(AL_RENDERER)]; 
}

+ (NSString *)extensions
{
	return [NSString stringWithCString:alGetString(AL_EXTENSIONS)]; 
}

+ (void)setDistanceModel:(ALenum)v
{
	alDistanceModel(v);
}

+ (ALenum)distanceModel
{
	return alGetFloat(AL_DISTANCE_MODEL);
}

+ (void)setDopplerFactor:(float)v
{
	alDopplerFactor(v);
}

+ (float)dopplerFactor
{
	return alGetFloat(AL_DOPPLER_FACTOR);
}

+ (void)setSpeedOfSound:(float)v
{
	alSpeedOfSound(v);
}

+ (float)speedOfSound
{
	return alGetFloat(AL_SPEED_OF_SOUND);
}

@end
