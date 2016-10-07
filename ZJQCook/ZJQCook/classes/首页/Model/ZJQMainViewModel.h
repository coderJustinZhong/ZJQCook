//
//  ZJQMainViewModel.h
//  ZJQCook
//
//  Created by abc on 16/10/6.
//  Copyright © 2016年 ZJQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZJQDishesModel.h"

@interface ZJQMainViewModel : NSObject
/**图标url*/
@property(copy,nonatomic)NSString * cook_image_url;
@property(copy,nonatomic)NSString * auth_msg;


/**店名*/
@property(copy,nonatomic)NSString * kitchen_name;

/**距离*/
@property(copy,nonatomic)NSString * distance;
/**地址*/
@property(copy,nonatomic)NSString * kitchen_address;

/**平均价格*/
@property(assign,nonatomic)NSInteger  avg_price;
/**月售单数*/
@property(assign,nonatomic)NSInteger business_end;
/**哪里人*/
@property(copy,nonatomic)NSString * native_place;
/**评分*/
@property(assign,nonatomic)CGFloat  star;
/**推荐菜细节*/
@property(strong,nonatomic)NSArray <ZJQDishesModel*>* recommend_dishes_detail;


/**辅助****/


/**总页数*/
@property(assign,nonatomic)NSInteger  totalPage;
/**当前页数*/
@property(assign,nonatomic)NSInteger  page;

@end
