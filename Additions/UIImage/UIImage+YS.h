//
//  UIImage+YS.h
//  MeiTuan
//
//  Created by yaoshuai on 16/8/5.
//  Copyright © 2016年 ys. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (YS)

- (CGFloat)width;

- (CGFloat)height;

/**
 把图片切成椭圆(比如头像列表)

 @param size 椭圆的外切矩形
 @param fillColor 填充颜色
 @param completion 完成回调
 */
- (void)ys_cornerImageWithSize:(CGSize)size andFillColor:(UIColor *)fillColor andCompletion:(void(^)(UIImage *))completion;

/**
 根据颜色生成图片

 @param color 颜色
 @param size 生成图片的尺寸
 @return 返回生成的图片
 */
+ (UIImage *)ys_createImageWithColor:(UIColor *)color andSize:(CGSize)size;

@end
