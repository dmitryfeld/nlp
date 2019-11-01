//
//  DFWBMatch.m
//  BaseValidator
//
//  Created by Dmitry Feld on 10/31/19.
//  Copyright © 2019 Dmitry Feld. All rights reserved.
//

#import "DFWBMatch.h"
#import "NSString+Lexo.h"

@interface DFWBMatch() {
    __strong NSString* _word;
    __strong NSString* _match;
    NSUInteger _distance;
}
@end


@implementation DFWBMatch
@synthesize word = _word;
@synthesize match = _match;
@synthesize distance = _distance;
- (instancetype) initWithWord:(NSString *)word andMatch:(NSString *)match {
    if (self = [super init]) {
        _word = word;
        _match = match;
        _distance = [word damerauLevenshteinDistanceTo:match];
    }
    return self;
}
- (BOOL) isEqual:(id)object {
    DFWBMatch* match = (DFWBMatch*)object;
    if (![match isKindOfClass:[DFWBMatch class]]) {
        return NO;
    }
    if (self.distance != match.distance) {
        return NO;
    }
    if (![self.word isEqualToString:match.word]) {
        return NO;
    }
    if (![self.match isEqualToString:match.match]) {
        return NO;
    }
    return YES;
}
@end
