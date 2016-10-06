//
//  ZJQheaderAdModel.h
//  ZJQCook
//
//  Created by abc on 16/10/5.
//  Copyright © 2016年 ZJQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZJQheaderAdListModel.h"

@interface ZJQheaderAdDataModel : NSObject
@property(strong,nonatomic)NSArray<ZJQheaderAdListModel*>* list;

@end

@interface ZJQheaderAdModel : NSObject
/**code*/
@property(assign,nonatomic) NSInteger code;
/**存放广告内容字典*/
@property(strong,nonatomic)ZJQheaderAdDataModel * data;
/**获取成功信息*/
@property(copy,nonatomic)NSString * msg;


@end
