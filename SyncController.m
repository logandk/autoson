//
//  SyncController.m
//  Autoson
//
//  Created by Logan Raarup on 5/6/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "SyncController.h"
#import "AppleScriptController.h"


@implementation SyncController


//
// Constructors etc.
//

- (id) init
{
	self = [super init];
	
	ping = nil;
	timer = nil;
	
	syncStopped = TRUE;
	currentStatus = FALSE;
	unisonRunning = FALSE;
	runLoopActive = FALSE;
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pingResponse:) name:NSTaskDidTerminateNotification object:ping];
	
	return self;
}


- (void) launchThread
{
	[self startAutoSync];
}





//
// Methods
//

- (void) synchronize
{
	if (unisonRunning)
	{
		return;
	}

	unisonRunning = TRUE;

	AppleScriptController *script = [[AppleScriptController alloc] initWithFile:@"synchronize"];
	[script execute];
	
	unisonRunning = FALSE;

	[self startAutoSync];
}

- (void) stopAutoSync
{	
	//@try
	//{
		syncStopped = TRUE;
		
		if (timer != nil)
		{
			if ([timer isValid])
			{
				[timer invalidate];
			}
		}

		if (ping != nil)
		{
			if ([ping isRunning])
			{
				[ping terminate];
			}
		}
	//}
	
	//@catch (NSException *ne)
	//{
		// do nothing
	//}
}


- (void) startAutoSync
{
	//@try
	//{
		syncStopped = FALSE;
		
		timer = [NSTimer scheduledTimerWithTimeInterval: [[NSUserDefaults standardUserDefaults] integerForKey:@"pingInterval"]
			target: self
			selector: @selector(pingHost)
			userInfo: nil
			repeats: FALSE];
		
		if ([timer isValid])
		{
			if (!runLoopActive)
			{
				runLoopActive = TRUE;
				[[NSRunLoop currentRunLoop] run];
			}
		}
	//}
	
	//@catch (NSException *ne)
	//{
		// do nothing
	//}
}


- (void) pingHost
{
	@synchronized (self)
	{
		if (syncStopped)
		{
			return;
		}

		NSString *remoteHost = [[NSUserDefaults standardUserDefaults] stringForKey:@"remoteHost"];
		
		if ([remoteHost length] == 0)
		{
			[self startAutoSync];
			return;
		}

		// Launch ping command
		ping = [[NSTask alloc] init];
		[ping setLaunchPath:@"/sbin/ping"];
		[ping setArguments:[NSArray arrayWithObjects:@"-c 1", remoteHost, nil]];
		[ping setStandardError:[[NSPipe alloc] init]];
		
		//NSLog(@"Pinging");
		
		[ping launch];
	}
}

- (void) pingResponse:(NSNotification *)pingNotification
{
	if (!syncStopped)
	{	
		int status = [[pingNotification object] terminationStatus];

		if (status == 0)
		{
			NSLog(@"Pinging - successful");
		
			if (currentStatus)
			{
				[self startAutoSync];
			}
			else
			{
				currentStatus = TRUE;
				[self synchronize];
			}
		}
		else
		{
			NSLog(@"Pinging - unreachable");
		
			currentStatus = FALSE;
			[self startAutoSync];
		}
	}
}


@end
