//
//  UIView+ZJQExtention.m
//  ZJQCook
//
//  Created by abc on 16/10/3.
//  Copyright © 2016年 ZJQ. All rights reserved.
//

#import "UIView+ZJQExtention.h"

@implementation UIView (ZJQExtention)
- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setX:(CGFloat)x
{
    CGRect rect = self.frame;
    rect.origin.x = x ;
    self.frame = rect;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setY:(CGFloat)y
{
    CGRect rect = self.frame;
    rect.origin.y = y ;
    self.frame = rect;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height
{
    CGRect rect = self.frame;
    rect.size.height = height ;
    self.frame = rect;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width
{
    CGRect rect = self.frame;
    rect.size.width = width ;
    self.frame = rect;
}

- (CGSize)size
{
   return  self.frame.size;
}

- (void)setSize:(CGSize)size
{
    CGRect rect = self.frame;
    rect.size = size ;
    self.frame = rect;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX ;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (BOOL)isShowOnKeyWindow
{
    //获得keywindow
    UIWindow * keyWindow = ZJQKeyWindow;
    //转换frame为keywindow的frame
    CGRect newFrame = [keyWindow convertRect:self.frame fromView:self.superview];
    CGRect windowBound = keyWindow.bounds;
    BOOL intersects = CGRectIntersectsRect(newFrame, windowBound);
    return intersects && self.alpha>0.1 && self.hidden==NO && self.window==keyWindow;

}
@end
