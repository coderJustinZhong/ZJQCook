//
//  ZJQMainViewModel.m
//  ZJQCook
//
//  Created by abc on 16/10/6.
//  Copyright © 2016年 ZJQ. All rights reserved.
//

#import "ZJQMainViewModel.h"
#import "MJExtension.h"

@implementation ZJQMainViewModel
-(void)setRecommend_dishes_detail:(NSArray<ZJQDishesModel *> *)recommend_dishes_detail
{
    _recommend_dishes_detail = [ZJQDishesModel mj_objectArrayWithKeyValuesArray:recommend_dishes_detail];
}
@end
