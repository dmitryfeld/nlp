//
//  DFWBCompiler.h
//  WordBase
//
//  Created by Dmitry Feld on 7/28/16.
//  Copyright © 2016 Dmitry Feld. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DFWBCompiler : NSObject
@property (strong,readonly,nonatomic) NSError* lastError;
- (instancetype) initWithRootPath:(NSString*)rootPath;
- (void) execute;
@end
