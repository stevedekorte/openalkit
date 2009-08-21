#import "ALBuffer.h"
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AudioToolbox/ExtendedAudioFile.h>

@interface ALBuffer (Private)
- (BOOL)open;
- (void)close;
@end

@implementation ALBuffer

@synthesize data;
@synthesize alcBuffer;

static NSMutableDictionary *bufferCache = 0x0;

+ (NSMutableDictionary *)bufferCache
{
	if (!bufferCache) bufferCache = [[NSMutableDictionary dictionary] retain];
	return bufferCache;
}

+ bufferFromCacheForPath:(NSString *)path
{
	NSMutableDictionary *cache = [self bufferCache];
	id b = [cache objectForKey:path];
	if (b) return b;
	b = [[[ALBuffer alloc] init] autorelease];
	[b loadPath:path];
	[cache setObject:b forKey:path];
	return b;
}
				
- (id)init
{	
	if (self = [super init]) 
	{
		[self open];
	}
	
	return self;
}

- (void)dealloc
{
	[self close];
	[self setData:nil];
	[super dealloc];
}

- (ALuint)alcBuffer
{
	return alcBuffer;
}

- (BOOL)open
{
	if (!alcBuffer) alGenBuffers(1, &alcBuffer);
	if ([self checkError]) return NO;
	return YES;
}

- (void)close
{
    if (alcBuffer) alDeleteBuffers(1, &alcBuffer);
	alcBuffer = 0x0;
}

- (BOOL)bindToData
{
	alBufferData(alcBuffer, alFormat, [data bytes], [data length], sampleRate);
	if ([self checkError]) return NO;
	return YES;	
}

- (ALenum)alFormat
{
	return alFormat;
}

- (BOOL)loadPath:(NSString *)path
{
	//NSLog(@"loadPath: %@\n", path);
	return [self loadURL:[NSURL fileURLWithPath:path]];
}

- (BOOL)loadURL:(NSURL *)url
{
	AudioStreamBasicDescription outFormat;
	AudioStreamBasicDescription inFormat;

	OSStatus err = noErr;	
	SInt64 theFileLengthInFrames = 0;
	UInt32 thePropertySize = sizeof(inFormat);
	ExtAudioFileRef extRef = NULL;
	void *theData = NULL;
	
	err = ExtAudioFileOpenURL((CFURLRef)url, &extRef);
	
	if (err)
	{
		[self setError:[NSString stringWithFormat:@"ExtAudioFileOpenURL FAILED, Error = %ld\n", err]]; 
		goto Exit; 
	}
	
	// Get the audio data format
	err = ExtAudioFileGetProperty(extRef, kExtAudioFileProperty_FileDataFormat, &thePropertySize, &inFormat);
	if (err) 
	{ 
		printf("ExtAudioFileGetProperty(kExtAudioFileProperty_FileDataFormat) FAILED, Error = %ld\n", err); 
		goto Exit; 
	}
	
	if (inFormat.mChannelsPerFrame > 2)  
	{ 
		[self setError:@"Unsupported Format, channel count is greater than stereo\n"]; 
		goto Exit;
	}

	// Set the client format to 16 bit signed integer (native-endian) data
	// Maintain the channel count and sample rate of the original source format
	outFormat.mSampleRate = inFormat.mSampleRate;
	outFormat.mChannelsPerFrame = inFormat.mChannelsPerFrame;
	outFormat.mFormatID = kAudioFormatLinearPCM;
	outFormat.mBytesPerPacket = 2 * outFormat.mChannelsPerFrame;
	outFormat.mFramesPerPacket = 1;
	outFormat.mBytesPerFrame = 2 * outFormat.mChannelsPerFrame;
	outFormat.mBitsPerChannel = 16;
	outFormat.mFormatFlags = kAudioFormatFlagsNativeEndian | kAudioFormatFlagIsPacked | kAudioFormatFlagIsSignedInteger;
	
	// Set the desired client (output) data format
	err = ExtAudioFileSetProperty(extRef, kExtAudioFileProperty_ClientDataFormat, sizeof(outFormat), &outFormat);
	if (err) 
	{ 
		[self setError:[NSString stringWithFormat:@"ExtAudioFileSetProperty %ld\n", err]]; 
		goto Exit; 
	}
	
	// Get the total frame count
	thePropertySize = sizeof(theFileLengthInFrames);
	err = ExtAudioFileGetProperty(extRef, kExtAudioFileProperty_FileLengthFrames, &thePropertySize, &theFileLengthInFrames);
	if (err) 
	{ 
		[self setError:[NSString stringWithFormat:@"ExtAudioFileGetProperty %ld\n", err]]; 
		goto Exit; 
	}
	
	// Read all the data into memory
	UInt32 dataSize = theFileLengthInFrames * outFormat.mBytesPerFrame;
	theData = malloc(dataSize);
	
	if (theData)
	{
		AudioBufferList theDataBuffer;
		theDataBuffer.mNumberBuffers = 1;
		theDataBuffer.mBuffers[0].mDataByteSize = dataSize;
		theDataBuffer.mBuffers[0].mNumberChannels = outFormat.mChannelsPerFrame;
		theDataBuffer.mBuffers[0].mData = theData;
		
		// Read the data into an AudioBufferList
		err = ExtAudioFileRead(extRef, (UInt32*)&theFileLengthInFrames, &theDataBuffer);
		if (err == noErr)
		{
			// success
			alFormat = (outFormat.mChannelsPerFrame > 1) ? AL_FORMAT_STEREO16 : AL_FORMAT_MONO16;
		}
		else 
		{ 
			// failure
			free(theData);
			theData = NULL; // make sure to return NULL
			printf("ExtAudioFileRead FAILED, Error = %ld\n", err); 
			goto Exit;
		}	
	}
	
	[self setData:[NSMutableData dataWithBytes:theData length:dataSize]];
	sampleRate = inFormat.mSampleRate;
	
	[self bindToData];
	return YES;
	
Exit:
	// Dispose the ExtAudioFileRef, it is no longer needed
	if (extRef) ExtAudioFileDispose(extRef);
	return NO;
}

//alBufferi(alcBuffer, AL_FREQUENCY, iFreq);


- (int)sampleRate
{
	ALint i;
	alGetBufferi(alcBuffer, AL_FREQUENCY, &i);
	[self checkError];
	return i;
}

- (int)bitsPerSample
{
	ALint i;
	alGetBufferi(alcBuffer, AL_FREQUENCY, &i);
	[self checkError];
	return i;
}

- (int)channels
{
	ALint i;
	alGetBufferi(alcBuffer, AL_CHANNELS, &i);
	[self checkError];
	return i;
}

- (int)size
{
	ALint i;
	alGetBufferi(alcBuffer, AL_SIZE, &i);
	[self checkError];
	return i;
}


@end
