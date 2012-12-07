//
//  TestCommentDetailViewController.m
//  FilmComment
//
//  Created by TonyKID on 12-12-4.
//  Copyright (c) 2012年 TonyKID. All rights reserved.
//

#import "TestCommentDetailViewController.h"
#import "TestCommentViewController.h"

@interface TestCommentDetailViewController ()

@end

@implementation TestCommentDetailViewController

@synthesize textLabel;
@synthesize imageView;
@synthesize parent;
@synthesize imageFrame;

- (void)animationText
{
    [UIView animateWithDuration:.3
                          delay:0.0
                        options:UIViewAnimationCurveEaseIn
                     animations:^{
                         textLabel.alpha = 1;
                     } completion:nil];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self performSelector:@selector(animationText) withObject:nil afterDelay:.1f];
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:NO];
    
    parent.b = NO;
    
    [parent.tableView beginUpdates];
    [parent.tableView endUpdates];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imageView.hidden = NO;
    
    textLabel.alpha = 0;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"back"
                                                                             style:UIBarButtonItemStyleDone
                                                                            target:self
                                                                            action:@selector(back)];
    
    self.imageView.frame = imageFrame;
}


/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations.
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
    
    [textLabel release];
    [imageView release];
    [parent release];
    
}

@end
