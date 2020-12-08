//
//  DFWBValidator.h
//  BaseValidator
//
//  Created by Dmitry Feld on 10/31/19.
//  Copyright © 2019 Dmitry Feld. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DFWBValidator : NSObject
@property (strong,readonly,nonatomic) NSError* lastError;
- (instancetype) initWithRootPath:(NSString*)rootPath;
- (BOOL) validateWord:(NSString*)word;
- (NSArray<NSString*>*) matchesForWord:(NSString*)word;
@end
