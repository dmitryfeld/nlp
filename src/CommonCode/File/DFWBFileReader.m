//
//  DFWBFileReader.m
//  WordBase
//
//  Created by Dmitry Feld on 7/28/16.
//  Copyright © 2016 Dmitry Feld. All rights reserved.
//

#import "DFWBFileReader.h"
#include <sys/stdio.h>
#include <sys/errno.h>
#import "NSError+Errno.h"
#include "DFWBTools.h"

volatile static NSUInteger __kDFWBFileReaderOpenFileCounter = 0;

@interface DFWBFileReader() {
@private
    __strong NSError* _lastError;
    __strong NSString* _path;
    FILE* _file;
    uint16_t _bufferSize;
    BOOL _canRead;
}
@end

@implementation DFWBFileReader
@synthesize canRead = _canRead;
@synthesize lastError = _lastError;
@synthesize path = _path;
- (instancetype) initWithPath:(NSString*)path {
    if (self = [super init]) {
        _path = [path copy];
        _bufferSize = 512;
        _canRead = NO;
    }
    return self;
}
- (void) open {
    _lastError = nil;
    _canRead = YES;
    _file = fopen(_path.UTF8String, "r");
    if (!_file) {
        _lastError = [NSError errorWithCode:errno];
        _canRead = NO;
    } else {
        DFAtomicIncreaseULong(&__kDFWBFileReaderOpenFileCounter);
    }
}
- (NSString*) nextLine {
    NSString* result = nil;
    if (_file) {
        char buffer[_bufferSize];
        _lastError = nil;
        if (fgets(buffer, _bufferSize, _file)) {
            result = [self prepareString:[NSString stringWithUTF8String:buffer]];
            _canRead = !feof(_file);
        } else {
            _canRead = NO;
            if (ferror(_file)) {
                _lastError = [NSError errorWithCode:errno];
            }
        }
    }
    return result;
}
- (void) close {
    if (_file) {
        if(fclose(_file)) {
            _lastError = [NSError errorWithCode:errno];
        }
        _file = NULL;
        DFAtomicDecreaseULong(&__kDFWBFileReaderOpenFileCounter);
    }
}
- (NSString*) prepareString:(NSString*)line {
    NSString* result = [line stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return result;
}
+ (NSUInteger) openCount {
    return __kDFWBFileReaderOpenFileCounter;
}
@end
