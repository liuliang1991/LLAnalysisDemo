//
//  NSObject+LLHook.h
//  ProjectDemo
//
//  Created by liuliang on 2019/6/13.
//  Copyright © 2019 liu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (LLHook)

+ (BOOL)swizzleClassMethod:(SEL)originalSel with:(SEL)newSel;

+ (BOOL)swizzleInstanceMethod:(SEL)originalSel with:(SEL)newSel;

+ (BOOL)class:(Class)class swizzleInstanceMethod:(SEL)originalSel with:(SEL)newSel;

+ (BOOL)class:(Class)class swizzleClassMethod:(SEL)originalSel with:(SEL)newSel;

+ (void)hook_methodWithOriginalClass:(Class)originalClass
                         originalSel:(SEL)originalSel
                       replacedClass:(Class)replacedClass
                         replacedSel:(SEL)replacedSel
                              addSel:(SEL)addSel;
@end

NS_ASSUME_NONNULL_END
