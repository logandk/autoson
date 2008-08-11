//
//  PreferencesController.h
//  Autoson
//
//  Created by Logan Raarup on 21/5/08.
//  Copyright 2008 Logan Raarup. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface PreferencesController : NSObject {
	IBOutlet NSUserDefaultsController *userDefaults;
	IBOutlet NSTextField *remoteHost;
	IBOutlet NSTextField *pingInterval;
	IBOutlet NSStepper *intervalStepper;
	IBOutlet NSButton *launchStartup;
}

@end
