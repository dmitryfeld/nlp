//
//  main.m
//  WordBase
//
//  Created by Dmitry Feld on 7/28/16.
//  Copyright © 2016 Dmitry Feld. All rights reserved.
//

#import "DFWBCompiler.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        const char* path = argv[1];
        NSString* rootPath = [NSString stringWithUTF8String:path];
        DFWBCompiler* app = [[DFWBCompiler alloc] initWithRootPath:rootPath];
        [app execute];
    }
    return 0;
}
