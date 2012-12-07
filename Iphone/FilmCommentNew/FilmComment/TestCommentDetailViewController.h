//
//  TestCommentDetailViewController.h
//  FilmComment
//
//  Created by TonyKID on 12-12-4.
//  Copyright (c) 2012年 TonyKID. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TestCommentViewController;

@interface TestCommentDetailViewController : UIViewController {
    IBOutlet UILabel *textLabel;
    IBOutlet UIImageView *imageView;
    TestCommentViewController *parent;
    CGRect imageFrame;
}

@property (nonatomic, retain) UILabel *textLabel;
@property (nonatomic, retain) UIImageView *imageView;
@property (nonatomic, assign) TestCommentViewController *parent;
@property (nonatomic, assign) CGRect imageFrame;

@end
