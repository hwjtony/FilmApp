//
//  ImageycleScrollView.m
//  CycleScrollViewDemo
//
//  Created by xie liang on 9/14/12.
//  Copyright (c) 2012 xie liang. All rights reserved.
//

#import "ImageCycleScrollView.h"

@implementation ImageCycleScrollView

@synthesize scrollView = _scrollView;
@synthesize pageControl = _pageControl;
@synthesize currentPage = _curPage;
@synthesize fid = _fid;
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
        _scrollView.contentSize = CGSizeMake(self.bounds.size.width * 5, self.bounds.size.height);
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

- (void)setDataource:(id<IXLCycleScrollViewDatasource>)datasource
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
        [outside setBackgroundColor:[UIColor blackColor]];
        
        UIActivityIndicatorView *aiv = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        aiv.center = CGPointMake(_scrollView.frame.size.width / 2, _scrollView.frame.size.height/2);
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
        [_scrollView addSubview:v];
        
    }
    [_datasource pageAtIndex:_curPage];
    _pageControl.numberOfPages = _totalPages;
    [self loadData];
}

- (void)loadData
{
    
    _pageControl.currentPage = _curPage;
    //NSLog(@"currentpage %d",_curPage);
    //从scrollView上移除所有的subview
    //NSArray *subViews = [_scrollView subviews];
    
    
    //[self getDisplayImagesWithCurpage:_curPage];
    for (int i = 0; i < 5; i++) {
        NSLog(@"i %d",i);
        
        
        
    }
    
    
    
    
    //[_scrollView setContentOffset:CGPointMake(_scrollView.frame.size.width, 0)];
}

- (void)setViewContent:(UIImage *)image atIndex:(NSInteger)index
{
    //if (index == _curPage) {
       // [_curViews replaceObjectAtIndex:index withObject:view];
    //[[_scrollView.subviews objectAtIndex:index]removeFromSuperview];
    
    
    UIView *outside = [[[UIView alloc] initWithFrame:_scrollView.frame] autorelease];
    
    UIImageView *filmImg = [[[UIImageView alloc]  initWithImage:image] autorelease];
    [filmImg setFrame:_scrollView.frame];
    [filmImg setContentMode:UIViewContentModeScaleAspectFit];
    [outside addSubview:filmImg];
    
    UIView *v = outside;
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

- (void)handleTap:(UITapGestureRecognizer *)tap {
    
    if ([_delegate respondsToSelector:@selector(didClickPage:atIndex:)]) {
        [_delegate didClickPage:self atIndex:_curPage];
    }
    
}


- (int)validPageValue:(NSInteger)value {
    
    if(value == -1) value = _totalPages - 1;
    if(value == _totalPages) value = 0;
    
    return value;
    
}




#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)aScrollView {
    int x = aScrollView.contentOffset.x;
    _curPage = x/_scrollView.bounds.size.width;
    //[self loadData];
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)aScrollView {
    NSLog(@"currentpage %d",_curPage);
    [_scrollView setContentOffset:CGPointMake(_scrollView.frame.size.width*_curPage, 0) animated:YES];
    //[self updateContent:_curPage];
    [_datasource pageAtIndex:_curPage];
}

@end
