//
//  ZJQNetWorkTool.h
//  ZJQCook
//
//  Created by abc on 16/10/6.
//  Copyright © 2016年 ZJQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZJQheaderAdModel.h"
#import "ZJQheaderActivityModel.h"
#import "ZJQMainViewModel.h"

@interface ZJQNetWorkTool : NSObject
+ (void)getMainViewData:(void(^)(ZJQheaderAdModel * mode1, NSArray<ZJQheaderActivityModel*>*model2, NSArray<ZJQMainViewModel*>*model3,  NSError* error))completionHandler;
+ (void)getMoreMainViewData:(void(^)( NSArray<ZJQheaderActivityModel*>*model,NSInteger totalPage,NSInteger currPage ))completionHandler;
@end
