//
//  DFWBBucket.h
//  WordBase
//
//  Created by Dmitry Feld on 8/5/16.
//  Copyright © 2016 Dmitry Feld. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DFWBMatch.h"

@interface DFWBBucket : NSObject
@property (readonly,nonatomic,strong) NSString* path;
@property (readonly,nonatomic,strong) NSString* bucketName;
@property (readonly,nonatomic) NSUInteger bufferSize;
@property (readonly,nonatomic) NSUInteger wordCount;
@property (readonly,nonatomic) NSError* lastError;
- (instancetype) initWithPath:(NSString*)path andBufferSize:(NSUInteger)bufferSize;
- (void) addWord:(NSString*)word;
- (NSString*) wordAtIndex:(NSUInteger)index;
- (NSUInteger) indexOfWord:(NSString*)word;
- (NSArray<DFWBMatch*>*) matchesForWord:(NSString*)word;
- (void) persist;
- (void) load;
@end
