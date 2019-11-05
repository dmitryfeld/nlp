//
//  DFWBSynStorage.h
//  SynProcessor
//
//  Created by Dmitry Feld on 11/4/19.
//  Copyright © 2019 Dmitry Feld. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DFWBSynStorage : NSObject
@property (readonly,nonatomic,strong) NSError* lastError;
@property (readonly,nonatomic,strong) NSString* path;
@property (readonly,nonatomic,strong) NSString* storageName;
- (instancetype) initWithPath:(NSString*)path andStorageName:(NSString*)storageName;
- (void) open;
- (void) addLine:(NSString*)word;
- (void) close;
@end
