//
//  ZJQheaderAdListModel.h
//  ZJQCook
//
//  Created by abc on 16/10/6.
//  Copyright © 2016年 ZJQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZJQheaderAdListModel : NSObject


@property (nonatomic, assign) NSInteger focus_id;
/**跳转页面地址*/
@property (nonatomic, copy) NSString *jump_url;
/**图片地址*/
@property (nonatomic, copy) NSString *image_url;
//description
@property (nonatomic, copy) NSString *desc;

@property (nonatomic, assign) NSInteger position;

@property (nonatomic, assign) NSInteger action;


@end
