//
//  ZJQheaderActivityModel.h
//  ZJQCook
//
//  Created by abc on 16/10/6.
//  Copyright © 2016年 ZJQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZJQheaderActivityModel : NSObject

/**标题名字*/
@property(copy,nonatomic)NSString * title;
/**图片url*/
@property(copy,nonatomic)NSString * imageUrl;
/**跳转url*/
@property(copy,nonatomic)NSString * jumpUrl;
@end
