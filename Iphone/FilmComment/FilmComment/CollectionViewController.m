//
//  CollectionViewController.m
//  FilmComment
//
//  Created by TonyKID on 12-12-11.
//  Copyright (c) 2012年 TonyKID. All rights reserved.
//

#import "CollectionViewController.h"
#import "ListViewController.h"

@interface CollectionViewController ()

@end

@implementation CollectionViewController

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
    
    ListViewController *listViewController1 = [[ListViewController alloc] initWithNibName:@"ListViewController" bundle:nil];
	ListViewController *listViewController2 = [[ListViewController alloc] initWithStyle:UITableViewStylePlain];
	ListViewController *listViewController3 = [[ListViewController alloc] initWithStyle:UITableViewStylePlain];
	
	listViewController1.title = @"Tab 1";
	listViewController2.title = @"Tab 2";
	listViewController3.title = @"Tab 3";
    
	NSArray *viewControllers = [NSArray arrayWithObjects:listViewController1, listViewController2, listViewController3, nil];
	MHTabBarController *tabBarController = [[MHTabBarController alloc] init];
    
	//tabBarController.delegate = self;
	tabBarController.viewControllers = viewControllers;
    
	// Uncomment this to select "Tab 2".
	//tabBarController.selectedIndex = 1;
    
	// Uncomment this to select "Tab 3".
	//tabBarController.selectedViewController = listViewController3;
	[self.navigationController pushViewController:tabBarController animated:YES];
    
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

@end
