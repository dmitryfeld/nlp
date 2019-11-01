//
//  DFWBValidator.m
//  BaseValidator
//
//  Created by Dmitry Feld on 10/31/19.
//  Copyright © 2019 Dmitry Feld. All rights reserved.
//

#import "DFWBValidator.h"
#import "DFWBValidatingStorage.h"

@interface DFWBValidator() {
    __strong DFWBValidatingStorage* _storage;
    __strong NSError* _lastError;
}
@end

@implementation DFWBValidator
@dynamic lastError;
- (instancetype) initWithRootPath:(NSString*)rootPath {
    if (self = [super init]) {
        _storage = [[DFWBValidatingStorage alloc] initWithPath:rootPath andStorageName:@"Storage"];
        [_storage load];
    }
    return self;
}
- (BOOL) validateWord:(NSString *)word {
    return [_storage validateWord:word];
}
- (NSArray<NSString*>*) matchesForWord:(NSString *)word {
    return [_storage matchesForWord:word];
}
- (NSError*) lastError {
    return _storage.lastError;
}
@end
