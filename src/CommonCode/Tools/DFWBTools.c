//
//  DFWBTools.c
//  WordBase
//
//  Created by Dmitry Feld on 8/5/16.
//  Copyright © 2016 Dmitry Feld. All rights reserved.
//

#include "DFWBTools.h"

volatile static unsigned int __semaphore = 0;

void DFAtomicIncreaseInt(volatile int* value) {
    while(__semaphore);
    __semaphore = 1;
    (*value) ++;
    __semaphore = 0;
}
void DFAtomicDecreaseInt(volatile int* value) {
    while(__semaphore);
    __semaphore = 1;
    (*value) --;
    __semaphore = 0;
}
void DFAtomicIncreaseLong(volatile long* value) {
    while(__semaphore);
    __semaphore = 1;
    (*value) ++;
    __semaphore = 0;
}
void DFAtomicDecreaseLong(volatile long* value) {
    while(__semaphore);
    __semaphore = 1;
    (*value) --;
    __semaphore = 0;
}


void DFAtomicIncreaseUInt(volatile unsigned int* value) {
    while(__semaphore);
    __semaphore = 1;
    (*value) ++;
    __semaphore = 0;
}
void DFAtomicDecreaseUInt(volatile unsigned int* value) {
    while(__semaphore);
    __semaphore = 1;
    (*value) --;
    __semaphore = 0;
}
void DFAtomicIncreaseULong(volatile unsigned long* value) {
    while(__semaphore);
    __semaphore = 1;
    (*value) ++;
    __semaphore = 0;
}
void DFAtomicDecreaseULong(volatile unsigned long* value) {
    while(__semaphore);
    __semaphore = 1;
    (*value) --;
    __semaphore = 0;
}