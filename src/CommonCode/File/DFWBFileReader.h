//
//  DFWBFileReader.h
//  WordBase
//
//  Created by Dmitry Feld on 7/28/16.
//  Copyright © 2016 Dmitry Feld. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DFWBFileReader : NSObject
@property (readonly,nonatomic) BOOL canRead;
@property (readonly,nonatomic,strong) NSError* lastError;
@property (readonly,nonatomic,strong) NSString* path;
- (instancetype) initWithPath:(NSString*)path;
- (void) open;
- (NSString*) nextLine;
- (void) close;
+ (NSUInteger) openCount;
@end
