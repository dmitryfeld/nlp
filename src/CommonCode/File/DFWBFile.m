//
//  DFWBFile.m
//  WordBase
//
//  Created by Dmitry Feld on 8/6/16.
//  Copyright © 2016 Dmitry Feld. All rights reserved.
//

#import "DFWBFile.h"
#include <sys/stat.h>
#include <sys/types.h>
#include <sys/errno.h>
#import "NSError+Errno.h"

@interface DFWBFile() {
@private
    __strong NSString* _path;
    __strong NSError* _lastError;
}
@end


@implementation DFWBFile
@synthesize path = _path;
@synthesize lastError = _lastError;
@dynamic exists;
- (instancetype) initWithPath:(NSString*)path {
    if (self = [super init]) {
        _path = [path copy];
    }
    return self;
}
- (void) create {
    FILE* file = fopen(_path.UTF8String, "rw");
    if (!file) {
        _lastError = [NSError errorWithCode:errno];
    } else {
        if (!fclose(file)) {
            if (ferror(file)) {
                _lastError = [NSError errorWithCode:errno];
            }
        }
    }
}
- (void) remove {
    _lastError = nil;
    if (unlink(_path.UTF8String)) {
        _lastError = [NSError errorWithCode:errno];
    }
}
- (BOOL) exists {
    struct stat dirStat;
    int err = stat(self.path.UTF8String, &dirStat);
    if(-1 == err) {
        _lastError = [NSError errorWithCode:errno];
    } else {
        if(S_ISREG(dirStat.st_mode)) {
            return YES;
        }
    }
    return NO;
}
- (void) setLastError:(NSError*)lastError {
    _lastError = [lastError copy];
}
@end
