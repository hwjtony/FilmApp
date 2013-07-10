//
//  NewIndexViewController.m
//  FilmComment2
//
//  Created by TonyKID on 12-12-5.
//  Copyright (c) 2012年 TonyKID. All rights reserved.
//

#import "NewIndexViewController.h"
#import "CJSONDeserializer.h"
#import "FilmObj.h"
#import "SharedViewController.h"
#import "MyBar.h"
#import "TypeViewController.h"
#import "SearchViewController.h"
#import "ListViewController.h"
#import "CommentCollectionController.h"
#import "CommentTableViewController.h"

@interface NewIndexViewController ()

@end

@implementation NewIndexViewController

@synthesize pageStillLoading;

- (void)viewDidLoad
{
    [super viewDidLoad];
    contentArray = [[NSMutableArray alloc] initWithObjects:@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",@"0",nil];
    UIImage* titleImage = [UIImage imageNamed:@"navigationBarLogo.png"];
    UIView* titleView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,titleImage.size.width, self.navigationController.navigationBar.frame.size.height)];
    UIImageView* titleImageView = [[UIImageView alloc] initWithImage:titleImage];
    [titleView addSubview:titleImageView];
    titleImageView.center = titleView.center;
    CGRect titleImageViewFrame = titleImageView.frame;
    // Offset the logo up a bit
    titleImageViewFrame.origin.y = titleImageViewFrame.origin.y + 3.0;
    titleImageView.frame = titleImageViewFrame;
    self.navigationItem.titleView = titleView;
    
    /*UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(20, 11, 100, 20)];
    title.backgroundColor = [UIColor clearColor];
    title.font = [UIFont fontWithName:@"Helvetica-BoldOblique" size:13.0];
    title.text = @"测试！！";
    [self.navigationItem.titleView addSubview:title];*/
    
    // Get our custom nav bar
    MyBar* customNavigationBar = (MyBar*)self.navigationController.navigationBar;
    customNavigationBar.hidden = NO;
    // Set the nav bar's background
    [customNavigationBar setBackgroundWith:[UIImage imageNamed:@"navigationBar.png"]];
    
    //UIBarButtonItem *temporaryBarButtonItem =[[UIBarButtonItem alloc] initWithTitle:@"分类" style:UIBarButtonItemStylePlain target:self action:@selector(more)];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0.0, 0.0, 35.0, 35.0);
    [backButton setImage:[UIImage imageNamed:@"rightTypeButton.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(more) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    temporaryBarButtonItem.style = UIBarButtonItemStylePlain;
    self.navigationItem.leftBarButtonItem=temporaryBarButtonItem;
    [temporaryBarButtonItem release];
    
    self.navigationItem.rightBarButtonItem = temporaryBarButtonItem;
    
    
    
	// Do any additional setup after loading the view, typically from a nib.
    films = [[NSMutableArray alloc] init];
    
    /*pageStillLoading = YES;
    [self SearchData:nil];
    while (pageStillLoading) {
        NSLog(@"loading");
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    }*/
    if(!csView){
        csView = [[XLCycleScrollView alloc] initWithFrame:self.view.bounds];
        csView.delegate = self;
        csView.datasource = self;
        [self.view addSubview:csView];
        NSLog(@"init");
    }
    
    
    
}

- (void)viewDidAppear:(BOOL)animated{
    //toolBar
    UIToolbar *toolBar = self.navigationController.toolbar;
    
    UIImageView *toolBarView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    toolBarView.image = [UIImage imageNamed:@"bottomBar.png"];
    [toolBar insertSubview:toolBarView atIndex:1];
    
    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    searchButton.frame = CGRectMake(265, 0.0, 42.0, 44.0);
    [searchButton setImage:[UIImage imageNamed:@"search.png"] forState:UIControlStateNormal];
    [searchButton addTarget:self action:@selector(search) forControlEvents:UIControlEventTouchUpInside];
    [toolBar addSubview:searchButton];
    
    
    
    UIButton *likeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    likeButton.frame = CGRectMake(181, 0.0, 67.0, 44.0);
    [likeButton setImage:[UIImage imageNamed:@"p2.png"] forState:UIControlStateNormal];
    [likeButton addTarget:self action:@selector(like) forControlEvents:UIControlEventTouchUpInside];
    [toolBar addSubview:likeButton];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (NSInteger)numberOfPages
{
    return 10;
}

- (UIView *)pageAtIndex:(NSInteger)index
{
    if ([contentArray objectAtIndex:index]==@"0") {
        [self SearchData:index];
    }
    
    
    return nil;
}

- (void)didClickPage:(XLCycleScrollView *)csView atIndex:(NSInteger)index
{
    [self.navigationController setToolbarHidden:YES animated:YES];
    SharedViewController *detailsViewController = [[SharedViewController alloc] init];
    detailsViewController.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height)];
    detailsViewController.webView.delegate = detailsViewController;
	FilmObj *film = nil;
        film = [films objectAtIndex:index];
    NSLog(@"url %@",film.url);
        NSString *url = [NSString stringWithFormat:@"http://192.168.1.11/Movie/index.php?r=site/filmDetailIphone&fid=%@",film.url];
        [detailsViewController.webView loadRequest:[[NSURLRequest alloc] initWithURL:[[NSURL alloc] initWithString:url]]];
        [detailsViewController viewDidLoad];
        [detailsViewController.view addSubview:detailsViewController.webView];
    
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.7];
    [animation setType: kCATransitionMoveIn];
    [animation setSubtype: kCATransitionFromTop];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
    [self.navigationController pushViewController:detailsViewController animated:NO];
    [self.navigationController.view.layer addAnimation:animation forKey:nil];
    //[[self navigationController] pushViewController:detailsViewController animated:YES];
    
	detailsViewController.title = film.name;
    //[[self navigationController] pushViewController:detailsViewController animated:YES];
    [detailsViewController release];
    
}

- (void)like{
    [self.navigationController setToolbarHidden:YES animated:YES];
    ListViewController *listViewController1 = [[ListViewController alloc] initWithNibName:@"ListViewController" bundle:nil];
    listViewController1.data = @"评论";
	CommentCollectionController *listViewController2 = [[CommentCollectionController alloc] initWithNibName:@"CommentCollectionController" bundle:nil];
    listViewController2.data = @"电影";
	
	listViewController1.title = @"收藏的电影";
	listViewController2.title = @"收藏的评论";
    
	NSArray *viewControllers = [NSArray arrayWithObjects:listViewController1, listViewController2, nil];
	MHTabBarController *tabBarController = [[MHTabBarController alloc] init];
    
	//tabBarController.delegate = self;
	tabBarController.viewControllers = viewControllers;
    
    
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.7];
    [animation setType: kCATransitionMoveIn];
    [animation setSubtype: kCATransitionFromTop];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
    [self.navigationController pushViewController:tabBarController animated:NO];
    [self.navigationController.view.layer addAnimation:animation forKey:nil];
    
    [tabBarController release];
}

- (void)more{
    [self.navigationController setToolbarHidden:YES animated:YES];
    TypeViewController *detailsViewController = [[TypeViewController alloc] initWithNibName:@"TypeViewController" bundle:nil];
    
    
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.7];
    [animation setType: kCATransitionMoveIn];
    [animation setSubtype: kCATransitionFromTop];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
    [self.navigationController pushViewController:detailsViewController animated:NO];
    [self.navigationController.view.layer addAnimation:animation forKey:nil];
    
    [detailsViewController release];
}

- (void)search{
    [self.navigationController setToolbarHidden:YES animated:YES];
    SearchViewController *detailsViewController = [[SearchViewController alloc] init];
    
    
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.7];
    [animation setType: kCATransitionMoveIn];
    [animation setSubtype: kCATransitionFromTop];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
    [self.navigationController pushViewController:detailsViewController animated:NO];
    [self.navigationController.view.layer addAnimation:animation forKey:nil];
    
    [detailsViewController release];
}

-(void)SearchData:(int)index{
    NSString *urlString = [NSString stringWithFormat:@"http://192.168.1.11/Movie/index.php?r=site/getIndexFilm&index=%d",index];
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
    if(!csView){
        csView = [[XLCycleScrollView alloc] initWithFrame:self.view.bounds];
        csView.delegate = self;
        csView.datasource = self;
        [self.view addSubview:csView];
        NSLog(@"init");
    }
    NSData *data = [[NSData alloc]
                    initWithBytes:[self.typeReceivedData bytes]
                    length:[self.typeReceivedData length]];
    
    NSError *error;
    NSMutableDictionary *root = [[CJSONDeserializer deserializer] deserialize:data error:&error];
    
    NSLog(@"%@ %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
    NSMutableArray *picArray = [[NSMutableArray alloc] init];
    for (NSMutableDictionary *picture in root) {
        NSString *name = [picture objectForKey:@"name"];
        NSString *introduce = [picture objectForKey:@"introduce"];
        NSString *surl = [picture objectForKey:@"url"];
        NSString *imgUrl = [picture objectForKey:@"imgUrl"];
        NSString *score = [picture objectForKey:@"score"];
        NSString *index = [picture objectForKey:@"index"];
        NSLog(@"name %@",introduce);
        
        
        
        
        
        CGRect upRect = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height/2);
        CGRect downRect = CGRectMake(20, self.view.frame.size.height/2+30, self.view.frame.size.width-40, self.view.frame.size.height/2-74);
        UIView *outside = [[[UIView alloc] initWithFrame:self.view.bounds] autorelease];
        //UIImageView *filmImg= [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Avatar1.png"]] autorelease];
        
        
        NSURL *url = [NSURL URLWithString:imgUrl];
        UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
        
        UIImageView *filmImg = [[[UIImageView alloc]  initWithImage:img] autorelease];
        [filmImg setFrame:upRect];
        [filmImg setContentMode:UIViewContentModeScaleToFill];
        
        UILabel *filmTitle = [[UILabel alloc] initWithFrame:CGRectMake(25, self.view.frame.size.height/2, self.view.frame.size.width-40, 30)];
        filmTitle.font = [UIFont fontWithName:@"Helvetica-BoldOblique" size:22.0];
        filmTitle.text = name;
        UILabel *filmScore = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width*2/3+10, self.view.frame.size.height/2, self.view.frame.size.width-40, 30)];
        filmScore.font = [UIFont fontWithName:@"Arial" size:22.0];
        filmScore.text = [[NSString alloc] initWithFormat:@"得分:%@",score];
        filmScore.textColor = [UIColor redColor];
        
        filmBrief = [[[UITextView alloc] initWithFrame:downRect] autorelease];
        filmBrief.textColor = [[UIColor alloc] initWithWhite:0.18 alpha:1];
        filmBrief.font = [UIFont fontWithName:@"Arial" size:13.0];
        filmBrief.text = introduce;
        
        [filmBrief setEditable:NO];
        
        //UIImage *imgButtom = [UIImage imageNamed:@"bottomBar"];
        //[outside addSubview:buttomImg];
        [outside addSubview:filmImg];
        [outside addSubview:filmBrief];
        [outside addSubview:filmTitle];
        [outside addSubview:filmScore];
        
        if ([contentArray objectAtIndex:[index intValue]]==@"0") {
            [contentArray replaceObjectAtIndex:[index intValue] withObject:outside];
            [csView setViewContent:outside atIndex:[index intValue]];
        }
        
        [films addObject:[FilmObj productWithUrl:surl name:name img:imgUrl introduce:introduce score:score]];
    }
    
    pageStillLoading = NO;
    [data release];
    [picArray release];
}


@end
