//
//  DFWBFileWriter.m
//  WordBase
//
//  Created by Dmitry Feld on 8/4/16.
//  Copyright © 2016 Dmitry Feld. All rights reserved.
//

#import "DFWBFileWriter.h"
#include <sys/stdio.h>
#include <sys/errno.h>
#import "NSError+Errno.h"
#include "DFWBTools.h"

volatile static NSUInteger __kDFWBFileWriterOpenFileCounter = 0;

@interface DFWBFileWriter() {
@private
    __strong NSError* _lastError;
    __strong NSString* _path;
    FILE* _file;
    uint16_t _bufferSize;
    DFWBFileWriterModes _mode;
    BOOL _canWrite;
}
@end

@implementation DFWBFileWriter
@synthesize canWrite = _canWrite;
@synthesize lastError = _lastError;
@synthesize path = _path;
@synthesize mode = _mode;
- (instancetype) initWithPath:(NSString*)path {
    if (self = [super init]) {
        _path = [path copy];
        _bufferSize = 512;
        _mode = kDFWBFileWriterModeRewrite;
        _canWrite = NO;
    }
    return self;
}
- (instancetype) initWithPath:(NSString*)path andMode:(DFWBFileWriterModes)mode {
    if (self = [super init]) {
        _path = [path copy];
        _bufferSize = 512;
        _mode = mode;
        _canWrite = NO;
    }
    return self;
}

- (void) open {
    _lastError = nil;
    _canWrite = YES;
    _file = fopen(_path.UTF8String,[self getModeString]);
    if (!_file) {
        _lastError = [NSError errorWithCode:errno];
        _canWrite = NO;
    } else {
        DFAtomicIncreaseULong(&__kDFWBFileWriterOpenFileCounter);
    }
}
- (void) writeLine:(NSString*)line {
    if (_file) {
        const char* string = [self prepareLine:line].UTF8String;
        _lastError = nil;
        if (string) {
            if (!fwrite(string, 1, MIN(strlen(string),_bufferSize), _file)) {
                if (ferror(_file)) {
                    _canWrite = NO;
                    _lastError = [NSError errorWithCode:errno];
                }
            }
        }
    }
}
- (void) close {
    if (_file) {
        if (!fclose(_file)) {
            if (ferror(_file)) {
                _lastError = [NSError errorWithCode:errno];
            }
        }
        _file = NULL;
        DFAtomicDecreaseULong(&__kDFWBFileWriterOpenFileCounter);
    }
}
- (NSString*) prepareLine:(NSString*)string {
    NSString* result = [string stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    result = [result stringByAppendingString:@"\n"];
    return result;
}
- (const char*) getModeString {
    const char* result = "w";
    if (_mode == kDFWBFileWriterModeAppend) {
        result ="a";
    }
    return result;
}
+ (NSUInteger) openCount {
    return __kDFWBFileWriterOpenFileCounter;
}
@end
