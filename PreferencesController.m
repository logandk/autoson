//
//  PreferencesController.m
//  Autoson
//
//  Created by Logan Raarup on 21/5/08.
//  Copyright 2008 Logan Raarup. All rights reserved.
//

#import "PreferencesController.h"
#import "AppleScriptController.h";

@implementation PreferencesController

- (void)windowWillClose:(NSNotification*)notification
{
	[userDefaults save:self];
	
	[[NSNotificationCenter defaultCenter] postNotificationName:@"PreferencesSaved" object:nil];
	

	if ([launchStartup state] == true)
	{
		AppleScriptController *script = [[AppleScriptController alloc] initWithString:
					@"\
					set app_path to path to me\n\
					tell application \"System Events\"\n\
					if \"Autoson\" is not in (name of every login item) then\n\
					make login item at end with properties {hidden:false, path:app_path}\n\
					end if\n\
					end tell"
		];
		
		[script execute];
	}
	else
	{
		AppleScriptController *script = [[AppleScriptController alloc] initWithFile:@"login_item_remove"];
		
		[script execute];
	}
}

@end
