//metadoc ALState copyright Steve Dekorte 2009
//metadoc ALState license BSD revised

#import "ALObject.h"

@interface ALState : ALObject
{
}

+ (NSString *)vendor;
+ (NSString *)version;
+ (NSString *)renderer;
+ (NSString *)extensions;

+ (void)setDistanceModel:(ALenum)v;
+ (ALenum)distanceModel;

+ (void)setDopplerFactor:(float)v;
+ (float)dopplerFactor;

+ (void)setSpeedOfSound:(float)v;
+ (float)speedOfSound;

@end
