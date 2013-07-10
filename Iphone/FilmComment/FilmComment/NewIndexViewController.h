//
//  NewIndexViewController.h
//  FilmComment
//
//  Created by TonyKID on 12-12-5.
//  Copyright (c) 2012年 TonyKID. All rights reserved.
//
#include "sqlite3.h"
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "XLCycleScrollView.h"
#import "MHTabBarController.h"
#define kFileName @"mydb.sql"

@interface NewIndexViewController : UIViewController
<XLCycleScrollViewDatasource,XLCycleScrollViewDelegate>{
    XLCycleScrollView *csView;
    NSMutableData               *typeReceivedData;
    NSMutableArray				*films;
    NSMutableArray *contentArray;
    UITextView *filmBrief;
    BOOL pageStillLoading;
    
    sqlite3 *database;
}

@property (nonatomic, retain) NSMutableData *typeReceivedData;
@property (nonatomic, retain) NSMutableArray *films;
@property (nonatomic,assign) NSMutableArray *contentArray;
@property (nonatomic, retain) UITextView *filmBrief;
@property BOOL pageStillLoading;

@end
