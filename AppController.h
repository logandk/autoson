//
//  AppController.h
//  Autoson
//
//  Created by Logan Raarup on 6/5/08.
//  Copyright 2008 Logan Raarup. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface AppController : NSObject {
	IBOutlet NSMenu *statusMenu;
	
	NSStatusItem	*statusItem;
    NSImage			*statusImage;
	NSImage			*statusHighlightImage;
	
	SyncController *synchronizer;
	NSThread *syncThread;
	
	IBOutlet NSWindow *PreferencesWin;
	IBOutlet NSWindow *AboutWin;
}

- (void) registerDefaultSettings;

-(IBAction)doSync:(id)sender;
-(IBAction)showAbout:(id)sender;
-(IBAction)showPreferences:(id)sender;
-(IBAction)runUnison:(id)sender;
-(IBAction)showProfile:(id)sender;
-(IBAction)showLog:(id)sender;
-(IBAction)showDocumentation:(id)sender;

@end
