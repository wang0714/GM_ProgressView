//
//  GMProgressView.h
//  test2
//
//  Created by 汪高明 on 15/12/24.
//  Copyright © 2015年 汪高明. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GMProgressView : UIView
/**
 *  底部线条颜色   默认浅灰色
 */
@property (nonatomic,strong) UIColor *bottomLineColor;

/**
 *  顶部线条颜色   默认橙色
 */
@property (nonatomic,strong) UIColor *topLineColor;

/**
 *  文字颜色   默认浅灰
 */
@property (nonatomic,strong) UIColor *textColor;

/**
 *  进度值的颜色   默认橙色
 */
@property (nonatomic,strong) UIColor *numLColor;

/**
 *  线条宽度  默认6px
 */
@property (nonatomic,assign) CGFloat lineWidth;


/**
 *  进度值 
 */
@property (nonatomic,assign) CGFloat ratioNum;

/**
 *  开启动画
 *
 *  @param time      持续时间
 *  @param animation 是否开启动画
 */
-(void)animationWithDurationTime:(CGFloat)time animation:(BOOL)animation;

/**
 *  视图初始化
 *
 *  @param frame 视图大小
 *  @param lineW 线条宽度
 */
- (instancetype)initWithFrame:(CGRect)frame lineW:(CGFloat)lineW;
@end
