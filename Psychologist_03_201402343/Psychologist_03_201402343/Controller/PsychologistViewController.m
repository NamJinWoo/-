//
//  PsychologistViewController.m
//  Psychologist_03_201402343
//
//  Created by Jinwoo on 19/09/2018.
//  Copyright © 2018 201402343. All rights reserved.
//

#import "PsychologistViewController.h"
#import "HappinessViewController.h"

@interface PsychologistViewController ()

@end

@implementation PsychologistViewController


#define HAPPINESS_BAD 10
#define HAPPINESS_SOSO 50
#define HAPPINESS_GOOD 90

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.destinationViewController isKindOfClass:[HappinessViewController class]])
    {
        HappinessViewController* happinessViewContorller = (HappinessViewController*)segue.destinationViewController;
        if([sender isKindOfClass:[UIButton class]]){
            UIButton* button = (UIButton*)sender;
            happinessViewContorller.title = button.titleLabel.text;
            if([segue.identifier isEqualToString:@"segueBad"]){
                happinessViewContorller.happiness = HAPPINESS_BAD;
            }else if([segue.identifier isEqualToString:@"segueSoso"]){
                happinessViewContorller.happiness = HAPPINESS_SOSO;
            }else{
                happinessViewContorller.happiness = HAPPINESS_GOOD;
            }
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"심리 상담";
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

@end
