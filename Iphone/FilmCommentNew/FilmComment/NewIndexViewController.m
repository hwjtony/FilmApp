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

@interface NewIndexViewController ()

@end

@implementation NewIndexViewController

@synthesize pageStillLoading;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Set the title view to the Instagram logo
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
    
    // Get our custom nav bar
    MyBar* customNavigationBar = (MyBar*)self.navigationController.navigationBar;
    
    // Set the nav bar's background
    [customNavigationBar setBackgroundWith:[UIImage imageNamed:@"navigationBarBackgroundRetro.png"]];
    
    UIBarButtonItem *temporaryBarButtonItem =[[UIBarButtonItem alloc] initWithTitle:@"分类" style:UIBarButtonItemStylePlain target:self action:@selector(more)];
    self.navigationItem.rightBarButtonItem = temporaryBarButtonItem;
    
    
    
	// Do any additional setup after loading the view, typically from a nib.
    films = [[NSMutableArray alloc] init];
    
    pageStillLoading = YES;
    [self SearchData:index];
    while (pageStillLoading) {
        NSLog(@"loading");
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    }
    
    csView = [[XLCycleScrollView alloc] initWithFrame:self.view.bounds];
    csView.delegate = self;
    csView.datasource = self;
    [self.view addSubview:csView];
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
    
    CGRect upRect = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height/2+50);
    CGRect downRect = CGRectMake(0, self.view.frame.size.height/2+50, self.view.frame.size.width, self.view.frame.size.height/2-50);
    UIView *outside = [[[UIView alloc] initWithFrame:self.view.bounds] autorelease];
    //UIImageView *filmImg= [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Avatar1.png"]] autorelease];
    
    FilmObj *target = [films objectAtIndex:index];
    
    NSURL *url = [NSURL URLWithString:target.imgUrl];
    UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
    NSString *introduce = target.introduce;
    
    UIImageView *filmImg = [[[UIImageView alloc]  initWithImage:img] autorelease];
    [filmImg setFrame:upRect];
    [filmImg setContentMode:UIViewContentModeScaleToFill];
    filmBrief = [[[UITextView alloc] initWithFrame:downRect] autorelease];
    filmBrief.text = introduce;
    [outside addSubview:filmImg];
    [outside addSubview:filmBrief];
    return outside;
}

- (void)didClickPage:(XLCycleScrollView *)csView atIndex:(NSInteger)index
{
    SharedViewController *detailsViewController = [[SharedViewController alloc] init];
    detailsViewController.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height)];
    detailsViewController.webView.delegate = detailsViewController;
	FilmObj *film = nil;
        film = [films objectAtIndex:index];
    NSLog(@"url %@",film.url);
        NSString *url = [NSString stringWithFormat:@"http://192.168.3.12/index.php?r=site/filmDetail&fid=%@",film.url];
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

- (void)more{
    TypeViewController *detailsViewController = [[TypeViewController alloc] initWithNibName:@"TypeViewController" bundle:nil];
    
    
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.7];
    [animation setType: kCATransitionMoveIn];
    [animation setSubtype: kCATransitionFromTop];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
    [self.navigationController pushViewController:detailsViewController animated:NO];
    [self.navigationController.view.layer addAnimation:animation forKey:nil];
    //[[self navigationController] pushViewController:detailsViewController animated:YES];
    
    //[[self navigationController] pushViewController:detailsViewController animated:YES];
    [detailsViewController release];
}

-(void)SearchData:(int)index{
    NSString *urlString = [NSString stringWithFormat:@"http://192.168.3.12/index.php?r=site/getIndexFilm&index=%d",index];
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
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
    if ([response respondsToSelector:@selector(allHeaderFields)]) {
        NSDictionary *dictionary = [httpResponse allHeaderFields];
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
    
    NSLog(@"%@ %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
    NSMutableArray *picArray = [[NSMutableArray alloc] init];
    for (NSMutableDictionary *picture in root) {
        NSString *name = [picture objectForKey:@"name"];
        NSString *introduce = [picture objectForKey:@"introduce"];
        NSString *surl = [picture objectForKey:@"url"];
        NSString *imgUrl = [picture objectForKey:@"imgUrl"];
        NSLog(@"name %@",introduce);
        //NSURL *url = [NSURL URLWithString:imgUrl];
        //UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
        [films addObject:[FilmObj productWithUrl:surl name:name img:imgUrl introduce:introduce]];
    }
    pageStillLoading = NO;
    [data release];
    [picArray release];
}


@end
