//
//  XLCycleScrollView.h
//  CycleScrollViewDemo
//
//  Created by xie liang on 9/14/12.
//  Copyright (c) 2012 xie liang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol IXLCycleScrollViewDelegate;
@protocol IXLCycleScrollViewDatasource;

@interface ImageCycleScrollView : UIView<UIScrollViewDelegate>
{
    UIScrollView *_scrollView;
    UIPageControl *_pageControl;
    
    id<IXLCycleScrollViewDelegate> _delegate;
    id<IXLCycleScrollViewDatasource> _datasource;
    
    NSInteger _totalPages;
    NSInteger _curPage;
    NSString *_fid;
    
    NSMutableArray *_curViews;
}

@property (nonatomic,readonly) UIScrollView *scrollView;
@property (nonatomic,readonly) UIPageControl *pageControl;
@property (nonatomic,assign) NSInteger currentPage;
@property (nonatomic,assign) NSString *fid;
@property (nonatomic,assign,setter = setDataource:) id<IXLCycleScrollViewDatasource> datasource;
@property (nonatomic,assign,setter = setDelegate:) id<IXLCycleScrollViewDelegate> delegate;

- (void)reloadData;
- (void)setViewContent:(UIImage *)image atIndex:(NSInteger)index;
- (NSMutableArray *)getCurViews;
@end

@protocol IXLCycleScrollViewDelegate <NSObject>

@optional
- (void)didClickPage:(ImageCycleScrollView *)csView atIndex:(NSInteger)index;

@end

@protocol IXLCycleScrollViewDatasource <NSObject>

@required
- (NSInteger)numberOfPages;
- (UIView *)pageAtIndex:(NSInteger)index;

@end
