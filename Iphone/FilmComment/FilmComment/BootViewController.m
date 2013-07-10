//
//  BootViewController.m
//  FilmComment
//
//  Created by TonyKID on 12-12-19.
//  Copyright (c) 2012年 TonyKID. All rights reserved.
//

#import "BootViewController.h"

@implementation BootViewController

@synthesize timer,splashImageView,viewController;
- (void)loadView {
    CGRect appFrame = [[UIScreen mainScreen] bounds];
    UIView *view = [[UIView alloc] initWithFrame:appFrame];
    //view.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIView AutoresizingFlexibleWidth;
    self.view = view;
    [view release];
    
    splashImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed: @"shoucang.png"]];
    splashImageView.frame = appFrame;
    [self.view addSubview:splashImageView];
    
    self.viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"newIndex"];
    self.viewController.view.alpha = 0.0;
    [self.view addSubview:self.viewController.view];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector: @selector(fadeScreen) userInfo:nil repeats:NO];
}

- (void)fadeScreen{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.75];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(finishedFading)];
    self.view.alpha = 0.0;
    [UIView commitAnimations];
}

- (void) finishedFading{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.75];
    self.view.alpha = 1.0;
    self.viewController.view.alpha = 1.0;
    [UIView commitAnimations];
    [splashImageView removeFromSuperview];
}

- (void)applicationDidFinishLaunching:(UIApplication *)application{
    //viewController = [[NewIndexViewController alloc] init];
    //[self presentModalViewController:viewController animated:YES];
    //[window addSubview:[viewController view]];
    //[window makeKeyAndVisible];
}

@end