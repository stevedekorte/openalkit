#import "ALContext.h"

@implementation ALContext

@synthesize device;
@synthesize listener;
//@synthesize sources;

+ (ALContext *)context
{
	ALContext *c = [[[ALContext alloc] init] autorelease];
	[c open];
	return c;
}

- (id)init
{	
	if (self = [super init]) 
	{
		self.listener = [[[ALListener alloc] init] autorelease];
		[listener setContext:self];
	}
	
	return self;
}

- (void)dealloc
{
	[self close];
	[self setDevice:nil];
	[self setListener:nil];
	[super dealloc];
}

- (void)process
{
	alcProcessContext(alcContext);
	[self checkError];
}

- (void)suspend
{
	alcSuspendContext(alcContext);
	[self checkError];
}

- (void)open
{
	if (!device) 
	{
		id d = [ALDevice defaultDevice];
		[d retain];
		[self setDevice:d];
	}
	
	alcContext = alcCreateContext([device alcDevice], 0);
	[self checkError];
	if (alcContext) [self makeCurrent];
	[self process];
}

- (void)makeCurrent
{
	if (alcContext) alcMakeContextCurrent(alcContext);
}

- (void)close
{	
    if (alcContext) alcDestroyContext(alcContext);
	alcContext = NULL;
    [device close];
}

- (ALCdevice *)alcDevice
{
	return alcGetContextsDevice(alcContext);
}

@end
