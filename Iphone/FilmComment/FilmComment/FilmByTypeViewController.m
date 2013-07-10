//
//  FilmByTypeViewController.m
//  FilmComment
//
//  Created by TonyKID on 12-12-3.
//  Copyright (c) 2012年 TonyKID. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "FilmByTypeViewController.h"
#import "CJSONDeserializer.h"
#import "DemoTableHeaderView.h"
#import "DemoTableFooterView.h"
#import "SharedViewController.h"

@interface FilmByTypeViewController ()
- (void) addItemsOnTop;
- (void) addItemsOnBottom;
- (NSString *) createRandomValue;
@end

@implementation FilmByTypeViewController

@synthesize typeListContent,typeAddListContent;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //[self.navigationController setNavigationBarHidden:NO];
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0.0, 0.0, 35.0, 35.0);
    [backButton setImage:[UIImage imageNamed:@"closeButton.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    temporaryBarButtonItem.style = UIBarButtonItemStylePlain;
    self.navigationItem.rightBarButtonItem=temporaryBarButtonItem;
    [temporaryBarButtonItem release];
    
    UIButton *bButton = [UIButton buttonWithType:UIButtonTypeCustom];
    bButton.frame = CGRectMake(0.0, 0.0, 60.0, 44.0);
    [bButton setImage:[UIImage imageNamed:@"backButton.png"] forState:UIControlStateNormal];
    [bButton addTarget:self action:@selector(doBack) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:bButton];
    backBarButtonItem.style = UIBarButtonItemStylePlain;
    self.navigationItem.leftBarButtonItem = backBarButtonItem;
    
    self.typeListContent = [[NSMutableArray alloc] init];
    //self.title = _data;
    self.canLoadMore = YES;
    //[self.tableView setBackgroundColor:[UIColor lightGrayColor]];
    
    // set the custom view for "pull to refresh". See DemoTableHeaderView.xib
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"DemoTableHeaderView" owner:self options:nil];
    DemoTableHeaderView *headerView = (DemoTableHeaderView *)[nib objectAtIndex:0];
    self.headerView = headerView;
    
    // set the custom view for "load more". See DemoTableFooterView.xib.
    nib = [[NSBundle mainBundle] loadNibNamed:@"DemoTableFooterView" owner:self options:nil];
    DemoTableFooterView *footerView = (DemoTableFooterView *)[nib objectAtIndex:0];
    self.footerView = footerView;
    [self loadMore];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) pinHeaderView
{
    [super pinHeaderView];
    
    // do custom handling for the header view
    DemoTableHeaderView *hv = (DemoTableHeaderView *)self.headerView;
    [hv.activityIndicator startAnimating];
    hv.title.text = @"Loading...";
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) unpinHeaderView
{
    [super unpinHeaderView];
    
    // do custom handling for the header view
    [[(DemoTableHeaderView *)self.headerView activityIndicator] stopAnimating];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Update the header text while the user is dragging
//
- (void) headerViewDidScroll:(BOOL)willRefreshOnRelease scrollView:(UIScrollView *)scrollView
{
    DemoTableHeaderView *hv = (DemoTableHeaderView *)self.headerView;
    if (willRefreshOnRelease)
        hv.title.text = @"Release to refresh...";
    else
        hv.title.text = @"Pull down to refresh...";
}

////////////////////////////////////////////////////////////////////////////////////////////////////
//
// refresh the list. Do your async calls here.
//
- (BOOL) refresh
{
    if (![super refresh])
        return NO;
    
    // Do your async call here
    // This is just a dummy data loader:
    [self performSelector:@selector(addItemsOnTop) withObject:nil afterDelay:2.0];
    // See -addItemsOnTop for more info on how to finish loading
    return YES;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Load More

////////////////////////////////////////////////////////////////////////////////////////////////////
//
// The method -loadMore was called and will begin fetching data for the next page (more).
// Do custom handling of -footerView if you need to.
//
- (void) willBeginLoadingMore
{
    DemoTableFooterView *fv = (DemoTableFooterView *)self.footerView;
    [fv.activityIndicator startAnimating];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Do UI handling after the "load more" process was completed. In this example, -footerView will
// show a "No more items to load" text.
//
- (void) loadMoreCompleted
{
    [super loadMoreCompleted];
    
    DemoTableFooterView *fv = (DemoTableFooterView *)self.footerView;
    [fv.activityIndicator stopAnimating];
    
    if (!self.canLoadMore) {
        // Do something if there are no more items to load
        // We can hide the footerView by: [self setFooterViewVisibility:NO];
        
        // Just show a textual info that there are no more items to load
        fv.infoLabel.hidden = NO;
    }
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL) loadMore
{
    if (![super loadMore])
        return NO;
    
    [self SearchData:[self.typeListContent count]];
    // Do your async loading here
    //[self performSelector:@selector(addItemsOnBottom) withObject:nil afterDelay:2.0];
    // See -addItemsOnBottom for more info on what to do after loading more items
    
    return YES;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Dummy data methods

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) addItemsOnTop
{
    for (int i = 0; i < 3; i++)
        [items insertObject:[self createRandomValue] atIndex:0];
    [self.tableView reloadData];
    
    // Call this to indicate that we have finished "refreshing".
    // This will then result in the headerView being unpinned (-unpinHeaderView will be called).
    [self refreshCompleted];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) addItemsOnBottom
{
    /*for (int i = 0; i < 5; i++)
     [items addObject:[self createRandomValue]];*/
    NSLog(@"cc %d",[self.typeListContent count]);
    [self.tableView reloadData];
    
    if (self.typeListContent.count > 50 || !self.canLoadMore)
        self.canLoadMore = NO; // signal that there won't be any more items to load
    else
        self.canLoadMore = YES;
    
    // Inform STableViewController that we have finished loading more items
    [self loadMoreCompleted];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString *) createRandomValue
{
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
    
    return [NSString stringWithFormat:@"%@ %@", [dateFormatter stringFromDate:[NSDate date]],
            [NSNumber numberWithInt:rand()]];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Standard TableView delegates

////////////////////////////////////////////////////////////////////////////////////////////////////
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.typeListContent.count;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*static NSString *CellIdentifier = @"Cell";
     
     UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
     if (cell == nil) {
     cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
     reuseIdentifier:CellIdentifier] autorelease];
     }
     
     cell.textLabel.text = [items objectAtIndex:indexPath.row];
     return cell;*/
    
    static NSString *kCellID = @"cellID";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellID];
    
	if (cell == nil)
	{        
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kCellID] autorelease];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}    
    NSArray*subviews = [[NSArray alloc]initWithArray:cell.contentView.subviews];
    for (UIView *subview in subviews) {
        [subview removeFromSuperview];
    }
    [subviews release];
	Film *film = nil;
    film = [self.typeListContent objectAtIndex:indexPath.row];
    //NSURL *url = [NSURL URLWithString:product.imgUrl];
	//cell.imageView.image = [UIImage imageWhithData:[NSData dataWithContentsOfURL:url]];
    UILabel *lbl = [[UILabel alloc]initWithFrame:CGRectMake(77, 60, 300, 40)];
    lbl.backgroundColor  = [UIColor clearColor];
    lbl.tag = indexPath.row;
    lbl.textColor = [UIColor grayColor];
    lbl.font = [UIFont fontWithName:@"Arial" size:13.0];
    lbl.text = film.time;
    [cell.contentView addSubview:lbl];
    [lbl release];
    
    cell.imageView.image = film.img;
	cell.textLabel.text = film.name;
    cell.detailTextLabel.text = film.performer;
    
	return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{//设置每行高度
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SharedViewController *detailsViewController = [[SharedViewController alloc] init];
    detailsViewController.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height)];
    detailsViewController.webView.delegate = detailsViewController;
    NSLog(@"selectrow");
	Film *film = nil;
	film = [self.typeListContent objectAtIndex:indexPath.row];
    NSString *url = [NSString stringWithFormat:@"http://192.168.1.11/Movie/index.php?r=site/filmDetailIphone&fid=%@",film.url];
    NSLog(@"%@",url);
    [detailsViewController.webView loadRequest:[[NSURLRequest alloc] initWithURL:[[NSURL alloc] initWithString:url]]];
    [detailsViewController viewDidLoad];
    [detailsViewController.view addSubview:detailsViewController.webView];
    detailsViewController.return_flag = YES;
    [[self navigationController] pushViewController:detailsViewController animated:YES];
    
	
	detailsViewController.title = film.name;
    
    //[[self navigationController] pushViewController:detailsViewController animated:YES];
    [detailsViewController release];
}

-(void)SearchData:(int)offset{
    NSString *urlString = [NSString stringWithFormat:@"http://192.168.1.11/Movie/index.php?r=site/TypeSearch&offset=%d&type=%@",offset,_data];
    NSLog(@"%@",_data);
    NSStringEncoding enc = NSUTF8StringEncoding;
    NSString *strUrld8 = [urlString stringByAddingPercentEscapesUsingEncoding:enc];
    //调用http get请求方法
    [self sendRequestByGet:strUrld8];
}

//HTTP get请求方法
- (void)sendRequestByGet:(NSString*)urlString
{
    NSURL *url=[NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url
                                                                cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                            timeoutInterval:60];
    //设置请求方式为get
    [request setHTTPMethod:@"GET"];
    //添加用户会话id
    [request addValue:@"text/html" forHTTPHeaderField:@"Content-Type"];
    //连接发送请求
    self.typeReceivedData=[[NSMutableData alloc] initWithData:nil];
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [request release];
    [conn release];
}
- (void)connection:(NSURLConnection *)aConn didReceiveResponse:(NSURLResponse *)response {
    // 注意这里将NSURLResponse对象转换成NSHTTPURLResponse对象才能去
    //NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
    if ([response respondsToSelector:@selector(allHeaderFields)]) {
        //NSDictionary *dictionary = [httpResponse allHeaderFields];
        NSLog(@"receiveResponse");
        //NSLog(@"[email=dictionary=%@]dictionary=%@",[dictionary[/email] description]);
    }
}
//接收NSData数据
- (void)connection:(NSURLConnection *)aConn didReceiveData:(NSData *)data {
    [self.typeReceivedData appendData:data];
    NSLog(@"receiveData%@",nil);
}
- (void)connection:(NSURLConnection *)aConn didFailWithError:(NSError *)error{
    //NSLog(@"[email=error=%@]error=%@",[error[/email] localizedDescription]);
    NSLog(@"fail");
}
//接收完毕,显示结果
- (void)connectionDidFinishLoading:(NSURLConnection *)aConn {
    NSData *data = [[NSData alloc]
                    initWithBytes:[self.typeReceivedData bytes]
                    length:[self.typeReceivedData length]];
    
    NSError *error;
    NSMutableDictionary *root = [[CJSONDeserializer deserializer] deserialize:data error:&error];
    if (root.count<5) {
        self.canLoadMore = NO;
    }
    NSLog(@"%@ %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
    NSMutableArray *picArray = [[NSMutableArray alloc] init];
    //[self.typeFilteredListContent removeAllObjects];// First clear the filtered array.
    for (NSMutableDictionary *picture in root) {
        NSString *name = [picture objectForKey:@"name"];
        NSString *surl = [NSString stringWithFormat:@"%@%@",@"http://192.168.1.11/Movie/index.php?r=site/filmDetailIphone&fid=",[picture objectForKey:@"url"]];
        NSString *imgUrl = [NSString stringWithFormat:@"%@%@",@"http://192.168.1.11/Movie/images/imgs/small_icon/",[picture objectForKey:@"imgUrl"]];
        NSURL *url = [NSURL URLWithString:imgUrl];
        UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
        NSString *performer = [picture objectForKey:@"performer"];
        NSString *time = [picture objectForKey:@"datetime"];
        NSLog(@"imgUrl is %@",imgUrl);
        
        [self.typeListContent addObject:[Film productWithUrl:surl name:name img:img performer:performer time:time]];
        
    }
    [self addItemsOnBottom];
    //[self performSelector:@selector(addItemsOnBottom) withObject:nil afterDelay:2.0];
    //[self.tableView reloadData];
    [data release];
    [picArray release];
}

-(void)close{
    
    [self.navigationController setToolbarHidden:NO animated:YES];
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.7];
    [animation setType: kCATransitionReveal];
    [animation setSubtype: kCATransitionFromBottom];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
    [self.navigationController.view.layer addAnimation:animation forKey:nil];
    [self.navigationController popToRootViewControllerAnimated:NO];
    
}

-(void)doBack{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
