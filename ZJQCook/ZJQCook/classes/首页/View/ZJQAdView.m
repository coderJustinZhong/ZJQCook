//
//  ZJQAdView.m
//  ZJQCook
//
//  Created by abc on 16/10/6.
//  Copyright © 2016年 ZJQ. All rights reserved.
//

#import "ZJQAdView.h"
@interface ZJQAdView()<UIScrollViewDelegate>
@property(strong,nonatomic)UIScrollView * scrollView;
@property(strong,nonatomic)UIPageControl * pageView;
@property(strong,nonatomic)NSTimer * timer;
@property(assign,nonatomic)NSInteger count;
@property(assign,nonatomic)NSInteger  currentPage;
@end
@implementation ZJQAdView
#pragma mark - getter
-(UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]init];
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator =NO;
        _scrollView.delegate = self;

        [self addSubview:_scrollView];

    }
    return _scrollView;
}

-(UIPageControl *)pageView
{
    if (!_pageView) {
        
        _pageView = [[UIPageControl  alloc]init];
        _pageView.currentPageIndicatorTintColor = RGBAColor(241, 115, 67, 1);
        _pageView.pageIndicatorTintColor = RGBAColor(202, 202, 202, 1);
        _pageView.currentPage = 0;

        [self addSubview:_pageView];
    }
    return _pageView;
}


-(NSTimer *)timer
{
    if(!_timer)
    {
        _timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    }
    return _timer;
}
#pragma mark - public
-(void)setWithAdCount:(NSInteger)count ImageViews:(NSArray<UIImageView *> *)imageVIews Frame:(CGRect)frame
{
    self.frame = frame;
    self.scrollView.frame =self.frame;
    _scrollView.contentSize = CGSizeMake(frame.size.width*count, frame.size.height);
    
    
    self.count = count;
    for (UIView * childView in self.scrollView.subviews) {
        if ([childView isKindOfClass:[UIImageView class]]) {
            [childView removeFromSuperview];
        }
    }
    
    for (int i=0; i<count; i++) {
        imageVIews[i].frame = CGRectMake(i*_scrollView.width, 0, _scrollView.width, _scrollView.height);
        [_scrollView addSubview:imageVIews[i]];
    }
    
    self.pageView.centerX = _scrollView.centerX;
    _pageView.y = _scrollView.height - _pageView.height -15;
    _pageView.numberOfPages = count;
    self.currentPage = 0;
    [self addTimer];
    [self layoutIfNeeded];
    
}

#pragma mark - UIScrollViewDelegate
/**切换页码*/
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    CGFloat pageWidth = _scrollView.width;
    int page = floor((_scrollView.contentOffset.x - pageWidth / 2) /pageWidth) +1;
    [_pageView setCurrentPage:page];
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self removeTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self addTimer];
}
#pragma mark - privict
/**滑动到某一图片*/

-(void)nextPage
{
    if (self.currentPage>=self.count) {
        self.currentPage=0;
    }
    else self.currentPage++;
    CGRect frame = _scrollView.frame;
    frame.origin.x = frame.size.width * self.currentPage;
    [_scrollView scrollRectToVisible:frame animated:YES];
}


- (void)addTimer
{
    
    [[NSRunLoop mainRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)removeTimer
{
    [self.timer invalidate];
    
    self.timer = nil;
}
-(void)dealloc
{
    [self removeTimer];
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
}
@end
