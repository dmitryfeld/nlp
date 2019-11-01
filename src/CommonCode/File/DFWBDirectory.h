//
//  DFWBDirectory.h
//  WordBase
//
//  Created by Dmitry Feld on 8/6/16.
//  Copyright © 2016 Dmitry Feld. All rights reserved.
//

#import "DFWBFile.h"

@interface DFWBDirectory : DFWBFile
- (NSArray<DFWBFile*>*) list;
@end
