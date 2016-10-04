//
//  ZJQVerticalBtn.m
//  ZJQCook
//
//  Created by abc on 16/10/3.
//  Copyright © 2016年 ZJQ. All rights reserved.
//

#import "ZJQVerticalBtn.h"

@implementation ZJQVerticalBtn
- (void)awakeFromNib
{
    
    [self setUp];
}

- (void)setUp
{
    //设置文字居中
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.y = self.height* 0.1;
    self.imageView.height = self.height * 0.6;
    self.imageView.width = self.imageView.height;
    self.imageView.x = (self.width - self.imageView.width)/2;
    self.titleLabel.x = 0;
    self.titleLabel.width = self.width;
    self.titleLabel.y = CGRectGetMaxY(self.imageView.frame)+self.height*0.05;
    self.titleLabel.height = self.height* 0.2;
}

@end
