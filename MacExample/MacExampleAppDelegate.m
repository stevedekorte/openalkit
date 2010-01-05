//
//  MacExampleAppDelegate.m
//  MacExample
//
//  Created by Jeremy Knope on 12/28/09.
//  Copyright 2009 Buttered Cat Software. All rights reserved.
//

#import "MacExampleAppDelegate.h"
#import "ALContext.h"
#import "ALSource.h"

@implementation MacExampleAppDelegate

@synthesize window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	// Insert code here to initialize your application 
	alContext = [[ALContext context] retain];
	alSource = [[ALSource sourceWithPath:[[NSBundle mainBundle] pathForResource:@"sound" ofType:@"caf"]] retain];
}

- (IBAction)play:(id)sender
{
	if([alSource isPlaying])
		[alSource stop];
	else
		[alSource play];
}

- (IBAction)toggleLooping:(id)sender
{
	[alSource setLooping:([sender state] == NSOnState ? YES : NO)];
}

- (void)dealloc
{
	[alSource stop];
	
	[alContext release];
	[alSource release];
	[super dealloc];
}

@end
