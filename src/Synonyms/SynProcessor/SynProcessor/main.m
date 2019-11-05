//
//  main.m
//  SynProcessor
//
//  Created by Dmitry Feld on 11/4/19.
//  Copyright © 2019 Dmitry Feld. All rights reserved.
//

#import "DFWBSynProcessor.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        const char* path = argv[1];
        NSString* rootPath = [NSString stringWithUTF8String:path];
        DFWBSynProcessor* app = [[DFWBSynProcessor alloc] initWithRootPath:rootPath];
        [app execute];
    }
    return 0;
}
