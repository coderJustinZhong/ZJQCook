//
//  ZJQHeaderViewCell.h
//  ZJQCook
//
//  Created by abc on 16/10/3.
//  Copyright © 2016年 ZJQ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZJQheaderAdModel;

@interface ZJQHeaderViewCell : UITableViewCell
/**自动轮转广告模型*/
@property(strong,nonatomic)ZJQheaderAdModel * headerAdModel;
@property(strong,nonatomic)NSArray * headerActModels;

@end
