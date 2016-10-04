//
//  ZJQTabBarController.m
//  ZJQCook
//
//  Created by abc on 16/10/3.
//  Copyright © 2016年 ZJQ. All rights reserved.
//

#import "ZJQTabBarController.h"
#import "ZJQMainViewController.h"
#import "ZJQMineViewController.h"
#import "ZJQDiscoverViewController.h"
@interface ZJQTabBarController ()

@end

@implementation ZJQTabBarController

- (void)viewDidLoad {   
    [super viewDidLoad];
    //基础设置
    [self setUpChildViewController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private

/**基础设置*/
- (void)setUpChildViewController
{
    ZJQMainViewController * main = [[ZJQMainViewController alloc]init];
    [self setUpChildViewWithViewController:main Title:@"首页" selectIcon:[UIImage imageNamed:@"home_sel"] unselectIcon:[UIImage imageNamed:@"home_unsel"]];
    ZJQDiscoverViewController * discover = [[ZJQDiscoverViewController alloc]init];
    [self setUpChildViewWithViewController:discover Title:@"发现" selectIcon:[UIImage imageNamed:@"discover_sel"] unselectIcon:[UIImage imageNamed:@"discover_unsel"]];
    ZJQMineViewController * mine = [[ZJQMineViewController alloc]init];
    [self setUpChildViewWithViewController:mine Title:@"我的" selectIcon:[UIImage imageNamed:@"my_sel"] unselectIcon:[UIImage imageNamed:@"my_unsel"]];
    
}

- (void)setUpChildViewWithViewController:(UIViewController*)Vc Title:(NSString*)title selectIcon:(UIImage*)selectImage unselectIcon:(UIImage *)unselectImage
{
    [self addChildViewController:Vc];
    Vc.title = title;
    Vc.tabBarItem.image = unselectImage;
    Vc.tabBarItem.selectedImage = selectImage;
}
@end
