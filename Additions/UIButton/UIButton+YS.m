//
//  UIButton+YS.m
//  tst
//
//  Created by yaoshuai on 16/8/4.
//  Copyright © 2016年 ys. All rights reserved.
//

#import "UIButton+YS.h"

@implementation UIButton (YS)

+ (instancetype)ys_buttonWithTitle:(NSString *)title andFontSize:(CGFloat)fontSize andNormalColor:(UIColor *)normalColor andSelectedColor:(UIColor *)selectedColor {
    
    UIButton *btn = [[self alloc] init];
    
    [btn setTitle:title forState:UIControlStateNormal];
    
    [btn setTitleColor:normalColor forState:UIControlStateNormal];
    [btn setTitleColor:selectedColor forState:UIControlStateSelected];
    
    btn.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    
    [btn sizeToFit];
    
    return btn;
}

+ (instancetype)ys_buttonWithTitle:(NSString *)title andFontSize:(CGFloat)fontSize andSize:(CGSize)size andBorderWith:(NSInteger)borderWidth andBorderColor:(UIColor *)borderColor andCornerRadius:(NSInteger)cornerRadius andBGColor:(UIColor *)bgColor andTitleColor:(UIColor *)titleColor andHLBGColor:(UIColor *)hlBGColor andHLTitleColor:(UIColor *)hlTitleColor{
    
    UIButton *btn = [[self alloc] init];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    btn.frame = CGRectMake(0, 0, size.width, size.height);
    
    // 正常状态：白底红边红字
    btn.layer.borderWidth = borderWidth;
    btn.layer.borderColor = borderColor.CGColor;
    btn.layer.cornerRadius = cornerRadius;
    btn.layer.masksToBounds = YES;
    
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage ys_createImageWithColor:bgColor andSize:size] forState:UIControlStateNormal];
    
    // 高亮(即按下)：红底白字
    [btn setTitleColor:hlTitleColor forState:UIControlStateHighlighted];
    [btn setBackgroundImage:[UIImage ys_createImageWithColor:hlBGColor andSize:size] forState:UIControlStateHighlighted];
    
    return btn;
}

@end
