//
//  NSString(Lexo).h
//  BaseValidator
//
//  Created by Dmitry Feld on 10/31/19.
//  Copyright © 2019 Dmitry Feld. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString(Lexo)
- (NSUInteger) hammingDistanceTo:(NSString*)string;
- (NSUInteger) levenshteinDistanceTo:(NSString*)string;
- (NSUInteger) damerauLevenshteinDistanceTo:(NSString*)string;
@end
