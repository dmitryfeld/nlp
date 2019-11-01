//
//  DFWBBucket.m
//  WordBase
//
//  Created by Dmitry Feld on 8/5/16.
//  Copyright © 2016 Dmitry Feld. All rights reserved.
//

#import "DFWBBucket.h"
#import "DFWBFileWriter.h"
#import "DFWBFileReader.h"

@interface DFWBBucket() {
@private
    __strong NSString* _path;
    __strong NSString* _bucketName;
    __strong NSMutableArray<NSString*>* _words;
    __strong NSError* _lastError;
    NSUInteger _bufferSize;
    NSUInteger _wordCount;
}
@end

@implementation DFWBBucket
@synthesize path = _path;
@synthesize bucketName = _bucketName;
@synthesize bufferSize = _bufferSize;
@synthesize wordCount = _wordCount;
@synthesize lastError = _lastError;
- (instancetype) initWithPath:(NSString*)path andBufferSize:(NSUInteger)bufferSize {
    if (self = [super init]) {
        _path = [path copy];
        _bucketName = [_path lastPathComponent];
        _bufferSize = bufferSize;
        _words = [NSMutableArray<NSString*> new];
        _wordCount = 0;
    }
    return self;
}
- (void) addWord:(NSString*)word {
    //NSLog(@"[STORE TO %@]<<<%@",_bucketName,word);
    [_words addObject:word];
    _wordCount ++;
    if (_words.count == _bufferSize) {
        [self persist];
    }
}
- (NSString*) wordAtIndex:(NSUInteger)index {
    NSString* result = nil;
    if (index < _words.count) {
        result = [_words objectAtIndex:index];
    }
    return result;
}
- (NSUInteger) indexOfWord:(NSString*)word {
    return [_words indexOfObject:word];
}
- (NSArray<DFWBMatch*>*) matchesForWord:(NSString*)word {
    NSMutableArray<DFWBMatch*>* result = [NSMutableArray<DFWBMatch*> new];
    DFWBMatch* temp = nil;
    for (NSString* wrd in _words) {
        temp = [[DFWBMatch alloc] initWithWord:word andMatch:wrd];
        if (temp.distance > 1) {
            continue;
        }
        [result addObject:temp];
    }
    return result;
}
- (void) persist {
    DFWBFileWriter* writer = [[DFWBFileWriter alloc] initWithPath:_path andMode:kDFWBFileWriterModeAppend];
    [writer open];
    if (!(_lastError = writer.lastError)) {
        for (NSString* word in _words) {
            //NSLog(@"WRITE>>>%@ TO %@",word,_bucketName);
            [writer writeLine:word];
            if ((_lastError = writer.lastError)) {
                break;
            }
        }
    }
    [writer close];
    if (!(_lastError = writer.lastError)) {
        [_words removeAllObjects];
    }
}
- (void) load {
    DFWBFileReader* reader = [[DFWBFileReader alloc] initWithPath:_path];
    NSString* line = nil;
    [reader open];
    if (!(_lastError = reader.lastError)) {
        while (reader.canRead) {
            line = [reader nextLine];
            //NSLog(@">>>%@<<<",line);
            if (line.length) {
                [_words addObject:line];
            }
        }
    }
    [reader close];
    _wordCount = _words.count;
    _lastError = reader.lastError;
}
@end
