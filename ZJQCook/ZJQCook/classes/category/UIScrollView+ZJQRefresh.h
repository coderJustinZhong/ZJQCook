//
//  UIScrollView+ZJQRefresh.h
//  ZJQCook
//
//  Created by abc on 16/10/6.
//  Copyright © 2016年 ZJQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (ZJQRefresh)

- (void)addHeaderRefresh:( void(^)() )block;

- (void)headerBeginRefreshing;

- (void)headerEndRefresh;

- (void)addFooterResfesh:(void(^)())block;

- (void)footerEndRefresh;

- (void)footerBeginRefreshing;

- (void)footerNoMoreData;

- (void)footerReset;

@end
