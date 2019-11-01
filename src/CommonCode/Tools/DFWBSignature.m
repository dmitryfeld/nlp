//
//  DFWBSignature.m
//  WordBase
//
//  Created by Dmitry Feld on 8/4/16.
//  Copyright © 2016 Dmitry Feld. All rights reserved.
//

#import "DFWBSignature.h"

static const uint16_t _maskPower            =   0x0010;
static const uint16_t _bucketPower          =   0x0004;

static const uint16_t _masks[_maskPower]    =   {0x0001,            //0х00
                                                0x0002,             //0х01
                                                0x0004,             //0х02
                                                0x0008,             //0х03
                                                0x0010,             //0х04
                                                0x0020,             //0х05
                                                0x0040,             //0х06
                                                0x0080,             //0х07
                                                0x0100,             //0х08
                                                0x0200,             //0х09
                                                0x0400,             //0х0А
                                                0x0800,             //0х0B
                                                0x1000,             //0х0C
                                                0x2000,             //0х0D
                                                0x4000,             //0х0E
                                                0x8000};            //0х0F
static const uint16_t _buckets[_maskPower][_bucketPower]
                                            =   {{'A','W','Q','Z'}, //0х00
                                                {'E','S','D','X'},  //0х01
                                                {'R','F','C','V'},  //0х02
                                                {'T','G','B','N'},  //0х03
                                                {'Y','H','U','J'},  //0х04
                                                {'I','K','M',','},  //0х05
                                                {'O','L','<','.'},  //0х06
                                                {'P',':','>','?'},  //0х07
                                                {'"','{','}','\''}, //0х08
                                                {'[',']','|','/'},  //0х09
                                                {'1','2','3','4'},  //0х0A
                                                {'5','6','7','8'},  //0х0B
                                                {'9','0','!','2'},  //0х0C
                                                {'#','$','%','&'},  //0х0D
                                                {'*','(',')','_'},  //0х0E
                                                {'-','+','=','~'}}; //0х0F

boolean_t maskForSymbol(char symbol,uint16_t* mask);
boolean_t bucketForSymbol(char symbol,uint16_t* bucket);
uint16_t hashForWord(const char* symbols);

@interface DFWBSignature() {
@private
}

@end

@implementation DFWBSignature
- (instancetype) init {
    if (self = [super init]) {
    }
    return self;
}
- (uint16_t) hashForWord:(NSString *)word {
    word = [word uppercaseString];
    return hashForWord(word.UTF8String);
}
@end

boolean_t maskForSymbol(char symbol,uint16_t* mask) {
    boolean_t result = false;
    uint16_t bucket = 0x00;
    if (bucketForSymbol(symbol, &bucket)) {
        *mask = _masks[bucket];
        result = true;
    }
    return result;
}
boolean_t bucketForSymbol(char symbol,uint16_t* bucket) {
    for (uint16_t bucketIndex = 0; bucketIndex < 0x0F; bucketIndex ++) {
        for (uint16_t symbolIndex = 0; symbolIndex < 4; symbolIndex ++) {
            if (symbol == _buckets[bucketIndex][symbolIndex]) {
                *bucket = bucketIndex;
                return true;;
            }
        }
    }
    return false;
}
uint16_t hashForWord(const char* symbols) {
    uint16_t result = 0x00;
    if (symbols) {
        uint16_t length = strlen(symbols);
        for (int index = 0; index < length; index ++) {
            char symbol = symbols[index];
            uint16_t mask = 0x0;
            if (maskForSymbol(symbol,&mask)) {
                result |= mask;
            }
        }
    }
    return result;
}
