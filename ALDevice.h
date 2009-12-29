//metadoc ALDevice copyright Steve Dekorte 2009
//metadoc ALDevice license BSD revised

#import "ALObject.h"

@class ALContext;

@interface ALDevice : ALObject
{	
	ALCdevice *alcDevice;
}

+ (ALDevice *)defaultDevice;

- (void)openDefault;
- (void)close;

- (ALCdevice *)alcDevice;
- (ALContext *)newContext;

@end
