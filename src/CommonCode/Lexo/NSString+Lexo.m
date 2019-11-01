//
//  NSString(Lexo).m
//  BaseValidator
//
//  Created by Dmitry Feld on 10/31/19.
//  Copyright © 2019 Dmitry Feld. All rights reserved.
//

#import "NSString+Lexo.h"

@implementation NSString(Lexo)
- (NSUInteger) hammingDistanceTo:(NSString*)string {
    NSUInteger result = NSNotFound;
    if (self.length == string.length) {
        result = 0;
        if (self.length) {
            for (int index = 0; index < self.length; index ++) {
                if ([self characterAtIndex:index] != [string characterAtIndex:index]) {
                    result ++;
                }
            }
        }
    }
    return result;
}
- (NSUInteger) levenshteinDistanceTo:(NSString*)string {
    NSUInteger sl = [self length];
    NSUInteger tl = [string length];
    NSUInteger *d = calloc(sizeof(*d), (sl+1) * (tl+1));
    
#define d(i, j) d[((j) * sl) + (i)]
    for (NSUInteger i = 0; i <= sl; i++) {
        d(i, 0) = i;
    }
    for (NSUInteger j = 0; j <= tl; j++) {
        d(0, j) = j;
    }
    for (NSUInteger j = 1; j <= tl; j++) {
        for (NSUInteger i = 1; i <= sl; i++) {
            if ([self characterAtIndex:i-1] == [string characterAtIndex:j-1]) {
                d(i, j) = d(i-1, j-1);
            } else {
                d(i, j) = MIN(d(i-1, j), MIN(d(i, j-1), d(i-1, j-1))) + 1;
            }
        }
    }
    
    NSUInteger r = d(sl, tl);
#undef d
    
    free(d);
    
    return r;
}
- (NSUInteger) damerauLevenshteinDistanceTo:(NSString*)string {
    NSUInteger l_string_length1 = self.length;
    NSUInteger l_string_length2 = string.length;
    int d[l_string_length1+1][l_string_length2+1];
    
    int i;
    int j;
    int l_cost;
    
    for (i = 0;i <= l_string_length1;i++)
    {
        d[i][0] = i;
    }
    for(j = 0; j<= l_string_length2; j++)
    {
        d[0][j] = j;
    }
    for (i = 1;i <= l_string_length1;i++)
    {
        for(j = 1; j<= l_string_length2; j++)
        {
            if( [self characterAtIndex:i-1] == [string characterAtIndex:j-1] )
            {
                l_cost = 0;
            }
            else
            {
                l_cost = 1;
            }
            d[i][j] = MIN(
                          d[i-1][j] + 1,                  // delete
                          MIN(d[i][j-1] + 1,         // insert
                              d[i-1][j-1] + l_cost)           // substitution
                          );
            if( (i > 1) &&
               (j > 1) &&
               ([self characterAtIndex:i-1] == [string characterAtIndex:j-2]) &&
               ([self characterAtIndex:i-2] == [string characterAtIndex:j-1])
               )
            {
                d[i][j] = MIN(
                              d[i][j],
                              d[i-2][j-2] + l_cost   // transposition
                              );
            }
        }
    }
    return d[l_string_length1][l_string_length2];
}
NSUInteger damerau_levenshtein_distance(NSString* p_string1, NSString* p_string2)
{
    NSUInteger l_string_length1 = p_string1.length;
    NSUInteger l_string_length2 = p_string2.length;
    int d[l_string_length1+1][l_string_length2+1];
    
    int i;
    int j;
    int l_cost;
    
    for (i = 0;i <= l_string_length1;i++)
    {
        d[i][0] = i;
    }
    for(j = 0; j<= l_string_length2; j++)
    {
        d[0][j] = j;
    }
    for (i = 1;i <= l_string_length1;i++)
    {
        for(j = 1; j<= l_string_length2; j++)
        {
            if( [p_string1 characterAtIndex:i-1] == [p_string2 characterAtIndex:j-1] )
            {
                l_cost = 0;
            }
            else
            {
                l_cost = 1;
            }
            d[i][j] = MIN(
                               d[i-1][j] + 1,                  // delete
                               MIN(d[i][j-1] + 1,         // insert
                                        d[i-1][j-1] + l_cost)           // substitution
                               );
            if( (i > 1) &&
               (j > 1) &&
               ([p_string1 characterAtIndex:i-1] == [p_string2 characterAtIndex:j-2]) &&
               ([p_string1 characterAtIndex:i-2] == [p_string2 characterAtIndex:j-1])
               )
            {
                d[i][j] = MIN(
                                   d[i][j],
                                   d[i-2][j-2] + l_cost   // transposition
                                   );
            }
        }
    }
    return d[l_string_length1][l_string_length2];
}
@end
