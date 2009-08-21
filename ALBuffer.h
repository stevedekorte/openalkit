#import "ALObject.h"

@interface ALBuffer : ALObject
{
	NSData *data;	
	ALenum alFormat;
	int sampleRate;
	ALuint alcBuffer;
}

@property (nonatomic, assign) NSData *data; 
@property (nonatomic, assign) ALuint alcBuffer; 

+ bufferFromCacheForPath:(NSString *)path;

// ugly - move these load methods to AudioData object later
- (BOOL)loadURL:(NSURL *)url; 
- (BOOL)loadPath:(NSString *)path;

- (ALuint)alcBuffer;
- (ALenum)alFormat;

- (int)sampleRate;
- (int)bitsPerSample;
- (int)channels;
- (int)size;

@end
