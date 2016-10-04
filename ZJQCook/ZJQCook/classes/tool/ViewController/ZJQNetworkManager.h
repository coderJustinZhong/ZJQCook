//
//  ZJQNetworkManager.h
//  ZJQCook
//
//  Created by abc on 16/10/4.
//  Copyright © 2016年 ZJQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZJQNetworkManager : NSObject
+ (instancetype)shareNetworkTool;
- (id)GET:(NSString *)url parameters:(NSDictionary *)parameters completionHandler:(void(^)(id responseObj, NSError *error))completionHandler;
- (id)POST:(NSString *)url parameters:(NSDictionary *)parameters completionHandler:(void(^)(id responseObj, NSError *error))completionHandler;
@end
