//
//  CommentDetailController.h
//  FilmComment
//
//  Created by TonyKID on 12-12-13.
//  Copyright (c) 2012年 TonyKID. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "sqlite3.h"
#define kFileName @"mydb1.sql"
@interface CommentDetailController : UIViewController{
    sqlite3 *database;
    BOOL loadingContent;
    UIAlertView *loadView;
    NSMutableData               *typeReceivedData;
}
@property (retain) NSString *cid;
@property (retain) NSString *time;
@property (retain) NSString *commentTitle;
@property (retain) NSString *name;
@property (retain) NSString *content;
@property (nonatomic, retain) NSMutableData *typeReceivedData;
@property BOOL loadingContent;

@end
