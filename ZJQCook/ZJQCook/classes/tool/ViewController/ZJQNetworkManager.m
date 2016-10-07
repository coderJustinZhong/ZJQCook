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

+ (instancetype)shareManager
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


- (id)POST:(NSString *)url parameters:(NSDictionary *)parameters completionHandler:(void (^)(id, NSError *))completionHandler
{

    //拼接参数
    NSMutableDictionary *param = [NSMutableDictionary new];
    //特殊传入的参数
    [param addEntriesFromDictionary:parameters];
    //共同的参数
    [param addEntriesFromDictionary:[ZJQNetworkManager commonParams]];
    
    return [self.manager POST:url parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", task.currentRequest.URL.absoluteString);
        !completionHandler? : completionHandler(responseObject,nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",task.currentRequest.URL.absoluteString);
        NSLog(@"%@",error);
        !completionHandler? : completionHandler(nil,error);
    }];
    
}

+ (NSMutableDictionary *)commonParams{
    NSMutableDictionary *paramDic = [NSMutableDictionary new];
    
    //经纬度字符串
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *coordinateStr = [NSString stringWithFormat:@"%f,%f",[userDefaults doubleForKey:kCurrentLongitudeKey], [userDefaults doubleForKey:kCurrentLatitudeKey]];
    //    NSLog(@"%@", coordinateStr);
    //为了不同地区的人都能用, 用假经纬度
    coordinateStr = @"116.469235297309,39.88134792751736";
    
    //当前时间, stringWithFormat是YYKit提供的日期便捷格式化方法
    NSString *timeStr = [[NSDate date] stringWithFormat:@"YYYY-MM-dd HH:mm:ss"];
    //    NSLog(@"%@", timeStr);
    
    //屏幕尺寸
    CGSize size = [UIScreen mainScreen].bounds.size;
    NSString *sizeStr = [NSString stringWithFormat:@"%.0f*%.0f", size.width, size.height];
    
    [paramDic setObject:@"110100" forKey:@"_cityid"];
    [paramDic setObject:@"1A3FAB1E-0FF5-471D-AE0F-4ED1E5B55DF3" forKey:@"_device"];
    [paramDic setObject:@"91577D73-DDF9-4151-BB86-AA3596963582" forKey:@"_idfa"];
    [paramDic setObject:[UIDevice currentDevice].systemVersion forKey:@"_osversion"];
    [paramDic setObject:@"iOS" forKey:@"_platform"];
    [paramDic setObject:sizeStr forKey:@"_screen"];
    [paramDic setObject:timeStr forKey:@"_time"];
    [paramDic setObject:@"2.9.6" forKey:@"_version"];
    [paramDic setObject:coordinateStr forKey:@"coordinate"];
    [paramDic setObject:@"0" forKey:@"type"];
    [paramDic setObject:coordinateStr forKey:@"user_coordinate"];
    
    //key不带下划线前缀的_
    [paramDic setObject:@"110100" forKey:@"cityid"];
    [paramDic setObject:@"1A3FAB1E-0FF5-471D-AE0F-4ED1E5B55DF3" forKey:@"device"];
    [paramDic setObject:@"91577D73-DDF9-4151-BB86-AA3596963582" forKey:@"idfa"];
    [paramDic setObject:[UIDevice currentDevice].systemVersion forKey:@"osversion"];
    [paramDic setObject:@"iOS" forKey:@"platform"];
    [paramDic setObject:sizeStr forKey:@"screen"];
    [paramDic setObject:timeStr forKey:@"time"];
    [paramDic setObject:@"2.9.6" forKey:@"version"];
    return paramDic;
}


@end
