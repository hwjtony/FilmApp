//
//  SharedViewController.m
//  FilmComment
//
//  Created by TonyKID on 12-11-30.
//  Copyright (c) 2012年 TonyKID. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "SharedViewController.h"
#import "UAExampleModalPanel.h"
#import "UANoisyGradientBackground.h"
#import "UAGradientBackground.h"
#import "CommentTableViewController.h"
#import "ImageViewController.h"
#import "MyBar.h"

@interface SharedViewController ()

@end

@implementation SharedViewController

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
    
    
    
    //[self.navigationController setNavigationBarHidden:NO];
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0.0, 0.0, 35.0, 35.0);
    [backButton setImage:[UIImage imageNamed:@"closeButton.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    temporaryBarButtonItem.style = UIBarButtonItemStylePlain;
    self.navigationItem.rightBarButtonItem=temporaryBarButtonItem;
    [temporaryBarButtonItem release];
    self.navigationItem.hidesBackButton = YES;
	// Do any additional setup after loading the view.
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

- (void) performDismiss
{
    [loadView dismissWithClickedButtonIndex:0 animated:NO];
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    loadView = [[[UIAlertView alloc] initWithTitle:@"Please Wait" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles: nil] autorelease];
    [loadView show];
    
	// Create and add the activity indicator
	UIActivityIndicatorView *aiv = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
	aiv.center = CGPointMake(loadView.bounds.size.width / 2.0f, loadView.bounds.size.height - 40.0f);
	[aiv startAnimating];
	[loadView addSubview:aiv];
	[aiv release];
    
	// Auto dismiss after 3 seconds
	//[self performSelector:@selector(performDismiss) withObject:nil afterDelay:3.0f];
    NSLog(@"load");
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    NSLog(@"flag %d",self.return_flag);
    if (self.return_flag) {
        if(self.webView.canGoBack){
            NSLog(@"can");
            UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
            backButton.frame = CGRectMake(0.0, 0.0, 60.0, 44.0);
            [backButton setImage:[UIImage imageNamed:@"backButton.png"] forState:UIControlStateNormal];
            [backButton addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
            UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
            backBarButtonItem.style = UIBarButtonItemStylePlain;
            self.navigationItem.leftBarButtonItem = backBarButtonItem;
            self.navigationItem.hidesBackButton = NO;
        }else{
            NSLog(@"cant");
            UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
            backButton.frame = CGRectMake(0.0, 0.0, 60.0, 44.0);
            [backButton setImage:[UIImage imageNamed:@"backButton.png"] forState:UIControlStateNormal];
            [backButton addTarget:self action:@selector(goPop) forControlEvents:UIControlEventTouchUpInside];
            UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
            backBarButtonItem.style = UIBarButtonItemStylePlain;
            self.navigationItem.leftBarButtonItem = backBarButtonItem;
            self.navigationItem.hidesBackButton = NO;
        }
    }else{
        if(self.webView.canGoBack){
            NSLog(@"can");
            UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
            backButton.frame = CGRectMake(0.0, 0.0, 60.0, 44.0);
            [backButton setImage:[UIImage imageNamed:@"backButton.png"] forState:UIControlStateNormal];
            [backButton addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
            UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
            backBarButtonItem.style = UIBarButtonItemStylePlain;
            self.navigationItem.leftBarButtonItem = backBarButtonItem;
            self.navigationItem.hidesBackButton = NO;
        }else{
            NSLog(@"cant");
            self.navigationItem.hidesBackButton = YES;
        }
    }
    
    [self performSelector:@selector(performDismiss) withObject:nil afterDelay:1.0f];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString *requestString = [[request URL] absoluteString];
    NSArray *components = [requestString componentsSeparatedByString:@":"];
    if ([components count] > 0 && [(NSString *)[components objectAtIndex:0] isEqualToString:@"pinglun"]) {
        [self showModalPanel:[components objectAtIndex:1]];
        return NO;
    }else if([(NSString *)[components objectAtIndex:0] isEqualToString:@"addComment"]){
        [self.webView reload];
    }else if([(NSString *)[components objectAtIndex:0] isEqualToString:@"shoucang"]){
        NSLog(@"shoucang");
        [self shoucang:components];
    }else if([(NSString *)[components objectAtIndex:0] isEqualToString:@"longcomment"]){
        [self longComment:[components objectAtIndex:1]];
    }else if([(NSString *)[components objectAtIndex:0] isEqualToString:@"viewimages"]){
        [self viewImages:[components objectAtIndex:1]];
    }
    return YES;
}

- (void)viewImages:(id) fid{
    ImageViewController *imageViewController = [[ImageViewController alloc] init];
    [imageViewController setValue:fid forKey:@"data"];
    [self.navigationController pushViewController:imageViewController animated:YES];
    [imageViewController release];
}

- (void)longComment:(id) data{
    CommentTableViewController *commentVC = [[CommentTableViewController alloc] initWithNibName:@"CommentTableViewController" bundle:nil];
    [commentVC setValue:data forKey:@"data"];
    [self.navigationController pushViewController:commentVC animated:YES];
    [commentVC release];
}


- (void)shoucang:(NSArray *) components{
    
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
    NSString *createSQL = @"create table if not exists myfilm (row INTEGER PRIMARY KEY, fid text unique ,name varchar(255),performer varchar(255),url varchar(255), imgUrl varchar(255));";
    if(sqlite3_exec(database, [createSQL UTF8String],NULL,NULL,&errorMsg)!=SQLITE_OK)
    {
        sqlite3_close(database);
        NSAssert1(0,@"Error creating table: %s",errorMsg);
    }
    //NSMutableArray *persistentArray = [[NSMutableArray alloc] init];
    //[persistentArray addObject:fid];
    //for (int i = 0; i < [persistentArray count]; i++) {
    NSString *upDataSQL = [[NSString alloc] initWithFormat:@"insert or replace into myfilm (row,fid,name,performer,url,imgUrl) values (NULL,'%@','%@','%@','%@','%@');",[components objectAtIndex:1],[components objectAtIndex:2],[components objectAtIndex:3],[components objectAtIndex:4],[components objectAtIndex:5]];
    //char* errorMsg;
    if(sqlite3_exec(database,[upDataSQL UTF8String],NULL,NULL,&errorMsg)!= SQLITE_OK){
        sqlite3_close(database);
        NSAssert(0,@"Failed to open database");
    }
    //}
    //unarchive
    NSString *query = @"select * from myfilm order by row";//查找表中的数据
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

- (IBAction)showModalPanel:(id)sender {
	
	UAExampleModalPanel *modalPanel = [[[UAExampleModalPanel alloc] initWithFrame:self.view.bounds title:@"test" data:sender] autorelease];
    
	/////////////////////////////////
	// Randomly use the blocks method, delgate methods, or neither of them
	//int blocksDelegateOrNone = arc4random() % 3;
    int blocksDelegateOrNone = 0;
	
	
	////////////////////////
	// USE BLOCKS
	if (0 == blocksDelegateOrNone) {
		///////////////////////////////////////////
		// The block is responsible for closing the panel,
		//   either with -[UAModalPanel hide] or -[UAModalPanel hideWithOnComplete:]
		//   Panel is a reference to the modalPanel
		modalPanel.onClosePressed = ^(UAModalPanel* panel) {
			// [panel hide];
			[panel hideWithOnComplete:^(BOOL finished) {
				[panel removeFromSuperview];
                [webView reload];
			}];
		};
		
		UADebugLog(@"UAModalView will display using blocks: %@", modalPanel);
        
        ////////////////////////
        // USE DELEGATE
	} else if (1 == blocksDelegateOrNone) {
		///////////////////////////////////
		// Add self as the delegate so we know how to close the panel
		modalPanel.delegate = self;
		
		UADebugLog(@"UAModalView will display using delegate methods: %@", modalPanel);
        
        ////////////////////////
        // USE NOTHING
	} else {
		// no-op. No delegate or blocks
		UADebugLog(@"UAModalView will display without blocks or delegate methods: %@", modalPanel);
	}
	
	
	///////////////////////////////////
	// Add the panel to our view
	[self.view addSubview:modalPanel];
	
	///////////////////////////////////
	// Show the panel from the center of the button that was pressed
	[modalPanel showFromPoint:[self.view center]];
}

-(void)goBack
{
    [self.webView goBack];
}

-(void)goPop{
    [self.navigationController popViewControllerAnimated:YES];
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

@end
