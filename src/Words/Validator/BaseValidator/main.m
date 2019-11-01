//
//  main.m
//  BaseValidator
//
//  Created by Dmitry Feld on 10/30/19.
//  Copyright © 2019 Dmitry Feld. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DFWBValidator.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        const char* path = argv[1];
        NSString* rootPath = [NSString stringWithUTF8String:path];
        DFWBValidator* validator = [[DFWBValidator alloc] initWithRootPath:rootPath];
        if ([validator validateWord:@"tank"]) {
            NSLog(@"tank!");
        }
        if ([validator validateWord:@"tnak"]) {
            NSLog(@"tnak!");
        }
        NSArray<NSString*>* matches = [validator matchesForWord:@"tnak"];
        NSLog(@"!!! %@",matches);
        if ([validator validateWord:@"serena"]) {
            NSLog(@"serena!");
        }
        if ([validator validateWord:@"sreena"]) {
            NSLog(@"sreena!");
        }
        matches = [validator matchesForWord:@"sreena"];
        NSLog(@"!!! %@",matches);
    }
    return 0;
}
