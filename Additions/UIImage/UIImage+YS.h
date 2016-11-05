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

- (void)ys_cornerImageWithSize:(CGSize)size andFillColor:(UIColor *)fillColor andCompletion:(void(^)(UIImage *))completion;

@end
