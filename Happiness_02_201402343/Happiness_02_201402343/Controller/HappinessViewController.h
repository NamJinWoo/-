//
//  HappinessViewController.h
//  Happiness_02_201402343
//
//  Created by Jinwoo on 14/09/2018.
//  Copyright © 2018 201402343. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "../View/FaceView.h"


@interface HappinessViewController : UIViewController <FaceViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *happinessLabel;
@property (weak, nonatomic) IBOutlet FaceView *faceView;
@property (weak, nonatomic) IBOutlet UISlider *happinessSlider;
- (IBAction)happinessSliderChanged:(UISlider *)sender;

@end
