//
//  ZJQheaderAdModel.m
//  ZJQCook
//
//  Created by abc on 16/10/5.
//  Copyright © 2016年 ZJQ. All rights reserved.
//

#import "ZJQheaderAdModel.h"
#import "MJExtension.h"
#import "ZJQheaderAdListModel.h"

@implementation ZJQheaderAdModel


@end
@implementation ZJQheaderAdDataModel
-(void)setList:(NSArray *)list
{
    _list = [ZJQheaderAdListModel mj_objectArrayWithKeyValuesArray:list];
    
}
@end