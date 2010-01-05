//metadoc ALObject copyright Steve Dekorte 2009
//metadoc ALObject license BSD revised

#import "ALObject.h"

@implementation ALObject

static BOOL logsErrors;

+ (void)setLogsErrors:(BOOL)aBool
{
	logsErrors = aBool;
}

+ (BOOL)logsErrors
{
	return logsErrors;
}

- (NSString *)stringForAlErrorCode:(ALenum)err
{
	return [NSString stringWithUTF8String:alGetString(err)];
}

- (void)setError:(NSString *)e
{
	[error autorelease];
	error = [e retain];
	logsErrors = YES;
	if (e && logsErrors) NSLog(@"%@ error: %@\n", 
		NSStringFromClass([self class]), e);
}

- (NSString *)error
{
	return error;
}

- (BOOL)checkError
{
	ALenum errorCode = alGetError();
	
	if (errorCode != AL_NO_ERROR)
	{
		[self setError:[self stringForAlErrorCode:errorCode]];
		return YES;
	}
	
	return NO;
}

@end
