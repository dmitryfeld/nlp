//
//  DFWBPhrase.h
//  WordBase
//
//  Created by Dmitry Feld on 8/5/16.
//  Copyright © 2016 Dmitry Feld. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DFWBPhrase : NSObject
@property (readonly,nonatomic) NSUInteger wordCount;
- (instancetype) initWithString:(NSString*)string;
- (NSString*) wordAtIndex:(NSUInteger)index;
@end
