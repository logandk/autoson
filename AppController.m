//
//  AppController.m
//  Autoson
//
//  Created by Logan Raarup on 6/5/08.
//  Copyright 2008 Logan Raarup. All rights reserved.
//

#import "SyncController.h"
#import "AppController.h"
#import "AppleScriptController.h"


@implementation AppController


//
// Constructors etc.
//

- (id) init
{
	self = [super init];

	[NSApp setDelegate:self];
	
	synchronizer = [[SyncController alloc] init];
	syncThread = [[NSThread alloc] initWithTarget:synchronizer selector:@selector(launchThread) object:nil];
	
	// Attach pingAction notifier to ping command
	[[NSNotificationCenter defaultCenter] addObserver:self 
		selector:@selector(resumeSync:) 
		name:@"PreferencesSaved" 
		object:nil];
		
	[self registerDefaultSettings];
	
	return self;
}



//
// Methods
//

- (void) awakeFromNib
{
	//Create the NSStatusBar and set its length
    statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSSquareStatusItemLength];
    
    //Used to detect where our files are
    NSBundle *bundle = [NSBundle mainBundle];
    
    //Allocates and loads the images into the application which will be used for our NSStatusItem
    statusImage = [[NSImage alloc] initWithContentsOfFile:[bundle pathForResource:@"autoson_inactive" ofType:@"png"]];
	statusHighlightImage = [[NSImage alloc] initWithContentsOfFile:[bundle pathForResource:@"autoson_active" ofType:@"png"]];
    
    //Sets the images in our NSStatusItem
    [statusItem setImage:statusImage];
	[statusItem setAlternateImage:statusHighlightImage];
	
	[statusItem setLength:31];
    
    //Tells the NSStatusItem what menu to load
    [statusItem setMenu:statusMenu];
	
    //Sets the tooptip for our item
    [statusItem setToolTip:@"Autoson"];
	
	//Enables highlighting
    [statusItem setHighlightMode:YES];
	
	// Start synchronization
	[syncThread start];
}


- (void) resumeSync:(NSNotification *)aNotification
{
	[synchronizer performSelector:@selector(startAutoSync) onThread:syncThread withObject:nil waitUntilDone:NO];
}

- (void) registerDefaultSettings
{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

	NSDictionary *appDefaults = [NSDictionary dictionaryWithObject:@"30" forKey:@"pingInterval"];

	[defaults registerDefaults:appDefaults];
}


//
// InterfaceBuilder Actions
//


-(IBAction)doSync:(id)sender
{	
	[synchronizer performSelector:@selector(stopAutoSync) onThread:syncThread withObject:nil waitUntilDone:NO];
	[synchronizer performSelector:@selector(synchronize) onThread:syncThread withObject:nil waitUntilDone:NO];
}

-(IBAction)showPreferences:(id)sender
{
	[synchronizer performSelector:@selector(stopAutoSync) onThread:syncThread withObject:nil waitUntilDone:NO];

    [PreferencesWin center];
	[PreferencesWin makeKeyAndOrderFront:self];
	[PreferencesWin orderFrontRegardless];
}

-(IBAction)showAbout:(id)sender
{
	[AboutWin center];
	[AboutWin orderFrontRegardless];
}

-(IBAction)showProfile:(id)sender
{
	AppleScriptController *script = [[AppleScriptController alloc] initWithFile:@"show_profile"];
		
	[script execute];
}

-(IBAction)showLog:(id)sender
{
	AppleScriptController *script = [[AppleScriptController alloc] initWithFile:@"show_log"];
		
	[script execute];
}

-(IBAction)showDocumentation:(id)sender
{
	AppleScriptController *script = [[AppleScriptController alloc] initWithFile:@"show_documentation"];
		
	[script execute];
}

-(IBAction)runUnison:(id)sender
{
	AppleScriptController *script = [[AppleScriptController alloc] initWithFile:@"run_unison"];
		
	[script execute];
}


@end
