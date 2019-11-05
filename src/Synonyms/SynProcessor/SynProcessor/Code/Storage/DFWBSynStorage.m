//
//  DFWBSynStorage.m
//  SynProcessor
//
//  Created by Dmitry Feld on 11/4/19.
//  Copyright © 2019 Dmitry Feld. All rights reserved.
//

#import "DFWBSynStorage.h"

#import "DFWBSignature.h"

#import "DFWBDirectory.h"
#import "DFWBFileWriter.h"
#import "DFWBFileReader.h"
#import "DFWBPhrase.h"

@interface DFWBSynStorage() {
@private
    __strong NSString* _path;
    __strong NSString* _storageName;
    __strong DFWBFileWriter* _writer;
}
@end

@implementation DFWBSynStorage
@dynamic lastError;
@synthesize path = _path;
@synthesize storageName = _storageName;
- (instancetype) initWithPath:(NSString*)path andStorageName:(NSString*)storageName {
    if (self = [super init]) {
        _path = [path copy];
        _storageName = [storageName copy];
        _writer = [[DFWBFileWriter alloc] initWithPath:_path andMode:kDFWBFileWriterModeRewrite];
    }
    return self;
}
- (void) open {
    [_writer open];
}
- (void) addLine:(NSString*)word {
    [_writer writeLine:word];
}
- (void) close {
    [_writer close];
}
- (NSError*) lastError {
    return _writer.lastError;
}
@end
