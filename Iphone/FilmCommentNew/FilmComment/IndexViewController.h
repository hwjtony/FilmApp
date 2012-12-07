//
//  IndexViewController.h
//  FilmComment
//
//  Created by TonyKID on 12-12-3.
//  Copyright (c) 2012年 TonyKID. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SharedViewController.h"
#import "UAModalPanel.h"

@interface IndexViewController : SharedViewController{
    IBOutlet UIToolbar *toolBar;
    IBOutlet UIScrollView *scrollView;
    IBOutlet UITableView *tableView;
}



@property (strong, nonatomic) UIPopoverController *flipsidePopoverController;

@end
