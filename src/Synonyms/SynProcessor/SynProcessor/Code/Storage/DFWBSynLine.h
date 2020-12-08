//
//  DFWBSynLine.h
//  SynProcessor
//
//  Created by Dmitry Feld on 11/7/19.
//  Copyright © 2019 Dmitry Feld. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DFWBSynLine : NSObject
@property (readonly,nonatomic,strong) NSString* word;
@property (readonly,nonatomic,strong) NSArray<NSString*>* synonyms;
@property (readonly,nonatomic,strong) NSString* resultingLine;
- (instancetype) initWithLine:(NSString*)line;
- (NSString*) processLexeme:(NSString*)synonim;
@end
