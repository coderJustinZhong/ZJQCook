//
//  ZJQNetWorkTool.m
//  ZJQCook
//
//  Created by abc on 16/10/6.
//  Copyright © 2016年 ZJQ. All rights reserved.
//

#import "ZJQNetWorkTool.h"
#import "ZJQNetworkManager.h"
#import <MJExtension.h>
@implementation ZJQNetWorkTool

static NSInteger page=1;
+ (void)getMainViewData:(void (^)(ZJQheaderAdModel* ,NSArray<ZJQheaderActivityModel*>*model2, NSArray<ZJQMainViewModel*>*model3 ,NSError *))completionHandler
{
   __block ZJQheaderAdModel * headerAdModel = nil;
  __block  NSMutableArray * headerActModels = [NSMutableArray array];
    __block NSMutableArray * ZJQMainViewModels = [NSMutableArray array];
   [[ZJQNetworkManager shareManager] POST:ZJQHeaderViewKey parameters:nil completionHandler:^(NSDictionary * responseObj, NSError *error) {
        if (responseObj) {
            headerAdModel = [ZJQheaderAdModel mj_objectWithKeyValues:responseObj];
            
            !completionHandler ? : completionHandler(headerAdModel,nil,nil,nil);
        }
    }];
    [[ZJQNetworkManager shareManager] POST:JZQHomeActivityKey parameters:nil completionHandler:^(id responseObj, NSError *error) {
        if (responseObj) {
            headerActModels = [ZJQheaderActivityModel mj_objectArrayWithKeyValuesArray:responseObj[@"data"][@"list"]];
            
            !completionHandler ? : completionHandler(nil,headerActModels,nil,nil);
        }

    }];
    
    [[ZJQNetworkManager shareManager] POST:ZJQHomeListKey parameters:@{@"page": @(1), @"radius": @5000} completionHandler:^(id responseObj, NSError *error) {
        if (responseObj)
        {
            ZJQMainViewModels = [ZJQMainViewModel mj_objectArrayWithKeyValuesArray:responseObj[@"data"][@"list"]];
            page = 2;
            
        }
        !completionHandler ?: completionHandler(nil,nil,ZJQMainViewModels,nil);
    }];

}

+ (void)getMoreMainViewData:(void(^)( NSArray<ZJQheaderActivityModel*>*model,NSInteger totalPage,NSInteger currPage ))completionHandler
{
    
    __block NSMutableArray * ZJQMainViewModels = [NSMutableArray array];
    __block ZJQMainViewModel * pageModel = nil;
    [[ZJQNetworkManager shareManager] POST:ZJQHomeListKey parameters:@{@"page": @(page), @"radius": @5000} completionHandler:^(id responseObj, NSError *error) {
        if (responseObj)
        {
            [responseObj writeToFile:@"/Users/abc/Desktop/test.plist" atomically:YES ];
            ZJQMainViewModels = [ZJQMainViewModel mj_objectArrayWithKeyValuesArray:responseObj[@"data"][@"list"]];
            pageModel = [ZJQMainViewModel mj_objectWithKeyValues:responseObj[@"data"]];

            page++;
        }
        !completionHandler ?: completionHandler(ZJQMainViewModels,pageModel.totalPage,pageModel.page);
    }];
}
@end
