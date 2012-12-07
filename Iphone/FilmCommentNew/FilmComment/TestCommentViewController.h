//
//  TestCommentViewController.h
//  FilmComment
//
//  Created by TonyKID on 12-12-4.
//  Copyright (c) 2012年 TonyKID. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STableViewController.h"

@interface TestCommentViewController : STableViewController {
    BOOL b;
    CGRect s_rc;
    int selectedRow;
    
    NSMutableArray				*typeListContent;			// The master content.
	NSMutableArray				*typeAddListContent;	// The content filtered as a result of a search.
	NSMutableData               *typeReceivedData;
    NSMutableArray *items;
}

@property (nonatomic, assign) BOOL b;

@property NSString *data;
@property (nonatomic, retain) NSMutableArray *typeListContent;
@property (nonatomic, retain) NSMutableArray *typeAddListContent;
@property (nonatomic, retain) NSMutableData *typeReceivedData;

@end
