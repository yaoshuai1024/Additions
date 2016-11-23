//
//  UIButton+YS.h
//  tst
//
//  Created by yaoshuai on 16/8/4.
//  Copyright © 2016年 ys. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (YS)

/**
 *  根据文字、字号、正常状态及高亮状态的颜色创建按钮
 *
 *  @param title         文字
 *  @param fontSize      字号
 *  @param normalColor   正常状态颜色
 *  @param selectedColor 高亮状态颜色
 *
 *  @return 返回创建的按钮
 */
+ (instancetype)ys_buttonWithTitle:(NSString *)title andFontSize:(CGFloat)fontSize andNormalColor:(UIColor *)normalColor andSelectedColor:(UIColor *)selectedColor;

/**
 示例，正常：白底红边红字，高亮：红底白字

 @param title 文字
 @param fontSize 字号
 @param size 尺寸
 @param borderWidth 边框宽度
 @param borderColor 边框颜色
 @param cornerRadius 边角弧度
 @param bgColor 正常状态背景色
 @param titleColor 正常状态文字颜色
 @param hlBGColor 高亮状态背景色
 @param hlTitleColor 高亮状态文字颜色
 @return 返回创建的按钮
 */
+ (instancetype)ys_buttonWithTitle:(NSString *)title andFontSize:(CGFloat)fontSize andSize:(CGSize)size andBorderWith:(NSInteger)borderWidth andBorderColor:(UIColor *)borderColor andCornerRadius:(NSInteger)cornerRadius andBGColor:(UIColor *)bgColor andTitleColor:(UIColor *)titleColor andHLBGColor:(UIColor *)hlBGColor andHLTitleColor:(UIColor *)hlTitleColor;

@end
