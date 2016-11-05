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

@end
