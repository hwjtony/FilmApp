//
//  FilmByTypeViewController.h
//  FilmComment
//
//  Created by TonyKID on 12-12-3.
//  Copyright (c) 2012年 TonyKID. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Film.h"
#import "STableViewController.h"

@interface FilmByTypeViewController : STableViewController{
    NSMutableArray				*typeListContent;			// The master content.
	NSMutableArray				*typeAddListContent;	// The content filtered as a result of a search.
	NSMutableData               *typeReceivedData;
	UISearchDisplayController	*typeSearchDisplayController;
    NSMutableArray *items;
}

@property NSString *data;
@property (nonatomic, retain) NSMutableArray *typeListContent;
@property (nonatomic, retain) NSMutableArray *typeAddListContent;
@property (nonatomic, retain) UISearchDisplayController	*typeSearchDisplayController;
@property (nonatomic, retain) NSMutableData *typeReceivedData;

@end
