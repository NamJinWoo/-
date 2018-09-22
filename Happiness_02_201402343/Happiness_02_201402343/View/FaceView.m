//
//  FaceView.m
//  Happiness_02_201402343
//
//  Created by Jinwoo on 12/09/2018.
//  Copyright © 2018 201402343. All rights reserved.
//

#import "FaceView.h"

@interface FaceView()

@property (nonatomic,readwrite) CGFloat faceScale;
@property (nonatomic,readonly) CGFloat smileness;

-(void) drawCircleAtCenterPoint:(CGPoint) centerPoint
                     withRadius:(CGFloat) radius
                      inContext:(CGContextRef) context;
-(void) drawFaceAtCenterPoint:(CGPoint) centerPoint
                   withRadius:(CGFloat) radius
                    inContext:(CGContextRef) context;
-(void) drawEyesBasedOnFaceCenterPoint: (CGPoint) faceCenterPoint
                        withFaceRadius: (CGFloat) faceRadius
                             inContext: (CGContextRef) context;
-(void) drawNoseBasedOnFaceCenterPoint: (CGPoint) faceCenterPoint
                        withFaceRadius: (CGFloat) faceRadius
                             inContext: (CGContextRef) context;
//Private Method& Member 선언
@end

@implementation FaceView

#define MIN_FACE_SCALE 0.05
#define MAX_FACE_SCALE 1.5
#define DEFAULT_FACE_SCALE 0.9
//얼굴을 그리기 위한 고정 상수 정의

-(void) reset {
    self.faceScale = DEFAULT_FACE_SCALE;
    //초기화 시에 defalut값으로 설정한다.
}

-(void) setFaceScale:(CGFloat) newScale{
    if(newScale < MIN_FACE_SCALE){
        _faceScale = MIN_FACE_SCALE;
    } //최소값보다 작으면 최소값으로 설정
    else if(newScale > MAX_FACE_SCALE){
        _faceScale = MAX_FACE_SCALE;
    } //최대값보다 크면 최대값으로 설정
    else{
        _faceScale = newScale;
    } //그 중간에 있으면 그냥 설정함.
}

- (IBAction) pinchGestureRecognized:(UIPinchGestureRecognizer *)sender{
    if((sender.state == UIGestureRecognizerStateChanged) || (sender.state == UIGestureRecognizerStateEnded)){
        self.faceScale *= sender.scale;
        sender.scale = 1.0;
        [self setNeedsDisplay];
    }
}

#define MAX_SMILENESS +1.0
#define MIN_SMILENESS -1.0
-(CGFloat) smileness {
    CGFloat _smileness = [self.delegate smilenessForFaceView:self];
    if(_smileness < MIN_SMILENESS){
        _smileness = MIN_SMILENESS;
    }
    else if(_smileness > MAX_SMILENESS){
        _smileness = MAX_SMILENESS;
    }
    return _smileness;
} //웃음의 상태를 조절하기 위한 smileness의 Getter 함수

#define CLOCKWISE 1;
-(void) drawCircleAtCenterPoint:(CGPoint)centerPoint
                     withRadius:(CGFloat)radius
                      inContext:(CGContextRef)context{
    CGFloat startAngle = 0.0;
    CGFloat endAngle = 2.0*M_PI;
    int drawingDirection = CLOCKWISE;
    UIGraphicsPushContext(context);
    {
        CGContextBeginPath(context);
        {
            CGContextAddArc(context, centerPoint.x, centerPoint.y, radius, startAngle, endAngle, drawingDirection);
            CGContextFillPath(context);
        }
        CGContextStrokePath(context);
    }
    UIGraphicsPopContext();
} //원을 그리기 위해 눈,코,입에서 호출되는 함수 매개변수로 전달된 값을 통해 화면에 원을 그린다.

-(void) drawFaceAtCenterPoint:(CGPoint)centerPoint
                   withRadius:(CGFloat)radius
                    inContext:(CGContextRef)context{
    [[UIColor darkGrayColor] setFill];
    [self drawCircleAtCenterPoint:centerPoint
                       withRadius:radius
                        inContext:context];
} //얼굴을 그리기 위한 함수.

#define EYE_HorizontalOffSetRatio 0.35
#define EYE_VerticalOffSetRatio 0.30
#define Eye_RadiusRatio 0.15
//눈을 그리기 위한 상수 값 정의
-(void) drawEyesBasedOnFaceCenterPoint:(CGPoint)faceCenterPoint
                        withFaceRadius:(CGFloat)faceRadius
                             inContext:(CGContextRef)context{
    CGPoint eyePoint;
    CGFloat eyeHorizontalOffset = faceRadius * EYE_HorizontalOffSetRatio;
    CGFloat eyeVerticalOffset = faceRadius * EYE_VerticalOffSetRatio;
    CGFloat eyeRadius = faceRadius * Eye_RadiusRatio;
    eyePoint.x = faceCenterPoint.x - eyeHorizontalOffset;
    eyePoint.y = faceCenterPoint.y - eyeVerticalOffset;

    [[UIColor cyanColor] setFill];
    [self drawCircleAtCenterPoint:eyePoint withRadius:eyeRadius inContext:context];
    eyePoint.x = faceCenterPoint.x + eyeHorizontalOffset;
    [self drawCircleAtCenterPoint:eyePoint withRadius:eyeRadius inContext:context];
    
} // 눈을 그리기 위한 함수 정의

#define MOUTH_HorizontalOffsetRatio 0.45
#define MOUTH_VerticalOffsetRatio 0.5
#define MOUTH_RadiusRatio 0.3 // 얼굴 크기에 대한 비례

//입꼬리 조절하는 함수.
-(void) drawMouthBasedOnFaceCenterPoint: (CGPoint) faceCenterPoint
                        withFaceRadius: (CGFloat) faceRadius
                             inContext: (CGContextRef) context
{
    CGPoint mouthLeftPoint;
    CGFloat mouthHorizontalOffset = faceRadius * MOUTH_HorizontalOffsetRatio;
    CGFloat mouthVerticalOffset = faceRadius * MOUTH_VerticalOffsetRatio;
    mouthLeftPoint.x = faceCenterPoint.x - mouthHorizontalOffset;
    mouthLeftPoint.y = faceCenterPoint.y + mouthVerticalOffset;
    CGPoint mouthRightPoint;
    mouthRightPoint.x = faceCenterPoint.x + mouthHorizontalOffset;
    mouthRightPoint.y = faceCenterPoint.y + mouthVerticalOffset;
    
    CGPoint mouthLeftControlPoint = mouthLeftPoint;
    mouthLeftControlPoint.x += mouthHorizontalOffset * (2.0/3.0);
    CGPoint mouthRightControlPoint = mouthRightPoint;
    mouthRightControlPoint.x -= mouthHorizontalOffset * (2.0/3.0);
    
    CGFloat smileOffset = (faceRadius * MOUTH_RadiusRatio) * self.smileness;
    mouthLeftControlPoint.y += smileOffset;
    mouthRightControlPoint.y += smileOffset;
    
    CGContextSetLineWidth(context, 0.5);
    [[UIColor greenColor] setStroke];
    [[UIColor greenColor] setFill];
    
    UIGraphicsPushContext(context);
    {
        CGContextBeginPath(context);
        CGContextMoveToPoint(context, mouthLeftPoint.x, mouthLeftPoint.y);
        if(fabs(smileOffset) < 1){
            CGContextAddLineToPoint(context, mouthRightPoint.x, mouthRightPoint.y);
            CGContextStrokePath(context);
        }
        else{
            CGContextAddCurveToPoint(context, mouthLeftControlPoint.x, mouthLeftControlPoint.y, mouthRightControlPoint.x, mouthRightControlPoint.y, mouthRightPoint.x, mouthRightPoint.y);
            CGContextMoveToPoint(context, mouthRightPoint.x, mouthRightPoint.y);
            CGContextAddCurveToPoint(context, mouthRightControlPoint.x, mouthRightControlPoint.y-smileOffset/2, mouthLeftControlPoint.x, mouthLeftControlPoint.y-smileOffset/2, mouthLeftPoint.x, mouthLeftPoint.y);
            CGContextFillPath(context);
        }
    }
    UIGraphicsPopContext();
}

#define NOSE_HorizontalOffsetRatio 0.0
#define NOSE_VerticalOffsetRatio 0.1
#define NOSE_RadiusRatio 0.09

-(void) drawNoseBasedOnFaceCenterPoint:(CGPoint)faceCenterPoint
                        withFaceRadius:(CGFloat)faceRadius
                             inContext:(CGContextRef)context{
    CGPoint noseCenterPoint = faceCenterPoint;
    noseCenterPoint.y = faceCenterPoint.y + faceRadius * NOSE_VerticalOffsetRatio;
    [[UIColor orangeColor]setFill];
    [self drawCircleAtCenterPoint:noseCenterPoint
                       withRadius:faceRadius*NOSE_RadiusRatio
                        inContext:context];
}

-(void) drawRect:(CGRect)dirtyRect {
    //얼굴 중심 위치를 찾는다.
    CGPoint faceCenterPoint;
    faceCenterPoint.x = self.bounds.origin.x +self.bounds.size.width/2;
    faceCenterPoint.y = self.bounds.origin.y + self.bounds.size.height/2;
    
    //얼굴의 반경을 정한다 (얼굴은 정원이다)
    //FaceView의 width 와 height 중 짧은 쪽을 얼굴 최대 직경으로 한다.
    CGFloat faceRadius = self.bounds.size.width /2 ;
    if(self.bounds.size.width > self.bounds.size.height){
        faceRadius = self.bounds.size.height /2 ;
    }
    faceRadius *= self.faceScale; //얼굴 scale 에 맞추어 얼굴 반경을
    
    //드로잉 컨택스를 얻는다
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [self drawFaceAtCenterPoint:faceCenterPoint withRadius:faceRadius inContext:context];
    [self drawEyesBasedOnFaceCenterPoint:faceCenterPoint withFaceRadius:faceRadius inContext:context];
    [self drawMouthBasedOnFaceCenterPoint:faceCenterPoint withFaceRadius:faceRadius inContext:context];
    [self drawNoseBasedOnFaceCenterPoint:faceCenterPoint withFaceRadius:faceRadius inContext:context];

}

@end
