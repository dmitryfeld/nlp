//
//  DFWBSynLine.m
//  SynProcessor
//
//  Created by Dmitry Feld on 11/7/19.
//  Copyright © 2019 Dmitry Feld. All rights reserved.
//

#import "DFWBSynLine.h"
#import "DFWBValidator.h"


@interface DFWBSynLine() {
    __strong NSString* _word;
    __strong NSMutableArray<NSString*>* _synonyms;
    __strong NSString* _line;
    
    __strong NSString* _resultingLine;
    
    __strong DFWBValidator* _validator;
}
@property (strong,nonatomic,readonly) DFWBValidator* validator;
@end

@implementation DFWBSynLine
@synthesize word = _word;
@synthesize synonyms = _synonyms;
@synthesize validator = _validator;
@synthesize resultingLine = _resultingLine;
- (instancetype) initWithLine:(NSString *)line {
    if (self = [super init]) {
        _line = line;
    }
    return self;
}
- (NSString*) word {
    if (!_word) {
        NSRange colonRange = [_line rangeOfString:@":"];
        if (colonRange.location != NSNotFound) {
            _word = [self processLexeme:[_line substringToIndex:colonRange.location]];
        }
    }
    return _word;
}
- (NSArray<NSString*>*) synonyms {
    if (!_synonyms) {
        NSRange colonRange = [_line rangeOfString:@":"];
        if (colonRange.location != NSNotFound) {
            NSString* synonimsString = [_line substringFromIndex:colonRange.location + 1];
            synonimsString = [synonimsString substringToIndex:synonimsString.length - 1];
            if (synonimsString.length) {
                NSString* temp = nil;
                NSArray<NSString*>* components = [synonimsString componentsSeparatedByString:@","];
                _synonyms = [NSMutableArray<NSString*> new];
                if (components.count) {
                    for (NSString* component in components) {
                        if ((temp = [self processLexeme:component]).length) {
                            [_synonyms addObject:temp];
                        }
                    }
                }
            }
        }
    }
    
    return _synonyms;
}
- (NSString*) processLexeme:(NSString*)lexeme {
    NSString* result = nil;
    lexeme = [lexeme stringByReplacingOccurrencesOfString:@" " withString:@""];
    lexeme = [lexeme lowercaseString];
    if (lexeme.length) {
        if ([self.validator validateWord:lexeme]) {
            result = lexeme;
        } else {
            //NSLog(@"!!!!!::::%@",lexeme);
        }
    }
    return result;
}
- (NSString*) resultingLine {
    if (!_resultingLine) {
        _resultingLine = [NSString stringWithFormat:@"%@: ",self.word];
        for (NSString* synonym in self.synonyms) {
            _resultingLine = [NSString stringWithFormat:@"%@ %@",_resultingLine,synonym];
            _resultingLine = [NSString stringWithFormat:@"%@,",_resultingLine];
        }
        _resultingLine = [_resultingLine substringToIndex:_resultingLine.length - 1];
    }
    return _resultingLine;
}
- (DFWBValidator*) validator {
    if (!_validator) {
        _validator = [[DFWBValidator alloc] initWithRootPath:@"/Users/dfeld/__development/git/nlp/src/Words/Data/root/en"];
    }
    return _validator;
}
@end
