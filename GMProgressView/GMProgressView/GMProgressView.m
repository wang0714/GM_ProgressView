//
//  GMProgressView.m
//  test2
//
//  Created by 汪高明 on 15/12/24.
//  Copyright © 2015年 汪高明. All rights reserved.
//


#define HexColor(hexValue,b) [UIColor colorWithRed:((float)(((hexValue) & 0xFF0000) >> 16))/255.0 green:((float)(((hexValue) & 0xFF00) >> 8))/255.0 blue:((float)((hexValue) & 0xFF))/255.0 alpha:(b)]

#import "GMProgressView.h"

@interface GMProgressView()

@property (nonatomic,strong) UIView *view1;
@property (nonatomic,strong) CAShapeLayer *line1;

@property (nonatomic,strong) UIView *view2;
@property (nonatomic,strong) CAShapeLayer *line2;

@property (nonatomic,strong) UILabel *numL;

@property (nonatomic,strong) NSTimer *timer;

@property (nonatomic,assign) CGFloat sumSteps;

@property (nonatomic,assign) CGFloat autoRatio;

@property (nonatomic,strong) UILabel *textL;

@property (nonatomic,strong) UILabel *perL;

@end


@implementation GMProgressView

const CGFloat StrokeStart = 0;

const CGFloat StrokeEnd = 1;

- (instancetype)initWithFrame:(CGRect)frame lineW:(CGFloat)lineW
{
    self = [super initWithFrame:frame];
    if (self) {
        self.lineWidth = lineW;
        [self addView:frame];
    }
    return self;
}

-(void)addView:(CGRect)frame
{
    CGFloat Width = frame.size.width;
    
    
    self.view2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, Width)];
    
    [self addSubview:self.view2];
    
    self.view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, Width)];
    
    [self addSubview:self.view1];
    
    _autoRatio = _view1.frame.size.width/68;
    
    CGFloat fontRatio = Width/68;
    
    _perL = [[UILabel alloc] init];
    _perL.text = @"%";
    _perL.font = [UIFont systemFontOfSize:12*fontRatio];
    _perL.textColor = _numLColor?_numLColor:HexColor(0xfc6151, 1);
    CGSize size = [_perL sizeThatFits:CGSizeZero];
    _perL.frame = CGRectMake(43*fontRatio, 25*fontRatio, size.width, size.height);
    [self addSubview:_perL];
    
    _numL = [[UILabel alloc] initWithFrame:CGRectMake(_perL.frame.origin.x-35*fontRatio, 21*fontRatio, 35*fontRatio, 20*fontRatio)];
    _numL.textColor = _numLColor?_numLColor:HexColor(0xfc6151, 1);
    _numL.font = [UIFont systemFontOfSize:20*fontRatio];
    _numL.textAlignment = NSTextAlignmentRight;
    _numL.text = @"0";
    [self addSubview:_numL];
    
    _textL = [[UILabel alloc] initWithFrame:CGRectMake(0, 53*fontRatio, Width, 12*fontRatio)];
    _textL.font = [UIFont systemFontOfSize:12*fontRatio];
    _textL.textColor = _textColor?_textColor:HexColor(0x999999, 1);
    _textL.textAlignment = NSTextAlignmentCenter;
    _textL.text = @"标题";
    [self addSubview:_textL];
    [self drawLine];
}


-(void)setTextStr:(NSString *)TextStr
{
    if (TextStr) {
        _TextStr = TextStr;
        _textL.text = TextStr;
    }
}

-(void)setTextColor:(UIColor *)textColor
{
    if (textColor) {
        _textColor = textColor;
        _numL.textColor = textColor;
        _textL.textColor = textColor;
        _perL.textColor = textColor;
    }
}

-(void)setBottomLineColor:(UIColor *)bottomLineColor
{
    if (bottomLineColor) {
        _bottomLineColor = bottomLineColor;
        _line1.strokeColor = bottomLineColor.CGColor;
    }
}

-(void)setTopLineColor:(UIColor *)topLineColor
{
    if (topLineColor) {
        _topLineColor = topLineColor;
        _line2.strokeColor = topLineColor.CGColor;
    }
}

-(void)setLineWidth:(CGFloat)lineWidth
{
    if (lineWidth) {
        _line1.lineWidth = lineWidth;
        _line2.lineWidth = lineWidth;
    }
}




-(void)drawLine
{
    //// Bezier Drawing
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(15.89*_autoRatio, 58*_autoRatio)];
    [bezierPath addCurveToPoint: CGPointMake(3.49*_autoRatio, 39.67*_autoRatio) controlPoint1: CGPointMake(15.89*_autoRatio, 58*_autoRatio) controlPoint2: CGPointMake(6.59*_autoRatio, 51.89*_autoRatio)];
    [bezierPath addCurveToPoint: CGPointMake(34.5*_autoRatio, 3*_autoRatio) controlPoint1: CGPointMake(0.39*_autoRatio, 27.44*_autoRatio) controlPoint2: CGPointMake(6.59*_autoRatio, 3*_autoRatio)];
    [bezierPath addCurveToPoint: CGPointMake(65.51*_autoRatio, 39.67*_autoRatio) controlPoint1: CGPointMake(62.41*_autoRatio, 3*_autoRatio) controlPoint2: CGPointMake(68.61*_autoRatio, 27.44*_autoRatio)];
    [bezierPath addCurveToPoint: CGPointMake(53.11*_autoRatio, 58*_autoRatio) controlPoint1: CGPointMake(62.41*_autoRatio, 51.89*_autoRatio) controlPoint2: CGPointMake(53.11*_autoRatio, 58*_autoRatio)];
    
    
    _line1=[CAShapeLayer layer];
    _line1.path=bezierPath.CGPath;
    _line1.fillColor=[UIColor clearColor].CGColor;
    _line1.strokeColor=self.bottomLineColor?self.bottomLineColor.CGColor:HexColor(0xdddddd, 1).CGColor;
    _line1.lineCap = @"round";
    _line1.lineWidth = self.lineWidth;
    _line1.strokeStart = StrokeStart;
    _line1.strokeEnd = StrokeEnd;
    [self.view2.layer addSublayer:_line1];
    
    _line2=[CAShapeLayer layer];
    _line2.path=bezierPath.CGPath;
    _line2.fillColor=[UIColor clearColor].CGColor;
    _line2.strokeColor= self.topLineColor?self.topLineColor.CGColor:HexColor(0xfc6e51, 1).CGColor;
    _line2.lineCap = @"round";
    _line2.lineWidth = self.lineWidth?self.lineWidth:6;
    _line2.strokeStart = StrokeStart;
    _line2.strokeEnd = StrokeEnd;
    [self.view1.layer addSublayer:_line2];
}

-(void)animationWithDurationTime:(CGFloat)time animation:(BOOL)animation
{
    if (animation == YES) {
        _sumSteps = 0;
        CABasicAnimation *r1=[CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        r1.beginTime =CACurrentMediaTime() ;
        r1.duration=time;
        r1.removedOnCompletion=NO;
        r1.autoreverses = NO;
        r1.fillMode=kCAFillModeBoth;
        r1.fromValue=@(0);
        r1.toValue=@(_ratioNum/100);
        r1.timingFunction=[CAMediaTimingFunction  functionWithControlPoints:0.07:0.95:0.45:0.97];
        [_line2 addAnimation:r1 forKey:@"r1"];
        
        //start timer
        _timer = [NSTimer scheduledTimerWithTimeInterval:1/_ratioNum
                                                  target:self
                                                selector:@selector(numberAnimation)
                                                userInfo:nil
                                                 repeats:YES];
    }
    
}


-(void)numberAnimation
{
    //Duration 动画持续时长
    _sumSteps += 1;
    if (_sumSteps > _ratioNum) {
        //close timer
        [_timer invalidate];
        _timer = nil;
        return;
    }
    else
        _numL.text = [NSString stringWithFormat:@"%.0f",_sumSteps];
}
@end
