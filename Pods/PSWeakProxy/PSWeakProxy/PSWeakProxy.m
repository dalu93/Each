//
//  PSWeakProxy.m
//  PSWeakProxy
//
//  Created by Pan on 16/5/5.
//  Copyright © 2016年 Sheng Pan. All rights reserved.
//

#import "PSWeakProxy.h"

@interface PSWeakProxy ()

@property (nonatomic, weak) id target;

@end


@implementation PSWeakProxy

+ (instancetype)weakProxyWithObject:(id)object;
{
    return [[PSWeakProxy alloc] initWithObject:object];
}

- (instancetype)initWithObject:(id)object;
{
    self = [super init];
    if (self)
    {
        _target = object;
    }
    return self;
}

- (instancetype)init
{
    return [self initWithObject:nil];
}

- (id)forwardingTargetForSelector:(SEL)aSelector
{
    return _target;
}

- (void)forwardInvocation:(NSInvocation *)invocation
{
    void *nullPointer = NULL;
    [invocation setReturnValue:&nullPointer];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector
{
    return [NSObject instanceMethodSignatureForSelector:@selector(init)];
}
@end
