//
//  DFWBMatch.h
//  BaseValidator
//
//  Created by Dmitry Feld on 10/31/19.
//  Copyright © 2019 Dmitry Feld. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DFWBMatch : NSObject
@property (readonly,nonatomic,strong) NSString* word;
@property (readonly,nonatomic,strong) NSString* match;
@property (readonly,nonatomic) NSUInteger distance;
- (instancetype) initWithWord:(NSString*)word andMatch:(NSString*)match;
@end
