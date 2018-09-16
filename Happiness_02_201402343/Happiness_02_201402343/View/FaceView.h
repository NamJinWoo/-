//
//  FaceView.h
//  Happiness_02_201402343
//
//  Created by Jinwoo on 12/09/2018.
//  Copyright © 2018 201402343. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FaceView;

@protocol FaceViewDelegate //FaceViewProtocol 정의
//HappinessViewController에서 받아온값을 통해 FaceView로 보여줘야하기때문에
//이러한 프로토콜을 설정한다.

-(CGFloat) smilenessForFaceView:(FaceView *) requestor;

@end

@interface FaceView : UIView //Public Method & Member 선언

-(void) reset;
@property (assign) id<FaceViewDelegate> delegate;

-(IBAction) pinchGestureRecognized:(UIPinchGestureRecognizer *)sender;
//Pinch gesture 를 처리한다.

@end
