//
//  DFWBTools.h
//  WordBase
//
//  Created by Dmitry Feld on 8/5/16.
//  Copyright © 2016 Dmitry Feld. All rights reserved.
//

#ifndef DFWBTools_h
#define DFWBTools_h
void DFAtomicIncreaseInt(volatile int* value);
void DFAtomicDecreaseInt(volatile int* value);
void DFAtomicIncreaseLong(volatile long* value);
void DFAtomicDecreaseLong(volatile long* value);

void DFAtomicIncreaseUInt(volatile unsigned int* value);
void DFAtomicDecreaseUInt(volatile unsigned int* value);
void DFAtomicIncreaseULong(volatile unsigned long* value);
void DFAtomicDecreaseULong(volatile unsigned long* value);

#endif /* DFWBTools_h */
