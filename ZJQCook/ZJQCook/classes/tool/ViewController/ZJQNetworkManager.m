//
//  ZJQNetworkManager.m
//  ZJQCook
//
//  Created by abc on 16/10/4.
//  Copyright © 2016年 ZJQ. All rights reserved.
//

#import "ZJQNetworkManager.h"
#import <AFNetworking.h>
@interface ZJQNetworkManager()
@property(strong,nonatomic)AFHTTPSessionManager * manager;
@end

@implementation ZJQNetworkManager

+ (instancetype)shareNetworkTool
{
    static ZJQNetworkManager * instance;
    static dispatch_once_t onceToken ;
    dispatch_once(& onceToken, ^{
        instance = [[self alloc]init];
    });
    return instance ;
}
- (instancetype)init
{
    if (self = [super init]) {
        NSURLSessionConfiguration * sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        sessionConfiguration.timeoutIntervalForRequest = 30;
        self.manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:sessionConfiguration];
        self.manager.operationQueue.maxConcurrentOperationCount = 3 ;
        self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", @"text/json", @"text/javascript", @"text/plain", nil];
    }
    return self;
}
- (id)GET:(NSString *)url parameters:(NSDictionary *)parameters completionHandler:(void (^)(id, NSError *))completionHandler
{
    NSString * filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)firstObject];
    return [self.manager GET:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        nil;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", task.currentRequest.URL.absoluteString);
        NSString * cachePath = [filePath stringByAppendingPathComponent:task.currentRequest.URL.absoluteString.md5String];
        //先写入硬盘
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [NSKeyedArchiver archiveRootObject:responseObject toFile:cachePath];
        });
        !completionHandler? : completionHandler(responseObject,nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", task.currentRequest.URL.absoluteString);
        NSLog(@"%@", error);
        NSString * cachePath = [filePath stringByAppendingPathComponent:task.currentRequest.URL.absoluteString.md5String];
       // 从硬盘读出来
        id responseObject = [NSKeyedUnarchiver unarchiveObjectWithFile:cachePath];
        if (responseObject) {
            
            !completionHandler ? : completionHandler(responseObject,nil);
        }
        else
        {
            !completionHandler ? : completionHandler(nil,error);

        }
    }];
    
}

@end
