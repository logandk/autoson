//
//  IntegerFormatter.m
//  Autoson
//
//  Created by Logan Raarup on 20/5/08.
//  Copyright 2008 Logan Raarup. All rights reserved.
//

#import "IntegerFormatter.h"


@implementation IntegerFormatter


- (BOOL) isPartialStringValid: (NSString **) partialStringPtr
        proposedSelectedRange: (NSRangePointer) proposedSelRangePtr
               originalString: (NSString *) origString
        originalSelectedRange: (NSRange) origSelRange
             errorDescription: (NSString **) error
{
    NSCharacterSet *nonDigits;
    NSRange newStuff;
    NSString *newStuffString;

    nonDigits = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    newStuff = NSMakeRange(origSelRange.location,
                           proposedSelRangePtr->location
                           - origSelRange.location);
    newStuffString = [*partialStringPtr substringWithRange: newStuff];

    if ([newStuffString rangeOfCharacterFromSet: nonDigits
            options: NSLiteralSearch].location != NSNotFound) {
        *error = @"Input is not an integer";
		NSBeep();
        return (NO);
    }
	
	if ([*partialStringPtr intValue] > 999 || [*partialStringPtr intValue] < 1)
	{
		*error = @"Input is out of range";
		NSBeep();
        return (NO);
	}

	*error = nil;
	return (YES);
}


@end
