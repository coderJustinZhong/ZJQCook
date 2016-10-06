//
//  ZJQHeaderViewCell.m
//  ZJQCook
//
//  Created by abc on 16/10/3.
//  Copyright © 2016年 ZJQ. All rights reserved.
//

#import "ZJQHeaderViewCell.h"
#import "ZJQVerticalBtn.h"
@interface ZJQHeaderViewCell()
/**************头部自定义导航栏上的内容**************/
@property (weak, nonatomic) IBOutlet UIView *firstView;
@property (weak, nonatomic) IBOutlet UIView *secondView;
@property (weak, nonatomic) IBOutlet UIButton *thirdView;
@property (weak, nonatomic) IBOutlet UIButton *forthView;

@end
@implementation ZJQHeaderViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setUpBasic];
    [self setUpChildView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
#pragma mark - privict
- (void)setUpBasic
{
    self.frame = CGRectMake(0, 0, ZJQKeyWindow.frame.size.width, 400);
        
}
- (void)setUpChildView
{
    
    CGFloat x = 0;
    CGFloat width = ZJQKeyWindow.width / 4;
    for (int i =0; i<4; i++) {
        x = i*width;
        ZJQVerticalBtn * btn = [[ZJQVerticalBtn alloc]initWithFrame:CGRectMake(x, 0, width, self.secondView.height)];
        [btn setImage:[UIImage imageNamed:@"无信号"] forState:UIControlStateNormal];
        [btn setTitle:@"家乡馆" forState:UIControlStateNormal];
        [self.secondView addSubview:btn];
    }
}
- (void)setHeaderAdModel:(id)headerAdModel
{
    
}
@end
