//
//  CalculatorBrain.m
//  SimpleCalculator_01_201402343
//
//  Created by Jinwoo on 03/09/2018.
//  Copyright © 2018 남진우. All rights reserved.
//

#import "CalculatorBrain.h"
@interface CalculatorBrain()
@property (nonatomic)double operand;
@property (nonatomic)double waitingOperand;
@property (nonatomic)NSString * waitingOperation;

-(void)performWaitingOperation;
@end

@implementation CalculatorBrain
-(double)performOperation:(NSString *)operation{
    if([operation isEqual:@"sqrt"]){
        self.operand = sqrt(self.operand);
    }
    else{
        [self performWaitingOperation];
        self.waitingOperation = operation;
        self.waitingOperand = self.operand;
    }
    return self.operand;
}
-(void) performWaitingOperation{
    if([self.waitingOperation isEqual:@"+"]){
        self.operand = self.waitingOperand + self.operand;
    }
    else if([self.waitingOperation isEqual:@"-"]){
        self.operand = self.waitingOperand - self.operand;
    }
    else if([self.waitingOperation isEqual:@"*"]){
        self.operand = self.waitingOperand * self.operand;
    }
    else if([self.waitingOperation isEqual:@"/"]){
        self.operand = self.waitingOperand / self.operand;
    }
}

@end
