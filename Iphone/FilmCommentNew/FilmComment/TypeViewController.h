//
//  TypeViewController.h
//  FilmComment
//
//  Created by TonyKID on 12-12-3.
//  Copyright (c) 2012年 TonyKID. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TypeViewController : UITableViewController{
    NSArray *items;
}

@property (nonatomic,retain) NSArray *items;
@property (nonatomic,retain) NSString *data;
@end
