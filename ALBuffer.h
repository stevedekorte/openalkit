#import "ALObject.h"

@interface ALBuffer : ALObject
{
	NSData *data;	
	ALenum alFormat;
	int sampleRate;
	ALuint alcBuffer;
}

+ bufferFromCacheForPath:(NSString *)path;

@property (nonatomic, assign) NSData *data; 
@property (nonatomic, assign) ALuint alcBuffer; 

- (ALuint)alcBuffer;
- (ALenum)alFormat;
- (int)sampleRate;
- (int)bitsPerSample;
- (int)channels;
- (int)size;

// ugly - move to a sound file object
- (BOOL)loadURL:(NSURL *)url; 
- (BOOL)loadPath:(NSString *)path;

@end
