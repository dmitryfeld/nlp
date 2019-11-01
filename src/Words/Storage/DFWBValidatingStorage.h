//
//  DFWBValidatingStorage.h
//  BaseValidator
//
//  Created by Dmitry Feld on 10/31/19.
//  Copyright © 2019 Dmitry Feld. All rights reserved.
//

#import "DFWBStorage.h"

@interface DFWBValidatingStorage : DFWBStorage
- (BOOL) validateWord:(NSString*)word;
- (NSArray<NSString*>*) matchesForWord:(NSString*)word;
@end
