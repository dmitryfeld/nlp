//
//  SynProcessor.m
//  SynProcessor
//
//  Created by Dmitry Feld on 11/4/19.
//  Copyright © 2019 Dmitry Feld. All rights reserved.
//

#import "DFWBSynProcessor.h"
#import "DFWBFileReader.h"
#import "DFWBFileWriter.h"
#import "DFWBSynLine.h"


@interface DFWBSynProcessor() {
@private
    __strong NSString* _rootPath;
    __strong NSString* _inputPath;
    __strong NSString* _outputPath;
    __strong NSError* _lastError;
}
@end


@implementation DFWBSynProcessor
@dynamic lastError;
- (instancetype) initWithRootPath:(NSString*)rootPath {
    if (self = [super init]) {
        _rootPath = [rootPath copy];
        _inputPath = [rootPath stringByAppendingPathComponent:@"synonyms_in.txt"];
        _outputPath = [rootPath stringByAppendingPathComponent:@"synonyms_out.txt"];
    }
    return self;
}
- (void) execute {
    DFWBFileReader* reader = [[DFWBFileReader alloc] initWithPath:_inputPath];
    DFWBFileWriter* writer = [[DFWBFileWriter alloc] initWithPath:_outputPath andMode:kDFWBFileWriterModeRewrite];
    NSString* line = nil;
    [reader open];
    [writer open];
    if ((!reader.lastError) && (!writer.lastError)) {
        while (reader.canRead) {
            line = [reader nextLine];
            line = [self validateLine:line];
            if (line.length) {
                //NSLog(@">>>%@<<<",line);
                [writer writeLine:line];
                [writer writeLine:@""];
            }
        }
    }
    [writer close];
    [reader close];
    
    _lastError = writer.lastError;
    if (!_lastError) {
        _lastError = reader.lastError;
    }
}
- (NSString*) validateLine:(NSString*)string {
    NSString* result = nil;
    DFWBSynLine* line = [[DFWBSynLine alloc] initWithLine:string];
    if (line.word.length) {
        result = line.resultingLine;
    }
    return result;
}
@end
