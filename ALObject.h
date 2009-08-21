//metadoc ALObject copyright Steve Dekorte 2009
//metadoc ALObject license BSD revised

//#import <UIKit/UIKit.h>
#import <OpenAL/al.h>
#import <OpenAL/alc.h>

typedef struct 
{
	float x;
	float y;
	float z;
} ALpoint;

@interface ALObject : NSObject
{	
	NSString *error;
}

+ (void)setLogsErrors:(BOOL)aBool;
+ (BOOL)logsErrors;

- (void)setError:(NSString *)error; 
- (NSString *)error; 

- (BOOL)checkError;


@end
