//
//  CommentDetailController.m
//  FilmComment
//
//  Created by TonyKID on 12-12-13.
//  Copyright (c) 2012年 TonyKID. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "CommentDetailController.h"
#import "CJSONDeserializer.h"

@interface CommentDetailController ()

@end

@implementation CommentDetailController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    loadingContent = YES;
	// Do any additional setup after loading the view.
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0.0, 0.0, 35.0, 35.0);
    [backButton setImage:[UIImage imageNamed:@"closeButton.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    temporaryBarButtonItem.style = UIBarButtonItemStylePlain;
    self.navigationItem.rightBarButtonItem=temporaryBarButtonItem;
    [temporaryBarButtonItem release];
    
    //backbutton
    UIButton *bButton = [UIButton buttonWithType:UIButtonTypeCustom];
    bButton.frame = CGRectMake(0.0, 0.0, 60.0, 44.0);
    [bButton setImage:[UIImage imageNamed:@"backButton.png"] forState:UIControlStateNormal];
    [bButton addTarget:self action:@selector(doBack) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:bButton];
    backBarButtonItem.style = UIBarButtonItemStylePlain;
    self.navigationItem.leftBarButtonItem = backBarButtonItem;
    
    NSLog(@"commentd");
    
    //loading
    loadView = [[[UIAlertView alloc] initWithTitle:@"Please Wait" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles: nil] autorelease];
    [loadView show];
    [self SearchData];
	// Create and add the activity indicator
	UIActivityIndicatorView *aiv = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
	aiv.center = CGPointMake(loadView.bounds.size.width / 2.0f, loadView.bounds.size.height - 40.0f);
	[aiv startAnimating];
	[loadView addSubview:aiv];
	[aiv release];
}

-(void)viewDidAppear:(BOOL)animated{
    //toolBar
    //[self.navigationController setToolbarHidden:NO animated:NO];
    
    UIToolbar *toolBar = self.navigationController.toolbar;
    
    UIImageView *toolBarView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    toolBarView.image = [UIImage imageNamed:@"bottomBar.png"];
    [toolBar insertSubview:toolBarView atIndex:1];
    
    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    searchButton.frame = CGRectMake(250, 0.0, 70.0, 44.0);
    [searchButton setImage:[UIImage imageNamed:@"blankButton.png"] forState:UIControlStateNormal];
    [searchButton setImage:[UIImage imageNamed:@"blankButton.png"] forState:UIControlStateHighlighted]; 
    [toolBar addSubview:searchButton];
    
    UIButton *likeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    likeButton.frame = CGRectMake(195, 0.0, 44.0, 44.0);
    [likeButton setImage:[UIImage imageNamed:@"shoucang.png"] forState:UIControlStateNormal];
    [likeButton addTarget:self action:@selector(shoucang) forControlEvents:UIControlEventTouchUpInside];
    [toolBar addSubview:likeButton];
    [self.navigationController setToolbarHidden:NO animated:YES];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)shoucang{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"收藏成功" message:@"收藏夹可以从主界面下放的收藏标签进入" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alert show];
    [alert release];
    
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *paths = [[path objectAtIndex:0] stringByAppendingPathComponent:kFileName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL findFile = [fileManager fileExistsAtPath:paths];
    NSLog(@"Database file path = %@",paths);
    if(findFile)
    {
        NSLog(@"Database file have already existed.");
        
        if(sqlite3_open([paths UTF8String], &database) != SQLITE_OK)//打开数据库失败
        {
            sqlite3_close(database);
            NSAssert(0,@"Failed to open database");
        }
    }else{
        NSLog(@"Database file does not exsit!");
        if(sqlite3_open([paths UTF8String], &database) != SQLITE_OK)//打开数据库失败
        {
            sqlite3_close(database);
            NSAssert(0,@"Failed to open database");
        }
    }
    char *errorMsg;
    
    //创建表
    NSString *createSQL = @"create table if not exists comment_collection (row INTEGER PRIMARY KEY,fid varchar(255) ,cid varchar(255) ,title varchar(255),time varchar(255),name varchar(255),content text unique);";
    if(sqlite3_exec(database, [createSQL UTF8String],NULL,NULL,&errorMsg)!=SQLITE_OK)
    {
        sqlite3_close(database);
        NSAssert1(0,@"Error creating table: %s",errorMsg);
    }
    //NSMutableArray *persistentArray = [[NSMutableArray alloc] init];
    //[persistentArray addObject:fid];
    //for (int i = 0; i < [persistentArray count]; i++) {
    NSString *insertDataSQL = [[NSString alloc] initWithFormat:@"insert or replace into comment_collection (row,fid,cid,title,time,name,content) values (NULL,'%@','%@','%@','%@','%@','%@');",nil,self.cid,self.commentTitle,self.time,self.name,self.content];
    //char* errorMsg;
    
    if(sqlite3_exec(database,[insertDataSQL UTF8String],NULL,NULL,&errorMsg)!= SQLITE_OK){
        sqlite3_close(database);
        NSAssert(0,@"Failed to open database");
    }
    //}
    //unarchive
    NSString *query = @"select * from comment_collection order by row";//查找表中的数据
    sqlite3_stmt *statement;
    if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil)
       == SQLITE_OK)
    {
        while(sqlite3_step(statement) == SQLITE_ROW)
        {
            int row = sqlite3_column_int(statement, 0);
            char *rowData = (char *)sqlite3_column_text(statement, 1);
            char *rowData1 = (char *)sqlite3_column_text(statement, 2);
            char *rowData2 = (char *)sqlite3_column_text(statement, 3);
            char *rowData3 = (char *)sqlite3_column_text(statement, 4);
            char *rowData4 = (char *)sqlite3_column_text(statement, 5);
            
            NSString *fieldName = [[NSString alloc] initWithFormat:@"show%d",row];
            NSString *fieldValue = [[NSString alloc] initWithUTF8String:rowData];
            NSString *fieldValue1 = [[NSString alloc] initWithUTF8String:rowData1];
            NSString *fieldValue2 = [[NSString alloc] initWithUTF8String:rowData2];
            NSString *fieldValue3 = [[NSString alloc] initWithUTF8String:rowData3];
            NSString *fieldValue4 = [[NSString alloc] initWithUTF8String:rowData4];
            
            NSLog(@"fieldName is :%@,fieldValue is :%@ %@ %@ %@ %@",fieldName,fieldValue,fieldValue1,fieldValue2,fieldValue3,fieldValue4);
            
            [fieldName release];
            [fieldValue release];
        }
        sqlite3_finalize(statement);
    }
}

-(void)SearchData{
    NSString *urlString = [NSString stringWithFormat:@"http://192.168.1.11/Movie/index.php?r=site/oneComment&cid=%@",self.cid];
    NSLog(@"cid is %@",self.cid);
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
    NSLog(@"%@ %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
    NSMutableArray *picArray = [[NSMutableArray alloc] init];
    self.name = [root objectForKey:@"name"];
    self.commentTitle = [root objectForKey:@"title"];
    self.content = [root objectForKey:@"content"];
    self.time = [root objectForKey:@"time"];
    /*UITextView *commentView = [[UITextView alloc] initWithFrame:CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height-44)];
     [commentView setEditable:NO];
    [commentView setText:self.content];*/
    NSString *outputString = [[NSString alloc]initWithFormat:@"<h2>%@</h2><h3>%@  %@</h3>%@",self.commentTitle,self.name,self.time,self.content];
    UIWebView *commentView = [[UIWebView alloc] initWithFrame:CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height-44)];
    commentView.scrollView.bounces = NO;
    [commentView loadHTMLString:outputString baseURL:nil];
    [self.view addSubview:commentView];
    [loadView dismissWithClickedButtonIndex:0 animated:NO];
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
