//
//  CalculatorBrain.h
//  SimpleCalculator_01_201402343
//
//  Created by Jinwoo on 03/09/2018.
//  Copyright © 2018 남진우. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject

- (void) setOperand:(double) newOperand;
- (double) performOperation: (NSString*)operation;

@end
