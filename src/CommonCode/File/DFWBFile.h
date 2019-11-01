//
//  DFWBFile.h
//  WordBase
//
//  Created by Dmitry Feld on 8/6/16.
//  Copyright © 2016 Dmitry Feld. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DFWBFile : NSObject
@property (readonly,nonatomic,strong) NSString* path;
@property (readonly,nonatomic,strong) NSError* lastError;
@property (readonly,nonatomic) BOOL exists;
- (instancetype) initWithPath:(NSString*)path;
- (void) create;
- (void) remove;
@end
