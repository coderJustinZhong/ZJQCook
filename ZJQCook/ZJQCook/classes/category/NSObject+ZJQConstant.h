//
//  NSObject+ZJQConstant.h
//  ZJQCook
//
//  Created by abc on 16/10/3.
//  Copyright © 2016年 ZJQ. All rights reserved.
//

#import <Foundation/Foundation.h>

/**主界面*/
#define ZJQKeyWindow  [UIApplication sharedApplication].keyWindow

/*********** NSUserDefaults keys **************/
/** 保存当前经度 */
#define kCurrentLongitudeKey @"kCurrentLongitudeKey"
/** 保存当前纬度 */
#define kCurrentLatitudeKey @"kCurrentLatitudeKey"

/**头部广告url*/
#define ZJQHeaderViewKey @"http://user.mapi.jiashuangkuaizi.com/UFocus/list"
/**首页-活动信息url*/
#define JZQHomeActivityKey @"http://user.gw.jiashuangkuaizi.com/api/op/list"
//首页-列表内容
#define ZJQHomeListKey @"http://user.mapi.jiashuangkuaizi.com/UKitchen/homePageList"




#define ZJQWeakSelf  __weak typeof(self) weakself = self



