//
//  MacExampleAppDelegate.h
//  MacExample
//
//  Created by Jeremy Knope on 12/28/09.
//  Copyright 2009 Buttered Cat Software. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class ALContext;
@class ALSource;

@interface MacExampleAppDelegate : NSObject {
    NSWindow *window;
	ALContext *alContext;
	ALSource *alSource;
}

@property (assign) IBOutlet NSWindow *window;

- (IBAction)play:(id)sender;
- (IBAction)toggleLooping:(id)sender;

@end
