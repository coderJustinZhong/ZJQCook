//
//  ZJQMainViewCell.m
//  ZJQCook
//
//  Created by abc on 16/10/6.
//  Copyright © 2016年 ZJQ. All rights reserved.
//

#import "ZJQMainViewCell.h"
#import "ZJQMainViewModel.h"
#import <UIImageView+WebCache.h>
#import "ZJQAdView.h"
@interface ZJQMainViewCell()
/**大图片*/
@property (weak, nonatomic) IBOutlet UIView *dishView;
/**头像*/
@property (weak, nonatomic) IBOutlet UIImageView *icon;
/**是否认证*/
@property (weak, nonatomic) IBOutlet UIImageView *vipIcon;
/**店名*/
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
/**地址*/
@property (weak, nonatomic) IBOutlet UILabel *addressLab;
/**商户细节*/
@property (weak, nonatomic) IBOutlet UILabel *detailLab;
@property (weak, nonatomic) IBOutlet UILabel *detailLab2;
@property(strong,nonatomic)ZJQAdView * adView;

@end
@implementation ZJQMainViewCell

- (ZJQAdView *)adView
{
    if (!_adView) {
        _adView = [[ZJQAdView alloc]init];
        [self.dishView addSubview:_adView];
    }
    return _adView;
}


- (void)setMainViewModel:(ZJQMainViewModel *)MainViewModel
{
    
        _MainViewModel = MainViewModel;
        [self.icon setImageWithURL:[NSURL URLWithString:_MainViewModel.cook_image_url] placeholder:[UIImage imageNamed:@"无信号"] ];
        self.icon.layer.cornerRadius = self.icon.height /2;
        self.icon.layer.masksToBounds = YES;
        if (_MainViewModel.auth_msg) {
            self.vipIcon.hidden = NO;
        }
        else self.vipIcon.hidden = YES;
        
        self.nameLab.text = _MainViewModel.kitchen_name;
        self.addressLab.text = [NSString stringWithFormat:@"%@ %@",_MainViewModel.distance,_MainViewModel.kitchen_address];
        self.detailLab.text = [NSString stringWithFormat:@"月售%zd单",_MainViewModel.business_end];
        self.detailLab.textColor = RGBAColor(232, 124, 85, 1);
        self.detailLab2.text = [NSString stringWithFormat:@"·%.1f分·人均¥%zd·%@",_MainViewModel.star,_MainViewModel.avg_price,_MainViewModel.native_place];
        NSMutableArray * array = [NSMutableArray array];
        for (int i=0; i<_MainViewModel.recommend_dishes_detail.count; i++) {
            UIImageView * image = [[UIImageView alloc]init];
            [image setImageWithURL:[NSURL URLWithString:_MainViewModel.recommend_dishes_detail[i].dish_image_url] placeholder:[UIImage imageNamed:@"无信号"]];
            [array addObject:image];
            
        }

        [self.dishView updateConstraintsIfNeeded];
    
    
    
        [self.adView setWithAdCount:_MainViewModel.recommend_dishes_detail.count ImageViews:array Frame:CGRectMake(0, 0, ZJQKeyWindow.width-20, (ZJQKeyWindow.width-20)* (float)4/7 )];
        
}
@end
