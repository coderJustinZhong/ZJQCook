//
//  ZJQMainViewController.m
//  ZJQCook
//
//  Created by abc on 16/10/3.
//  Copyright © 2016年 ZJQ. All rights reserved.
//

#import "ZJQMainViewController.h"
#import "ZJQHeaderViewCell.h"
#import "ZJQNetworkManager.h"
#import <MJExtension.h>
//#import "ZJQheaderAdListModel.h"
#import "ZJQheaderAdModel.h"
@interface ZJQMainViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *TableView;
/**头部位置按钮*/
@property (weak, nonatomic) IBOutlet UIButton *locationBtn;
/**头部导航条*/
@property (weak, nonatomic) IBOutlet UIView *navView;
@property(strong,nonatomic)NSMutableArray * testarray;
@end

@implementation ZJQMainViewController
-(NSMutableArray *)testarray
{
    if (!_testarray) {
        _testarray = [NSMutableArray array];
    }
    return _testarray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpbasic];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - privict
- (void)setUpbasic
{
    self.TableView.delegate = self;
    self.TableView.dataSource = self;
    self.locationBtn.layer.cornerRadius = self.locationBtn.height/2;
    self.locationBtn.layer.masksToBounds = YES;
    self.navView.alpha = 0;
    
    [[ZJQNetworkManager shareNetworkTool] POST:@"http://user.mapi.jiashuangkuaizi.com/UFocus/list" parameters:nil completionHandler:^(NSDictionary * responseObj, NSError *error) {
        
    }];
    
    
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }
    else return 2;
}

#pragma mark - UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * ID1 = @"header";
    if (indexPath.section==0) {
        ZJQHeaderViewCell * headerCell = [tableView dequeueReusableCellWithIdentifier:ID1];
        if (!headerCell) {
            headerCell = [[[NSBundle mainBundle]loadNibNamed:@"ZJQHeaderViewCell" owner:nil options:nil]lastObject];
    }
        return headerCell;
    }
    
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"id2"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"id2"];
    }
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0&&indexPath.row==0) {
        return 400;
    }
    return 44;
}


#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = self.TableView.contentOffset.y;
    if (offsetY<80&&offsetY>0) {
        
        self.navView.alpha = offsetY/80;
        self.locationBtn.backgroundColor = RGBAColor(0, 0, 0, (1 - offsetY/80)/2);
        [self.locationBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    else if(offsetY>=80)
    {
    self.locationBtn.backgroundColor = RGBAColor(0, 0, 0, 0);
    self.navView.alpha = 1;
    [self.locationBtn setTitleColor:RGBAColor(241, 116, 67, 1) forState:UIControlStateNormal];
    }
    
}

@end
