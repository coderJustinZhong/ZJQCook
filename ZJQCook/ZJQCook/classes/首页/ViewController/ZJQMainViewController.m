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
#import "UIScrollView+ZJQRefresh.h"
#import "ZJQNetWorkTool.h"
#import "ZJQMainViewCell.h"



@interface ZJQMainViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *TableView;
/**头部位置按钮*/
@property (weak, nonatomic) IBOutlet UIButton *locationBtn;
/**头部导航条*/
@property (weak, nonatomic) IBOutlet UIView *navView;
@property(strong,nonatomic)NSMutableArray * testarray;
@property(strong,nonatomic)ZJQheaderAdModel * headerAdMode;
@property(strong,nonatomic)NSArray * headerActModels;
@property(strong,nonatomic)NSMutableArray * mainViewModels;

@end

@implementation ZJQMainViewController

-(NSMutableArray *)mainViewModels
{
    if (!_mainViewModels) {
        _mainViewModels = [NSMutableArray array];
    }
    return _mainViewModels;
}
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
    ZJQWeakSelf;
    [self.TableView addHeaderRefresh:^{
        [weakself.TableView footerEndRefresh];
        [ZJQNetWorkTool getMainViewData:^(ZJQheaderAdModel * mode1, NSArray<ZJQheaderActivityModel*>*model2, NSArray<ZJQMainViewModel*>*model3 ,NSError* error) {
            if (mode1) {
                weakself.headerAdMode = mode1;
                [weakself.TableView reloadData];
            }
            if (model2) {
                weakself.headerActModels = model2;
                [weakself.TableView reloadData];
            }
            if (model3) {
                [weakself.mainViewModels removeAllObjects];
                [weakself.mainViewModels addObjectsFromArray:model3];
                [weakself.TableView reloadData];
                [weakself.TableView footerReset];
            }
        }];
        [weakself.TableView headerEndRefresh];
    }];
    
    [self.TableView headerBeginRefreshing];
    
    
    [self.TableView addFooterResfesh:^{
        [weakself.TableView headerEndRefresh];
        [ZJQNetWorkTool getMoreMainViewData:^(NSArray<ZJQheaderActivityModel *> *model,NSInteger totalPage, NSInteger  currPage) {
            
            [weakself.mainViewModels addObjectsFromArray:model];
            [weakself.TableView reloadData];
            [weakself.TableView footerEndRefresh];
            if (totalPage == currPage) {
                [weakself.TableView footerNoMoreData];
            }
        }];
        
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
    else return self.mainViewModels.count;
}

#pragma mark - UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * ID1 = @"header";
    static NSString * ID2 = @"Main";
    if (indexPath.section==0) {
        ZJQHeaderViewCell * headerCell = [tableView dequeueReusableCellWithIdentifier:ID1];
        if (!headerCell) {
            headerCell = [[[NSBundle mainBundle]loadNibNamed:@"ZJQHeaderViewCell" owner:nil options:nil]lastObject];
    }
        //获取模型
        headerCell.headerAdModel = self.headerAdMode;
        headerCell.headerActModels = self.headerActModels;
        return headerCell;
    }
    else{
        ZJQMainViewCell * mainCell = [tableView dequeueReusableCellWithIdentifier:ID2];
        if (!mainCell) {
            mainCell = [[[NSBundle mainBundle]loadNibNamed:@"ZJQMainViewCell" owner:nil options:nil]lastObject];
            
        }
        
        //获取模型
        if (self.mainViewModels) {
        
            mainCell.MainViewModel = self.mainViewModels[indexPath.row];
            
        }
        mainCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return mainCell;
    }
    
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0&&indexPath.row==0) {
        return 350;
    }
    return 280;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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
