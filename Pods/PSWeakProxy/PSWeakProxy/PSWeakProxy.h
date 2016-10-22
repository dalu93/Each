//
//  PSWeakProxy.h
//  PSWeakProxy
//
//  Created by Pan on 16/5/5.
//  Copyright © 2016年 Sheng Pan. All rights reserved.
//

#import <Foundation/Foundation.h>

/** 本类用于解决某些系统类造成的循环引用问题，比如说NSTimer。
 
 使用示例:
     PSWeakProxy *weakSelf = [PSWeakProxy weakProxyWithObject:self];
     [NSTimer scheduledTimerWithTimeInterval:1.0
                                      target:weakSelf
                                    selector:@selector(sel)
                                    userInfo:nil
                                    repeats:YES];
 */
@interface PSWeakProxy : NSObject

/**
 *  创建并返回一个WeakProxy，并弱引用被传入的对象
 *  @param object 需要被弱引用的对象
 *  @return 一个弱引用了指定对象的WeakProxy。
 */
+ (instancetype)weakProxyWithObject:(id)object;

/**
 *  初始化一个WeakProxy，并弱引用被传入的对象
 *  @param object 需要被弱引用的对象
 *  @return 一个弱引用了指定对象的WeakProxy。
 */
- (instancetype)initWithObject:(id)object NS_DESIGNATED_INITIALIZER;

@end
