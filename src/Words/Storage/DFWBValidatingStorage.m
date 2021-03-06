//
//  DFWBValidatingStorage.m
//  BaseValidator
//
//  Created by Dmitry Feld on 10/31/19.
//  Copyright © 2019 Dmitry Feld. All rights reserved.
//

#import "DFWBValidatingStorage.h"
#import "DFWBSignature.h"
#import "DFWBBucket.h"

@interface DFWBStorage(DFWBValidatingStorage)
@property (readonly,nonatomic,strong) DFWBSignature* signature;
@property (readonly,nonatomic,strong) NSMutableDictionary<NSString*,DFWBBucket*>* buckets;
@end


@interface DFWBValidatingStorage() {
    
}
@end

@implementation DFWBValidatingStorage
- (BOOL) validateWord:(NSString*)word {
    BOOL result = NO;
    uint16_t hash = [self.signature hashForWord:word];
    if (hash) {
        NSString* hashKey = [NSString stringWithFormat:@"%hu",hash];
        DFWBBucket* bucket = [self.buckets objectForKey:hashKey];
        if (bucket) {
            result = (NSNotFound != [bucket indexOfWord:word]);
        }
    }
    return result;
}
- (NSArray<NSString*>*) matchesForWord:(NSString*)word {
    NSMutableArray<NSString*>* result = [NSMutableArray<NSString*> new];
    uint16_t hash = [self.signature hashForWord:word];
    if (hash) {
        NSString* hashKey = [NSString stringWithFormat:@"%hu",hash];
        DFWBBucket* bucket = [self.buckets objectForKey:hashKey];
        if (bucket) {
            NSArray<DFWBMatch*>* matches = [self matchesFromBucket:bucket forWord:word];
            for (DFWBMatch* match in matches) {
                [result addObject:match.match];
            }
        }
    }
    return result;
}
- (NSArray<DFWBMatch*>*) matchesFromBucket:(DFWBBucket*)bucket forWord:(NSString*)word {
    NSArray<DFWBMatch*>* matches = nil;
    DFWBBucket* nextBucket = bucket;
    while (nextBucket) {
        if ((matches = [nextBucket matchesForWord:word]).count) {
            break;
        }
        nextBucket = [self relatedBucket:nextBucket next:YES];
    }
    if (!matches.count) {
        nextBucket = bucket;
        while (nextBucket) {
            if ((matches = [nextBucket matchesForWord:word]).count) {
                break;
            }
            nextBucket = [self relatedBucket:nextBucket next:NO];
        }
    }
    return matches;
}
- (DFWBBucket*) relatedBucket:(DFWBBucket*)bucket next:(BOOL)next; {
    DFWBBucket* result = nil;
    NSArray<NSString*>* names = [self.buckets.allKeys sortedArrayUsingSelector:@selector(compare:)];
    NSUInteger index = [names indexOfObject:bucket.bucketName];
    NSString* key = nil;
    if (NSNotFound != index) {
        
        if (next) {
            index ++;
        } else {
            index --;
        }
        
        if (index < names.count) {
            key = [names objectAtIndex:index];
            result = [self.buckets objectForKey:key];
        }
    }
    return result;
}
@end
