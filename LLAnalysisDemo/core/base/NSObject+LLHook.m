//
//  NSObject+LLHook.m
//  ProjectDemo
//
//  Created by liuliang on 2019/6/13.
//  Copyright © 2019 liu. All rights reserved.
//

#import "NSObject+LLHook.h"
#import <objc/runtime.h>
@implementation NSObject (LLHook)


+ (BOOL)swizzleInstanceMethod:(SEL)originalSel with:(SEL)newSel {
    Method originalMethod = class_getInstanceMethod(self, originalSel);
    Method newMethod = class_getInstanceMethod(self, newSel);
    if (!originalMethod || !newMethod) return NO;
    
    class_addMethod(self,
                    originalSel,
                    class_getMethodImplementation(self, originalSel),
                    method_getTypeEncoding(originalMethod));
    class_addMethod(self,
                    newSel,
                    class_getMethodImplementation(self, newSel),
                    method_getTypeEncoding(newMethod));
    
    method_exchangeImplementations(class_getInstanceMethod(self, originalSel),
                                   class_getInstanceMethod(self, newSel));
    return YES;
}

+ (BOOL)swizzleClassMethod:(SEL)originalSel with:(SEL)newSel {
    Class class = object_getClass(self);
    Method originalMethod = class_getInstanceMethod(class, originalSel);
    Method newMethod = class_getInstanceMethod(class, newSel);
    if (!originalMethod || !newMethod) return NO;
    method_exchangeImplementations(originalMethod, newMethod);
    return YES;
}

+ (BOOL)class:(Class)class swizzleInstanceMethod:(SEL)originalSel with:(SEL)newSel {
    
    return [class swizzleInstanceMethod:originalSel with:newSel];
}

+ (BOOL)class:(Class)class swizzleClassMethod:(SEL)originalSel with:(SEL)newSel {
    
    return [class swizzleClassMethod:originalSel with:newSel];
}


+ (void)hook_methodWithOriginalClass:(Class)originalClass
                         originalSel:(SEL)originalSel
                       replacedClass:(Class)replacedClass
                         replacedSel:(SEL)replacedSel
                              addSel:(SEL)addSel{
    Method originalMethod = class_getInstanceMethod(originalClass, originalSel);
    Method replacedMethod = class_getInstanceMethod(replacedClass, replacedSel);
    if (!originalMethod) {
        Method addMethod = class_getInstanceMethod(replacedClass, addSel);
        BOOL addNoneMethod = class_addMethod(originalClass, originalSel, method_getImplementation(addMethod), method_getTypeEncoding(addMethod));
        if (addNoneMethod) {
            NSLog(@"******** 没有实现 (%@) 方法，手动添加成功！！",NSStringFromSelector(originalSel));
        }
        originalMethod = class_getInstanceMethod(originalClass, originalSel);
    }
    BOOL addMethod = class_addMethod(originalClass, replacedSel, method_getImplementation(replacedMethod), method_getTypeEncoding(replacedMethod));
    if (addMethod) {
        Method newMethod = class_getInstanceMethod(originalClass, replacedSel);
        method_exchangeImplementations(originalMethod, newMethod);
    }else{
        NSLog(@"******** 已替换过，避免多次替换 --> (%@),<%@>",NSStringFromClass(originalClass),NSStringFromSelector(originalSel));
    }
}


@end
