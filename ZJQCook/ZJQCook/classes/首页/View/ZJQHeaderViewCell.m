//
//  ZJQHeaderViewCell.m
//  ZJQCook
//
//  Created by abc on 16/10/3.
//  Copyright © 2016年 ZJQ. All rights reserved.
//

#import "ZJQHeaderViewCell.h"
#import "ZJQVerticalBtn.h"
#import "ZJQheaderAdModel.h"
#import <UIImageView+WebCache.h>
#import "ZJQAdView.h"
#import "ZJQheaderActivityModel.h"


@interface ZJQHeaderViewCell()
/**************头部自定义导航栏上的内容**************/
@property (weak, nonatomic) IBOutlet UIView *firstView;
@property (weak, nonatomic) IBOutlet UIView *secondView;
@property (weak, nonatomic) IBOutlet UIButton *thirdView;
@property (weak, nonatomic) IBOutlet UIButton *forthView;
/**头部自动轮播广告*/
@property(strong,nonatomic)ZJQAdView * adView;

@end
@implementation ZJQHeaderViewCell
#pragma mark - getter
-(ZJQAdView *)adView
{
    if(!_adView)
    {
        _adView = [[ZJQAdView alloc]init];
        [self.firstView addSubview:_adView];
    }
    return _adView;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setUpBasic];
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


#pragma mark - public
/**获得数据后执行操作*/
- (void)setHeaderAdModel:(ZJQheaderAdModel*)headerAdModel
{
    if (!_headerAdModel) {
        _headerAdModel = headerAdModel;
        if (headerAdModel.data.list.count>1) {
            NSMutableArray * images = [NSMutableArray array];
            for (int i =0 ; i<headerAdModel.data.list.count; i++) {
                
                UIImageView * imageView = [[UIImageView alloc]init];
                NSURL * url = [NSURL URLWithString:headerAdModel.data.list[i].image_url ];
                [imageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"无信号"]];
                [images addObject:imageView];
            }
            
            [self.adView setWithAdCount:headerAdModel.data.list.count ImageViews:images Frame:self.firstView.frame];
        }
    }

    
}

- (void)setHeaderActModels:(NSArray *)headerActModels
{
    if (!_headerActModels)
    {
        _headerActModels = headerActModels;
        CGFloat x = 0;
        CGFloat width = ZJQKeyWindow.width / ((int)_headerActModels.count - 2);
        int i = 0;
        for (  i=0 ; i< ((int)headerActModels.count - 2 ); i++) {
            x = i*width;
            
            ZJQheaderActivityModel * model = _headerActModels[i];
            ZJQVerticalBtn * btn = [[ZJQVerticalBtn alloc]initWithFrame:CGRectMake(x, 0, width, self.secondView.height)];
            UIImageView * imageView = [[UIImageView alloc]init];

            [imageView sd_setImageWithURL:[NSURL URLWithString:model.imageUrl]  placeholderImage:[UIImage imageNamed:@"无信号"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                
                [btn setImage:imageView.image forState:UIControlStateNormal];
            }];
            
            [btn setTitle:model.title forState:UIControlStateNormal];
            [self.secondView addSubview:btn];
        }
        
        ZJQheaderActivityModel * model = _headerActModels[i];

        [self.thirdView setTitle:model.title forState:UIControlStateNormal];
        
        UIImageView * imageView1 = [[UIImageView alloc]init];
        
        [imageView1 sd_setImageWithURL:[NSURL URLWithString:model.imageUrl]  placeholderImage:[UIImage imageNamed:@"无信号"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
            [self.thirdView setImage:imageView1.image forState:UIControlStateNormal];
        }];
        
         model = _headerActModels[++i];
        
        [self.thirdView setTitle:model.title forState:UIControlStateNormal];
        UIImageView * imageView2 = [[UIImageView alloc]init];
        [imageView2 sd_setImageWithURL:[NSURL URLWithString:model.imageUrl]  placeholderImage:[UIImage imageNamed:@"无信号"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
            [self.forthView setImage:imageView2.image forState:UIControlStateNormal];
        }];


    }
    
}
@end
