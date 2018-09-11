//
//  SimpleCalculatorViewController.m
//  SimpleCalculator_01_201402343
//
//  Created by Jinwoo on 03/09/2018.
//  Copyright © 2018 남진우. All rights reserved.
//

#import "SimpleCalculatorViewController.h"
#import "CalculatorBrain.h"

@interface SimpleCalculatorViewController ()
@property (nonatomic) CalculatorBrain* brain;
@property (nonatomic) BOOL userIsInTheMiddleOfTypingANumber;

@end

@implementation SimpleCalculatorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(CalculatorBrain*)brain{ //Override 시켜준 것.
    if(_brain == nil){
        _brain =[[CalculatorBrain alloc] init];
    }
    return _brain;
}

- (IBAction)digitPressed:(UIButton *)sender {
    NSString *digit = sender.titleLabel.text;
    if(self.userIsInTheMiddleOfTypingANumber){
        self.display.text = [self.display.text stringByAppendingString:digit];
    }
    else{
        self.display.text = digit;
        self.userIsInTheMiddleOfTypingANumber = YES;
    }
}

- (IBAction)operatorPressed:(UIButton *)sender {
    if(self.userIsInTheMiddleOfTypingANumber){
        [self.brain setOperand:[[self.display text] doubleValue]];
        self.userIsInTheMiddleOfTypingANumber = NO;
    }
    NSString *operation = [[sender titleLabel]text];
    double result = [self.brain performOperation:operation];
    self.display.text = [NSString stringWithFormat:@"%g",result];
}

@end
