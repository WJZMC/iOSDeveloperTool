//  iOSTool
//
//  Created by jack wei on 2018/7/30.
//  Copyright © 2018年 jack wei. All rights reserved.
#import <Foundation/Foundation.h>

@interface NSObject (Runtime)


//---------------------------【获取一个类中的所有类方法和对象方法】------------------------------//
//
// 获取实例方法(-号开头的方法)
+ (void)ln_getInstanceMethodList;

// 获取类方法(+号开头开头的方法)
+ (void)ln_getClassMethodList;










//--------------------------- 【注解】 ------------------------------//
//

// 元类:类对象的类,所有的类方法都是保存到元类(metaClass),并成方法列表
// 类对象:[Person class],所有的对象方法都是保存到类对象中,并成方法列表
// objc_getClass:获取类对象
// objc_getMetaClass:获取元类,

@end
