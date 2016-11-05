//
//  NSObject+YSRuntime.h
//  工具包-OC
//
//  Created by yaoshuai on 2016/10/21.
//  Copyright © 2016年 ys. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (YSRuntime)

/**
 返回当前类的属性数组
 
 @return 属性数组(如:"name","age","address")
 */
+ (NSArray *)ys_propertiesList;

/**
 返回当前类的成员变量数组
 
 @return 成员变量数组
 */
+ (NSArray *)ys_ivarsList;

/**
 返回当前类的对象方法数组
 
 @return 方法数组
 */
+ (NSArray *)ys_methodList;

/**
 返回当前类的协议数组
 
 @return 协议数组
 */
+ (NSArray *)ys_protocolList;

/**
 使用字典创建当前类的对象
 
 @param dictionary 字典
 
 @return 当前类的对象
 */
+ (instancetype)ys_objectWithDictionary:(NSDictionary *)dictionary;

/**
 使用字典数组创建当前类的对象数组
 
 @param dictArray 字典数组
 
 @return 当前类的对象数组
 */
+ (NSArray *)ys_objectsWithDictionaryArray:(NSArray<NSDictionary *> *)dictArray;

@end
