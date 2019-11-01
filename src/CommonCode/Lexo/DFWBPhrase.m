//
//  DFWBPhrase.m
//  WordBase
//
//  Created by Dmitry Feld on 8/5/16.
//  Copyright © 2016 Dmitry Feld. All rights reserved.
//

#import "DFWBPhrase.h"

@interface DFWBPhrase() {
@private
    __strong NSString* _string;
    __strong NSArray* _components;
}

@end

@implementation DFWBPhrase
@dynamic wordCount;
- (instancetype) initWithString:(NSString*)string {
    if (self = [super init]) {
        _string = [string copy];
        NSMutableCharacterSet* set = [NSMutableCharacterSet whitespaceCharacterSet];
        [set formUnionWithCharacterSet:[NSCharacterSet punctuationCharacterSet]];
        _components = [string componentsSeparatedByCharactersInSet:set];
    }
    return self;
}
- (NSString*) wordAtIndex:(NSUInteger)index {
    NSString* result = nil;
    if (index < _components.count) {
        result = [_components objectAtIndex:index];
    }
    return result;
}
- (NSUInteger) wordCount {
    return _components.count;
}
@end
