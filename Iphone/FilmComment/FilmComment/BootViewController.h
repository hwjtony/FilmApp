//
//  BootViewController.h
//  FilmComment
//
//  Created by TonyKID on 12-12-19.
//  Copyright (c) 2012年 TonyKID. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewIndexViewController.h"

@interface BootViewController : UIViewController {
    NSTimer *timer;
    UIImageView *splashImageView;
    NewIndexViewController *viewController;
}

@property(nonatomic,retain) NSTimer *timer;
@property(nonatomic,retain) UIImageView *splashImageView;
@property(nonatomic,retain) NewIndexViewController *viewController;

@end