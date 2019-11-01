//
//  DFWBDirectory.m
//  WordBase
//
//  Created by Dmitry Feld on 8/6/16.
//  Copyright © 2016 Dmitry Feld. All rights reserved.
//

#import "DFWBDirectory.h"
#include <sys/stat.h>
#include <sys/types.h>
#include <sys/errno.h>
#include <sys/dirent.h>
#import "NSError+Errno.h"

@interface DFWBFile(Public)
- (void) setLastError:(NSError*)lastError;
@end

@implementation DFWBDirectory
@dynamic exists;
- (void) create {
    [super setLastError:nil];
    if (mkdir(self.path.UTF8String,S_IRWXU|S_IRWXG)) {
        [super setLastError:[NSError errorWithCode:errno]];
    }
}
- (void) remove {
    [super setLastError:nil];
    if (rmdir(self.path.UTF8String)) {
        [super setLastError:[NSError errorWithCode:errno]];
    }
}
- (BOOL) exists {
    struct stat dirStat;
    int err = stat(self.path.UTF8String, &dirStat);
    if(-1 == err) {
        [super setLastError:[NSError errorWithCode:errno]];
    } else {
        if(S_ISDIR(dirStat.st_mode)) {
            return YES;
        }
    }
    return NO;
}

- (NSArray<DFWBFile*>*) list {
    NSMutableArray<NSString*>* files = [NSMutableArray<NSString*> new];
    NSMutableArray<NSString*>* directories = [NSMutableArray<NSString*> new];
    NSMutableArray<DFWBFile*>* result = [NSMutableArray<DFWBFile*> new];
    NSString* tempS = nil;
    DFWBFile* tempF = nil;
    DFWBDirectory* tempD = nil;
    DIR* directory = opendir(self.path.UTF8String);
    if (directory) {
        struct dirent *entry;
        while((entry = readdir(directory)) != NULL) {
            if (DT_DIR == (entry->d_type & DT_DIR)) {
                if(!strcmp(".",entry->d_name)) {
                    continue;
                }
                if(!strcmp("..",entry->d_name)) {
                    continue;
                }
                tempS = [NSString stringWithUTF8String:entry->d_name];
                [directories addObject:[self.path stringByAppendingPathComponent:tempS]];
            }
            if (DT_REG == (entry->d_type & DT_REG)) {
                tempS = [NSString stringWithUTF8String:entry->d_name];
                [files addObject:[self.path stringByAppendingPathComponent:tempS]];
            }
        }
        
        id comp = ^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            NSString* str1 = (NSString*)obj1;
            NSString* str2 = (NSString*)obj2;
            
            if ([str1 isKindOfClass:[NSString class]]) {
                if ([str2 isKindOfClass:[NSString class]]) {
                    return [str1 compare:str2];
                }
            }
            return NSOrderedSame;
        };
        
        [directories sortUsingComparator:comp];
        [files sortUsingComparator:comp];
        
        for (NSString* directory in directories) {
            tempD = [[DFWBDirectory alloc] initWithPath:directory];
            [result addObject:tempD];
        }
        for (NSString* file in files) {
            tempF = [[DFWBFile alloc] initWithPath:file];
            [result addObject:tempF];
        }
        
    } else {
        [super setLastError:[NSError errorWithCode:errno]];
    }
    
    return result;
}
@end
