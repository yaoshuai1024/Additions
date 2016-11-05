//
//  NSObject+YSRuntime.m
//  工具包-OC
//
//  Created by yaoshuai on 2016/10/21.
//  Copyright © 2016年 ys. All rights reserved.
//

#import "NSObject+YSRuntime.h"
#import <objc/runtime.h>

@implementation NSObject (YSRuntime)

#pragma mark - 属性数组
const char *propertiesKey = "ys.propertiesList";
+ (NSArray *)ys_propertiesList {
    
    // 获取关联对象
    NSArray *result = objc_getAssociatedObject(self, propertiesKey);
    
    if (result != nil) {
        return result;
    }
    
    unsigned int count = 0;
    objc_property_t *list = class_copyPropertyList([self class], &count);
    
    NSMutableArray *arrayM = [NSMutableArray array];
    
    for (unsigned int i = 0; i < count; i++) {
        
        objc_property_t pty = list[i];
        
        const char *cName = property_getName(pty);
        NSString *name = [NSString stringWithUTF8String:cName];
        
        [arrayM addObject:name];
    }
    
    free(list);
    
    // 设置关联对象
    objc_setAssociatedObject(self, propertiesKey, arrayM, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    return objc_getAssociatedObject(self, propertiesKey);
}

#pragma mark - 私有方法，专门针对字典转模型中的自定义属性，{@"name":@"Dog"},name是属性名，Dog是自定义的模型类，属性名-属性类型
const char *propertiesTypeKey = "ys.propertiesTypeKey";
+ (NSArray<NSDictionary *> *)ys_propertiesAndTypeList {
    
    // 获取关联对象
    NSArray *result = objc_getAssociatedObject(self, propertiesTypeKey);
    
    if (result != nil) {
        return result;
    }
    
    unsigned int count = 0;
    objc_property_t *list = class_copyPropertyList([self class], &count);
    
    NSMutableArray<NSDictionary *> *arrayM = [NSMutableArray<NSDictionary *> array];
    
    for (unsigned int i = 0; i < count; i++) {
        
        objc_property_t pty = list[i];
        
        const char *cType = property_getAttributes(pty);
        NSString *typeStr = [NSString stringWithUTF8String:cType];
        
        if([typeStr containsString:@"\",&"]){
            NSRange typeRange = [typeStr rangeOfString:@"\",&"];
            NSString *type = [typeStr substringWithRange:NSMakeRange(3, typeRange.location - 3)];
            
            const char *cName = property_getName(pty);
            NSString *name = [NSString stringWithUTF8String:cName];
            
            NSDictionary *dict = @{name:type};
            
            [arrayM addObject:dict];
        }
    }
    
    free(list);
    
    // 设置关联对象
    objc_setAssociatedObject(self, propertiesTypeKey, arrayM, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    return objc_getAssociatedObject(self, propertiesTypeKey);
}


#pragma mark - 成员变量数组
const char *ivarsKey = "ys.ivarsList";
+ (NSArray *)ys_ivarsList {
    
    // 获取关联对象
    NSArray *result = objc_getAssociatedObject(self, ivarsKey);
    
    if (result != nil) {
        return result;
    }
    
    unsigned int count = 0;
    Ivar *list = class_copyIvarList([self class], &count);
    
    NSMutableArray *arrayM = [NSMutableArray array];
    
    for (unsigned int i = 0; i < count; i++) {
        
        Ivar ivar = list[i];
        
        const char *cName = ivar_getName(ivar);
        NSString *name = [NSString stringWithUTF8String:cName];
        
        [arrayM addObject:name];
    }
    
    free(list);
    
    // 设置关联对象
    objc_setAssociatedObject(self, ivarsKey, arrayM, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    return objc_getAssociatedObject(self, ivarsKey);
}

#pragma mark - 方法数组
+ (NSArray *)ys_methodList {
    
    unsigned int count = 0;
    Method *list = class_copyMethodList([self class], &count);
    
    NSMutableArray *arrayM = [NSMutableArray array];
    
    for (unsigned int i = 0; i < count; i++) {
        
        Method method = list[i];
        
        SEL selector = method_getName(method);
        NSString *name = NSStringFromSelector(selector);
        
        [arrayM addObject:name];
    }
    
    free(list);
    
    return arrayM.copy;
}

#pragma mark - 协议数组
+ (NSArray *)ys_protocolList {
    
    unsigned int count = 0;
    __unsafe_unretained Protocol **list = class_copyProtocolList([self class], &count);
    
    NSMutableArray *arrayM = [NSMutableArray array];
    
    for (unsigned int i = 0; i < count; i++) {
        
        Protocol *protocol = list[i];
        
        const char *cName = protocol_getName(protocol);
        NSString *name = [NSString stringWithUTF8String:cName];
        
        [arrayM addObject:name];
    }
    
    free(list);
    
    return arrayM.copy;
}

#pragma mark - 字典 -> 当前类的对象
+ (instancetype)ys_objectWithDictionary:(NSDictionary *)dictionary{
    
    // 当前类的属性数组
    NSArray *list = [self ys_propertiesList];
    
    NSArray<NSDictionary *> *propertyTypeList = [self ys_propertiesAndTypeList];
    
    id obj = [self new];
    
    for (NSString *key in dictionary) {
        
        if([list containsObject:key]){
            
            if ([dictionary[key] isKindOfClass:[NSDictionary class]]){ // 属性值为字典
                
                for(NSDictionary *dict in propertyTypeList){
                    
                    if([key isEqualToString: [NSString stringWithFormat:@"%@",dict.allKeys.firstObject]]){
                        
                        NSString *classTypeStr = dict[key];
                        Class class = NSClassFromString(classTypeStr);
                        
                        id objChild = [class ys_objectWithDictionary:dictionary[key]];
                        
                        [obj setValue:objChild forKey:key];
                    }
                }
                
            }
            else if([dictionary[key] isKindOfClass:[NSArray<NSDictionary *> class]]){ // 属性值为字典数组
                
            }
            else{
                [obj setValue:dictionary[key] forKey:key];
            }
        }
    }
    
    return obj;
}

#pragma mark - 字典数组 -> 当前类的对象数组
+ (NSArray *)ys_objectsWithDictionaryArray:(NSArray<NSDictionary *> *)dictArray {
    
    if (dictArray.count == 0) {
        return nil;
    }
    
    // 当前类的属性数组
    NSArray *list = [self ys_propertiesList];
    
    NSArray<NSDictionary *> *propertyTypeList = [self ys_propertiesAndTypeList];
    
    NSMutableArray *arrayM = [NSMutableArray array];
    for (NSDictionary *dictionary in dictArray) {
        
        id obj = [self new];
        
        for (NSString *key in dictionary) {
            
            if([list containsObject:key]){
                
                if ([dictionary[key] isKindOfClass:[NSDictionary class]]){ // 属性值为字典
                    
                    for(NSDictionary *dict in propertyTypeList){
                        
                        if([key isEqualToString: [NSString stringWithFormat:@"%@",dict.allKeys.firstObject]]){
                            
                            NSString *classTypeStr = dict[key];
                            Class class = NSClassFromString(classTypeStr);
                            
                            id objChild = [class ys_objectWithDictionary:dictionary[key]];
                            
                            [obj setValue:objChild forKey:key];
                        }
                    }
                    
                }
                else if([dictionary[key] isKindOfClass:[NSArray<NSDictionary *> class]]){ // 属性值为字典数组
                    
                }
                else{
                    [obj setValue:dictionary[key] forKey:key];
                }
            }
        }
        
        [arrayM addObject:obj];
    }
    
    return arrayM.copy;
}

@end
