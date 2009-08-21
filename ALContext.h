//metadoc ALContext copyright Steve Dekorte 2009
//metadoc ALContext license BSD revised

#import "ALObject.h"
#import "ALDevice.h"
#import "ALListener.h"
#import "ALSource.h"

@interface ALContext : ALObject
{	
	ALDevice *device;
	ALListener *listener;
	ALCcontext *alcContext;
}

+ defaultContext;

@property (nonatomic, assign) ALDevice *device; 
@property (nonatomic, assign) ALListener *listener; 

- (void)open;
- (void)makeCurrent;
- (void)close;

@end
