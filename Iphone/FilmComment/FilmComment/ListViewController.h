#import <UIKit/UIKit.h>
#import "STableViewController.h"
#import "sqlite3.h"
#define kFileName @"mydb1.sql"

@interface ListViewController : STableViewController {
    NSMutableArray              *filmItems;
    NSMutableArray				*filmListContent;
    int                         offset;
    sqlite3                     *database;
}

@property (retain)NSString *data;
@property (nonatomic, retain) NSMutableArray *filmListContent;

@end