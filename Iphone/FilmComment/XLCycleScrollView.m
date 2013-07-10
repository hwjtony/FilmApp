//
//  XLCycleScrollView.m
//  CycleScrollViewDemo
//
//  Created by xie liang on 9/14/12.
//  Copyright (c) 2012 xie liang. All rights reserved.
//

#import "XLCycleScrollView.h"

@implementation XLCycleScrollView

@synthesize scrollView = _scrollView;
@synthesize pageControl = _pageControl;
@synthesize currentPage = _curPage;
@synthesize datasource = _datasource;
@synthesize delegate = _delegate;

- (void)dealloc
{
    [_scrollView release];
    [_pageControl release];
    [_curViews release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.delegate = self;
        _scrollView.contentSize = CGSizeMake(self.bounds.size.width * 10, self.bounds.size.height);
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.contentOffset = CGPointMake(0, 0);
        _scrollView.pagingEnabled = YES;
        [self addSubview:_scrollView];
        
        CGRect rect = self.bounds;
        rect.origin.y = rect.size.height - 30;
        rect.size.height = 30;
        _pageControl = [[UIPageControl alloc] initWithFrame:rect];
        _pageControl.userInteractionEnabled = NO;
        
        //[self addSubview:_pageControl];
        _curPage = 0;
    }
    
    if (!_curViews) {
        _curViews = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (NSMutableArray *)getCurViews{
    return _curViews;
}

- (void)setDataource:(id<XLCycleScrollViewDatasource>)datasource
{
    _datasource = datasource;
    [self reloadData];
}

- (void)reloadData
{
    
    
    
    _totalPages = [_datasource numberOfPages];
    if (_totalPages == 0) {
        return;
    }
    
    for (int i = 0; i < _totalPages; i ++) {
        UIView *outside = [[[UIView alloc] initWithFrame:_scrollView.frame] autorelease];
        [outside setBackgroundColor:[UIColor whiteColor]];
        
        UIActivityIndicatorView *aiv = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        aiv.center = CGPointMake(_scrollView.frame.size.width / 2, _scrollView.frame.size.height/2-30);
        [aiv startAnimating];
        [outside addSubview:aiv];
        [aiv release];
        [_curViews addObject:outside];
        
        UIView *v = [_curViews objectAtIndex:i];
        v.userInteractionEnabled = YES;
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                    action:@selector(handleTap:)];
        [v addGestureRecognizer:singleTap];
        [singleTap release];
        v.frame = CGRectOffset(v.frame, v.frame.size.width * i, 0);
        NSLog(@"totalpages %d",_totalPages);
        [_scrollView addSubview:v];
        
    }
    [_datasource pageAtIndex:_curPage];
    _pageControl.numberOfPages = _totalPages;
    [self loadData];
}

- (void)loadData
{
    
    _pageControl.currentPage = _curPage;
    
    
}

- (void)getDisplayImagesWithCurpage:(int)page {
    
    int pre = [self validPageValue:_curPage-1];
    int last = [self validPageValue:_curPage+1];
    
    if (!_curViews) {
        _curViews = [[NSMutableArray alloc] init];
    }
    
    [_curViews removeAllObjects];
    
    [_curViews addObject:[_datasource pageAtIndex:pre]];
    [_curViews addObject:[_datasource pageAtIndex:page]];
    [_curViews addObject:[_datasource pageAtIndex:last]];
}

- (int)validPageValue:(NSInteger)value {
    
    if(value == -1) value = _totalPages - 1;
    if(value == _totalPages) value = 0;
    
    return value;
    
}

- (void)handleTap:(UITapGestureRecognizer *)tap {
    
    if ([_delegate respondsToSelector:@selector(didClickPage:atIndex:)]) {
        [_delegate didClickPage:self atIndex:_curPage];
    }
    
}

- (void)setViewContent:(UIView *)view atIndex:(NSInteger)index
{
    UIView *outside = [[[UIView alloc] initWithFrame:_scrollView.frame] autorelease];
    
    UIImageView *filmImg = [[[UIImageView alloc]  initWithImage:[UIImage imageNamed:@"shoucang.png"]] autorelease];
    [filmImg setFrame:_scrollView.frame];
    [filmImg setContentMode:UIViewContentModeScaleAspectFit];
    [outside addSubview:filmImg];
    
    UIView *v = view;
    v.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                action:@selector(handleTap:)];
    [v addGestureRecognizer:singleTap];
    [singleTap release];
    v.frame = CGRectOffset(v.frame, v.frame.size.width * index, 0);
    [_scrollView addSubview:v];
    
    
    
    NSLog(@"add");
    //}
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)aScrollView {
    int x = aScrollView.contentOffset.x;
    _curPage = x/_scrollView.bounds.size.width;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)aScrollView {
    NSLog(@"currentpage %d",_curPage);
    [_scrollView setContentOffset:CGPointMake(_scrollView.frame.size.width*_curPage, 0) animated:YES];
    //[self updateContent:_curPage];
    [_datasource pageAtIndex:_curPage];
    
}

@end
