//
//  NewIndexViewController.h
//  FilmComment
//
//  Created by TonyKID on 12-12-5.
//  Copyright (c) 2012年 TonyKID. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "XLCycleScrollView.h"

@interface NewIndexViewController : UIViewController
<XLCycleScrollViewDatasource,XLCycleScrollViewDelegate>{
    XLCycleScrollView *csView;
    NSMutableData               *typeReceivedData;
    NSMutableArray				*films;
    UITextView *filmBrief;
    BOOL pageStillLoading;
}

@property (nonatomic, retain) NSMutableData *typeReceivedData;
@property (nonatomic, retain) NSMutableArray *films;
@property (nonatomic, retain) UITextView *filmBrief;
@property BOOL pageStillLoading;

@end
