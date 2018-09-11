//
//  SimpleCalculatorViewController.h
//  SimpleCalculator_01_201402343
//
//  Created by Jinwoo on 03/09/2018.
//  Copyright © 2018 남진우. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SimpleCalculatorViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *display;
- (IBAction)digitPressed:(UIButton *)sender;
- (IBAction)operatorPressed:(UIButton *)sender;

@end
