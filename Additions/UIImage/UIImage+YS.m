//
//  UIImage+YS.m
//  MeiTuan
//
//  Created by yaoshuai on 16/8/5.
//  Copyright © 2016年 ys. All rights reserved.
//

#import "UIImage+YS.h"

@implementation UIImage (YS)

- (CGFloat)width
{
    return self.size.width;
}

- (CGFloat)height
{
    return self.size.height;
}

- (void)ys_cornerImageWithSize:(CGSize)size andFillColor:(UIColor *)fillColor andCompletion:(void(^)(UIImage *))completion{
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        UIGraphicsBeginImageContextWithOptions(size, YES, 0);
        CGRect rect = CGRectMake(0, 0, size.width, size.height);
        
        [fillColor setFill];
        UIRectFill(rect);
        
        UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:rect];
        [path addClip];
        
        [self drawInRect:rect];
        
        UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        
        // 回主线程回调
        dispatch_sync(dispatch_get_main_queue(), ^{
            if(completion != nil){
                completion(img);
            }
        });
    });
}

+ (UIImage *)ys_createImageWithColor:(UIColor *)color andSize:(CGSize)size
{
    //图片尺寸
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    //填充画笔
    UIGraphicsBeginImageContext(size);
    //根据所传颜色绘制
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, color.CGColor);
    //显示区域
    CGContextFillRect(context, rect);
    // 得到图片信息
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    //消除画笔
    UIGraphicsEndImageContext();
    
    return image;
}

@end
