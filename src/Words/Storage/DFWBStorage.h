//
//  DFWBStorage.h
//  WordBase
//
//  Created by Dmitry Feld on 8/5/16.
//  Copyright © 2016 Dmitry Feld. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DFWBStorage : NSObject
@property (readonly,nonatomic,strong) NSError* lastError;
@property (readonly,nonatomic,strong) NSString* path;
@property (readonly,nonatomic,strong) NSString* storageName;
- (instancetype) initWithPath:(NSString*)path andStorageName:(NSString*)storageName;
- (void) deploy;
- (void) storeWord:(NSString*)word;
- (void) persist;
- (void) load;
@end
