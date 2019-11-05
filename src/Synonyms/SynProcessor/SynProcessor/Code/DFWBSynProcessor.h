//
//  DFWBSynProcessor.h
//  SynProcessor
//
//  Created by Dmitry Feld on 11/4/19.
//  Copyright © 2019 Dmitry Feld. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DFWBSynProcessor : NSObject
@property (strong,readonly,nonatomic) NSError* lastError;
- (instancetype) initWithRootPath:(NSString*)rootPath;
- (void) execute;
@end
