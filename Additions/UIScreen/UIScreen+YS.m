//
//  UIScreen+YS.m
//  tst
//
//  Created by yaoshuai on 16/8/4.
//  Copyright © 2016年 ys. All rights reserved.
//

#import "UIScreen+YS.h"

@implementation UIScreen (YS)

+ (CGFloat)width {
    return [self mainScreen].bounds.size.width;
}

+ (CGFloat)height {
    return [self mainScreen].bounds.size.height;
}

+ (CGFloat)scale {
    return [self mainScreen].scale;
}

@end
