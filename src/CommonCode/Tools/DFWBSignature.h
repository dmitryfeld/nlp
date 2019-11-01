//
//  DFWBSignature.h
//  WordBase
//
//  Created by Dmitry Feld on 8/4/16.
//  Copyright © 2016 Dmitry Feld. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DFWBSignature : NSObject
- (instancetype) init;
- (uint16_t) hashForWord:(NSString*)word;
@end
