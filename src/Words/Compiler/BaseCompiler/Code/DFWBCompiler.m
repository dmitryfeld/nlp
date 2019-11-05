//
//  DFWBCompiler.m
//  WordBase
//
//  Created by Dmitry Feld on 7/28/16.
//  Copyright © 2016 Dmitry Feld. All rights reserved.
//

#import "DFWBCompiler.h"

#import "DFWBFileReader.h"
#import "DFWBStorage.h"

@interface DFWBCompiler() {
@private
    __strong NSString* _rootPath;
    __strong NSString* _inputPath;
    __strong NSError* _lastError;
}

@end

@implementation DFWBCompiler
@synthesize lastError = _lastError;
- (instancetype) initWithRootPath:(NSString*)rootPath {
    if (self = [super init]) {
        _rootPath = [rootPath copy];
        _inputPath = [rootPath stringByAppendingPathComponent:@"words.txt"];
        _lastError = nil;
    }
    return self;
}
- (void) execute {
    DFWBFileReader* reader = [[DFWBFileReader alloc] initWithPath:_inputPath];
    DFWBStorage* storage = [[DFWBStorage alloc] initWithPath:_rootPath andStorageName:@"AllWords"];
    NSString* line = nil;
    [storage deploy];
    [reader open];
    if (!reader.lastError) {
        while (reader.canRead) {
            line = [reader nextLine];
            NSLog(@">>>%@<<<",line);
            if (line.length) {
                [storage storeWord:line];
            }
        }
    }
    _lastError = storage.lastError;
    if (!_lastError) {
        [storage persist];
        _lastError = storage.lastError;
    }
    [reader close];
}
@end
