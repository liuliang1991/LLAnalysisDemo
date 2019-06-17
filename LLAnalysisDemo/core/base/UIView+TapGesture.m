//
//  UIView+TapGesture.m
//  ProjectDemo
//
//  Created by liuliang on 2019/6/13.
//  Copyright © 2019 liu. All rights reserved.
//

#import "UIView+TapGesture.h"

@implementation UIView (TapGesture)

- (void)addTarget:(id)target action:(SEL)action
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:target
                                                                         action:action];
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:tap];
}

@end
