//
//  SyncController.h
//  Autoson
//
//  Created by Logan Raarup on 5/6/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface SyncController : NSObject {
	NSTask *ping;
	NSTimer *timer;
	
	BOOL syncStopped;
	BOOL currentStatus;
	BOOL unisonRunning;
	BOOL runLoopActive;
}

- (void) launchThread;
- (void) synchronize;
- (void) startAutoSync;
- (void) stopAutoSync;

@end
