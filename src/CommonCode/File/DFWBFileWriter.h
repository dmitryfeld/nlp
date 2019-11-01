//
//  DFWBFileWriter.h
//  WordBase
//
//  Created by Dmitry Feld on 8/4/16.
//  Copyright © 2016 Dmitry Feld. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum __DFWBFileWriterModes__:NSUInteger {
    kDFWBFileWriterModeRewrite,
    kDFWBFileWriterModeAppend
} DFWBFileWriterModes;

@interface DFWBFileWriter : NSObject
@property (readonly,nonatomic) BOOL canWrite;
@property (readonly,nonatomic,strong) NSError* lastError;
@property (readonly,nonatomic,strong) NSString* path;
@property (readonly,nonatomic) DFWBFileWriterModes mode;
- (instancetype) initWithPath:(NSString*)path;
- (instancetype) initWithPath:(NSString*)path andMode:(DFWBFileWriterModes)mode;
- (void) open;
- (void) writeLine:(NSString*)line;
- (void) close;
+ (NSUInteger) openCount;
@end
