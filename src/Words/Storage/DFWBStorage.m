//
//  DFWBStorage.m
//  WordBase
//
//  Created by Dmitry Feld on 8/5/16.
//  Copyright © 2016 Dmitry Feld. All rights reserved.
//

#import "DFWBStorage.h"
#import "DFWBSignature.h"
#import "DFWBBucket.h"

#import "DFWBDirectory.h"
#import "DFWBFileWriter.h"
#import "DFWBFileReader.h"
#import "DFWBPhrase.h"

@interface DFWBStorage() {
@private
    __strong NSString* _path;
    __strong NSMutableDictionary<NSString*,DFWBBucket*>* _buckets;
    __strong DFWBSignature* _signature;
    __strong NSError* _lastError;
    __strong NSString* _storageName;
}
@property (readonly,nonatomic,strong) DFWBSignature* signature;
@property (readonly,nonatomic,strong) NSMutableDictionary<NSString*,DFWBBucket*>* buckets;
@end

@implementation DFWBStorage
@synthesize lastError = _lastError;
@synthesize path = _path;
@synthesize storageName = _storageName;
@dynamic signature;
@dynamic buckets;
- (instancetype) initWithPath:(NSString*)path andStorageName:(NSString*)storageName {
    if (self = [super init]) {
        _path = [path copy];
        _storageName = [storageName copy];
    }
    return self;
}
- (void) deploy {
    NSString* storagePath = [_path stringByAppendingPathComponent:_storageName];
    DFWBDirectory* storageDir = [[DFWBDirectory alloc] initWithPath:storagePath];
    if (storageDir.exists) {
        [self destroyDir:storageDir];
    }
    [storageDir create];
}
- (void) storeWord:(NSString*)word {
    uint16_t hash = [self.signature hashForWord:word];
    if (hash) {
        NSString* hashKey = [NSString stringWithFormat:@"%hu",hash];
        DFWBBucket* bucket = [self.buckets objectForKey:hashKey];
        if (!bucket) {
            NSString* bucketPath = [_path stringByAppendingPathComponent:_storageName];
            bucketPath = [bucketPath stringByAppendingPathComponent:hashKey];
            bucket = [[DFWBBucket alloc] initWithPath:bucketPath andBufferSize:1024];
            [self.buckets setObject:bucket forKey:hashKey];
        }
        [bucket addWord:word];
        _lastError = bucket.lastError;
    }
}
- (void) persist {
    NSArray<NSString*>* keys = self.buckets.allKeys;
    DFWBBucket* bucket = nil;
    for (NSString* key in keys) {
        bucket = [self.buckets objectForKey:key];
        [bucket persist];
        _lastError = bucket.lastError;
    }
    [self saveMetadata];
}
- (void) load {
    NSString* storagePath = [_path stringByAppendingPathComponent:_storageName];
    DFWBDirectory* storageDirectory = [[DFWBDirectory alloc] initWithPath:storagePath];
    NSArray<DFWBFile*>* list = storageDirectory.list;
    NSString* hashKey = nil;
    DFWBBucket* temp = nil;
    _buckets = nil;
    for (DFWBFile* file in list) {
        hashKey = [file.path lastPathComponent];
        temp = [[DFWBBucket alloc] initWithPath:file.path andBufferSize:1024];
        [temp load];
        if (!temp.lastError) {
            [self.buckets setObject:temp forKey:hashKey];
        } else {
            _lastError = temp.lastError;
            break;
        }
    }
    if (!_lastError) {
        [self checkMetadata];
    }
}
- (DFWBSignature*) signature {
    if (!_signature) {
        _signature = [DFWBSignature new];
    }
    return _signature;
}
- (NSMutableDictionary<NSString*,DFWBBucket*>*) buckets {
    if (!_buckets) {
        _buckets = [NSMutableDictionary<NSString*,DFWBBucket*> new];
    }
    return _buckets;
}
- (DFWBFileWriter*) metadataWriter {
    NSString* writerPath = [_path stringByAppendingPathComponent:_storageName];
    writerPath = [writerPath stringByAppendingPathExtension:@"info"];
    return [[DFWBFileWriter alloc] initWithPath:writerPath andMode:kDFWBFileWriterModeRewrite];
}
- (DFWBFileReader*) metadataReader {
    NSString* readerPath = [_path stringByAppendingPathComponent:_storageName];
    readerPath = [readerPath stringByAppendingPathExtension:@"info"];
    return [[DFWBFileReader alloc] initWithPath:readerPath];
}

- (NSString*) serviceStringForBucket:(DFWBBucket*)bucket {
    NSString* bucketName = bucket.bucketName;
    NSUInteger wordCount = bucket.wordCount;
    return [NSString stringWithFormat:@"%@ %ld",bucketName,wordCount];
}
- (void) saveMetadata {
    NSArray<NSString*>* metadata = [self collectMetadata];
    DFWBFileWriter* writer = [self metadataWriter];
    [writer open];
    for (NSString* meta in metadata) {
        if (!writer.lastError) {
            [writer writeLine:meta];
        }
    }
    [writer close];
}
- (void) checkMetadata {
    NSArray<NSString*>* metadata = [self collectMetadata];
    DFWBFileReader* reader = [self metadataReader];
    NSString* line = nil;
    [reader open];
    if (!(_lastError = reader.lastError)) {
        while ([reader canRead]) {
            line = [reader nextLine];
            //NSLog(@">>>%@<<<",line);
            if (line.length) {
                if (NSNotFound == [metadata indexOfObject:line]) {
                    NSLog(@">>>GENERAL EXCEPTION: INCONSISTENT DATA<<<");
                    abort();
                }
            }
        }
    }
    [reader close];
}
- (NSArray<NSString*>*) collectMetadata {
    NSMutableArray<NSString*>* result = [NSMutableArray<NSString*> new];
    NSArray<NSString*>* keys = self.buckets.allKeys;
    DFWBBucket* bucket = nil;
    for (NSString* key in keys) {
        bucket = [self.buckets objectForKey:key];
        [result addObject:[self serviceStringForBucket:bucket]];
    }
    [result sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        NSString* str1 = (NSString*)obj1;
        NSString* str2 = (NSString*)obj2;
        
        if ([str1 isKindOfClass:[NSString class]]) {
            if ([str2 isKindOfClass:[NSString class]]) {
                DFWBPhrase* phrase1 = [[DFWBPhrase alloc] initWithString:str1];
                DFWBPhrase* phrase2 = [[DFWBPhrase alloc] initWithString:str2];
                if (phrase1.wordCount > 1) {
                    if (phrase2.wordCount > 1) {
                        str1 = [phrase1 wordAtIndex:1];
                        str2 = [phrase2 wordAtIndex:1];
                        if (str1) {
                            if (str2) {
                                NSUInteger int1 = str1.integerValue;
                                NSUInteger int2 = str2.integerValue;
                                if (int2 > int1) {
                                    return NSOrderedDescending;
                                }
                                if (int2 < int1) {
                                    return NSOrderedAscending;
                                }
                            }
                        }
                    }
                }
            }
        }
        return NSOrderedSame;
    }];
    return result;
}
- (void) destroyDir:(DFWBDirectory*) directory {
    NSArray<DFWBFile*>* list = [directory list];
    for (DFWBFile* file in list) {
        if ([file isKindOfClass:[DFWBDirectory class]]) {
            [self destroyDir:(DFWBDirectory*)file];
        } else {
            [file remove];
        }
    }
    [directory remove];
}

@end
