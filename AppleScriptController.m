//
//  AppleScriptController.m
//  Autoson
//
//  Created by Logan Raarup on 5/6/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "AppleScriptController.h"


@implementation AppleScriptController


-(AppleScriptController *) initWithFile: (NSString *) scriptFile
{
    self = [super init];
	
	errors = [NSDictionary dictionary];
	
	if (self)
	{
		NSString* path = [[NSBundle mainBundle] pathForResource:scriptFile ofType:@"scpt"];
		
		if (path != nil)
		{
			NSURL* url = [NSURL fileURLWithPath:path];
			if (url != nil)
			{
				appleScript = [[NSAppleScript alloc] initWithContentsOfURL:url error:&errors];
			}
		}
	}

    return self;
}


-(AppleScriptController *) initWithString: (NSString *) scriptString
{
    self = [super init];
	
	errors = [NSDictionary dictionary];
	
	if (self)
	{
		appleScript = [[NSAppleScript alloc] initWithSource:scriptString];
	}

    return self;
}


- (NSAppleEventDescriptor *) execute
{
	NSAppleEventDescriptor* returnDescriptor = NULL;
	
	if (appleScript != nil)
	{
		returnDescriptor = [appleScript executeAndReturnError: &errors];

		//[appleScript release];
	}
	
	return returnDescriptor;
}


- (NSDictionary *) errors
{
	return errors;
}


@end
