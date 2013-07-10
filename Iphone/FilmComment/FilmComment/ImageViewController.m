//
//  ImageViewController.m
//  FilmComment
//
//  Created by TonyKID on 12-12-14.
//  Copyright (c) 2012年 TonyKID. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "ImageViewController.h"

@interface ImageViewController ()

@end

@implementation ImageViewController

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
    imageArray = [[NSMutableArray alloc] initWithObjects:@"0",@"0",@"0",@"0",@"0",@"0",nil];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self.view setBackgroundColor:[UIColor blackColor]];
    // Do any additional setup after loading the view from its nib.
    csView = [[ImageCycleScrollView alloc] initWithFrame:self.view.bounds];
    csView.delegate = self;
    csView.datasource = self;
    [self.view addSubview:csView];
    //[self.navigationController setNavigationBarHidden:NO];
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0.0, 0.0, 35.0, 35.0);
    [backButton setImage:[UIImage imageNamed:@"closeButton.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    temporaryBarButtonItem.style = UIBarButtonItemStylePlain;
    self.navigationItem.rightBarButtonItem=temporaryBarButtonItem;
    [temporaryBarButtonItem release];
    [self.navigationController.navigationBar setTranslucent:YES];
    
    //back button
    /*UIBarButtonItem *back=[[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonSystemItemDone target:self action:@selector(doBack)];
    [self.navigationItem setHidesBackButton:YES];
    self.navigationItem.leftBarButtonItem=back;
    [back release];*/
    
    UIButton *bButton = [UIButton buttonWithType:UIButtonTypeCustom];
    bButton.frame = CGRectMake(0.0, 0.0, 60.0, 44.0);
    [bButton setImage:[UIImage imageNamed:@"backButton.png"] forState:UIControlStateNormal];
    [bButton addTarget:self action:@selector(doBack) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:bButton];
    backBarButtonItem.style = UIBarButtonItemStylePlain;
    self.navigationItem.leftBarButtonItem = backBarButtonItem;
    
    
    UIToolbar *toolBar = self.navigationController.toolbar;
    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    searchButton.frame = CGRectMake(253, 3.0, 70.0, 38.0);
    [searchButton setImage:[UIImage imageNamed:@"zoom.png"] forState:UIControlStateNormal];
    [searchButton addTarget:self action:@selector(zoom) forControlEvents:UIControlEventTouchUpInside];
    [toolBar addSubview:searchButton];
    
    //toolBar
    //UIToolbar *toolBar = self.navigationController.toolbar;
    UIButton *likeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    likeButton.frame = CGRectMake(181, 0.0, 67.0, 44.0);
    [likeButton setImage:[UIImage imageNamed:@"p4.png"] forState:UIControlStateNormal];
    [likeButton addTarget:self action:@selector(saveImage) forControlEvents:UIControlEventTouchUpInside];
    [toolBar addSubview:likeButton];
    
}

- (void)zoom{
    BOOL navBarState = [self.navigationController isNavigationBarHidden];
    BOOL toolBarState = [self.navigationController isToolbarHidden];
    //Set the navigationBarHidden to the opposite of the current state.
    [self.navigationController setNavigationBarHidden:!navBarState animated:YES];
    [self.navigationController setToolbarHidden:!toolBarState animated:YES];
}

- (void)saveImage{
    if ([imageArray objectAtIndex:csView.currentPage]!=@"0") {
        NSLog(@"cs curpage %d",csView.currentPage);
        UIImage *img = [imageArray objectAtIndex:csView.currentPage];
        UIImageWriteToSavedPhotosAlbum(img,nil,nil, nil);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"保存成功" message:@"图片已保存到您的相册" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        [alert release];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"保存失败" message:@"请等待图片加载完成后保存" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        [alert release];
    }
    
    NSLog(@"saveImage");
}

- (NSInteger)numberOfPages
{
    return 5;
}

- (UIView *)pageAtIndex:(NSInteger)index
{
    UIView *outside = [[[UIView alloc] initWithFrame:self.view.bounds] autorelease];
    NSString *imgUrl = [NSString stringWithFormat:@"http://192.168.1.11/Movie/images/imgs/big_stage/%@_%d_big.jpg",_data,index];
    NSLog(@"imgurl %@",imgUrl);
    NSURL *url = [NSURL URLWithString:imgUrl];
    UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
    if ([imageArray objectAtIndex:index]==@"0") {
        [imageArray replaceObjectAtIndex:index withObject:img];
        [csView setViewContent:img atIndex:index];
    }
    
    
    //[outside addSubview:buttomImg];
    return outside;
}

- (void)didClickPage:(ImageCycleScrollView *)csView atIndex:(NSInteger)index
{
    
    BOOL navBarState = [self.navigationController isNavigationBarHidden];
    BOOL toolBarState = [self.navigationController isToolbarHidden];
    //Set the navigationBarHidden to the opposite of the current state.
    [self.navigationController setNavigationBarHidden:!navBarState animated:YES];
    [self.navigationController setToolbarHidden:!toolBarState animated:YES];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)close{
    [self.navigationController.navigationBar setTranslucent:NO];
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
    [self.navigationController.navigationBar setTranslucent:NO];
    [self.navigationController setToolbarHidden:YES animated:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
