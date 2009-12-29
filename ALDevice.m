#import "ALDevice.h"
#import "ALContext.h"
@implementation ALDevice

+ (ALDevice *)defaultDevice
{
	ALDevice *device = [[[ALDevice alloc] init] autorelease];
	[device openDefault];
	return device;
}

- (id)init
{	
	if (self = [super init]) 
	{
		//AudioSesssion...
	}
	
	return self;
}

- (void)dealloc
{
	[self close];
	[super dealloc];
}

- (void)openDefault
{
	if (alcDevice) [self close];
	alcDevice = alcOpenDevice(NULL);
	[self checkError];
}

- (void)close
{	
    if (alcDevice) 
	{
		 // need to close contexts?
		alcCloseDevice(alcDevice);
		[self checkError];
	}
	
	alcDevice = NULL;
}

- (ALCdevice *)alcDevice 
{
	return alcDevice;
}

- (ALContext *)newContext
{
	ALContext *context = [[[ALContext alloc] init] autorelease];
	[context setDevice:self];
	return context;
}

@end
