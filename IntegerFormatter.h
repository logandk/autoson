//
//  IntegerFormatter.h
//  Autoson
//
//  Created by Logan Raarup on 20/5/08.
//  Copyright 2008 Logan Raarup. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface IntegerFormatter : NSNumberFormatter {
	
}

- (BOOL) isPartialStringValid: (NSString **) partialStringPtr
        proposedSelectedRange: (NSRangePointer) proposedSelRangePtr
               originalString: (NSString *) origString
        originalSelectedRange: (NSRange) origSelRange
             errorDescription: (NSString **) error;

@end
