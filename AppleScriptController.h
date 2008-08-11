//
//  AppleScriptController.h
//  Autoson
//
//  Created by Logan Raarup on 5/6/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface AppleScriptController : NSObject {
	NSAppleScript * appleScript;
	NSDictionary * errors;
}

- (NSDictionary *) errors;

- (AppleScriptController *) initWithFile: (NSString *) scriptFile;
- (AppleScriptController *) initWithString: (NSString *) scriptString;
- (NSAppleEventDescriptor *) execute;

@end
