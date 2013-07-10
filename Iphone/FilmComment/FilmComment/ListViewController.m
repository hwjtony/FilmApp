//
// DemoTableViewController.m
//
// @author Shiki
//


#import "ListViewController.h"
#import "DemoTableHeaderView.h"
#import "DemoTableFooterView.h"
#import "SharedViewController.h"

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
@interface ListViewController ()
// Private helper methods
- (void) addItemsOnTop;
- (void) addItemsOnBottom;
- (NSString *) createRandomValue;
@end

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation ListViewController

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"listview");
    //self.fidList = [[NSMutableArray alloc] init];
    self.filmListContent = [[NSMutableArray alloc] init];
    //self.title = _data;
    self.canLoadMore = YES;
    //[self.tableView setBackgroundColor:[UIColor lightGrayColor]];
    
    // set the custom view for "pull to refresh". See DemoTableHeaderView.xib.
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"DemoTableHeaderView" owner:self options:nil];
    DemoTableHeaderView *headerView = (DemoTableHeaderView *)[nib objectAtIndex:0];
    self.headerView = headerView;
    
    // set the custom view for "load more". See DemoTableFooterView.xib.
    nib = [[NSBundle mainBundle] loadNibNamed:@"DemoTableFooterView" owner:self options:nil];
    DemoTableFooterView *footerView = (DemoTableFooterView *)[nib objectAtIndex:0];
    self.footerView = footerView;
    
    //[self loadMore];
    
    
    self.title = @"STableViewController Demo";
    //[self.tableView setBackgroundColor:[UIColor lightGrayColor]];
    
    
    // add sample items
    filmItems = [[NSMutableArray alloc] init];
    offset = 0;
    [self loadMore];
    
}

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Pull to Refresh

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) pinHeaderView
{
    [super pinHeaderView];
    
    // do custom handling for the header view
    DemoTableHeaderView *hv = (DemoTableHeaderView *)self.headerView;
    [hv.activityIndicator startAnimating];
    hv.title.text = @"Loading...";
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) unpinHeaderView
{
    [super unpinHeaderView];
    
    // do custom handling for the header view
    [[(DemoTableHeaderView *)self.headerView activityIndicator] stopAnimating];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Update the header text while the user is dragging
//
- (void) headerViewDidScroll:(BOOL)willRefreshOnRelease scrollView:(UIScrollView *)scrollView
{
    DemoTableHeaderView *hv = (DemoTableHeaderView *)self.headerView;
    if (willRefreshOnRelease)
        hv.title.text = @"Release to refresh...";
    else
        hv.title.text = @"Pull down to refresh...";
}

////////////////////////////////////////////////////////////////////////////////////////////////////
//
// refresh the list. Do your async calls here.
//
- (BOOL) refresh
{
    if (![super refresh])
        return NO;
    
    // Do your async call here
    // This is just a dummy data loader:
    [self performSelector:@selector(addItemsOnTop) withObject:nil afterDelay:2.0];
    // See -addItemsOnTop for more info on how to finish loading
    return YES;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Load More

////////////////////////////////////////////////////////////////////////////////////////////////////
//
// The method -loadMore was called and will begin fetching data for the next page (more).
// Do custom handling of -footerView if you need to.
//
- (void) willBeginLoadingMore
{
    DemoTableFooterView *fv = (DemoTableFooterView *)self.footerView;
    [fv.activityIndicator startAnimating];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Do UI handling after the "load more" process was completed. In this example, -footerView will
// show a "No more items to load" text.
//
- (void) loadMoreCompleted
{
    [super loadMoreCompleted];
    
    DemoTableFooterView *fv = (DemoTableFooterView *)self.footerView;
    [fv.activityIndicator stopAnimating];
    
    if (!self.canLoadMore) {
        // Do something if there are no more items to load
        
        // We can hide the footerView by: [self setFooterViewVisibility:NO];
        
        // Just show a textual info that there are no more items to load
        fv.infoLabel.hidden = NO;
    }
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL) loadMore
{
    if (![super loadMore])
        return NO;
    
    // Do your async loading here
    [self performSelector:@selector(addItemsOnBottom) withObject:nil afterDelay:2.0];
    // See -addItemsOnBottom for more info on what to do after loading more items
    
    return YES;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Dummy data methods

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) addItemsOnTop
{
    for (int i = 0; i < 3; i++)
        [filmItems insertObject:[self createRandomValue] atIndex:0];
    [self.tableView reloadData];
    
    // Call this to indicate that we have finished "refreshing".
    // This will then result in the headerView being unpinned (-unpinHeaderView will be called).
    [self refreshCompleted];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) addItemsOnBottom
{
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *paths = [[path objectAtIndex:0] stringByAppendingPathComponent:kFileName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL findFile = [fileManager fileExistsAtPath:paths];
    NSLog(@"Database file path = %@",paths);
    if(findFile)
    {
        NSLog(@"Database file have already existed.");
        
        if(sqlite3_open([paths UTF8String], &database) != SQLITE_OK)//打开数据库失败
        {
            sqlite3_close(database);
            NSAssert(0,@"Failed to open database");
        }
    }else{
        NSLog(@"Database file does not exsit!");
        if(sqlite3_open([paths UTF8String], &database) != SQLITE_OK)//打开数据库失败
        {
            sqlite3_close(database);
            NSAssert(0,@"Failed to open database");
        }
    }
    //if (_data == @"电影") {
        NSString *query = [[NSString alloc] initWithFormat:@"%@%d%@",@"select * from myfilm order by row desc limit ",offset,@",5"];
        sqlite3_stmt *statement;
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil)
           == SQLITE_OK)
        {
            int count = 0;
            while(sqlite3_step(statement) == SQLITE_ROW)
            {
                int row = sqlite3_column_int(statement, 0);
                char *rowData  = (char *)sqlite3_column_text(statement, 1);
                char *rowData1 = (char *)sqlite3_column_text(statement, 2);
                char *rowData2 = (char *)sqlite3_column_text(statement, 3);
                char *rowData3 = (char *)sqlite3_column_text(statement, 4);
                char *rowData4 = (char *)sqlite3_column_text(statement, 5);
                
                NSString *fieldName   = [[NSString alloc] initWithFormat:@"show%d",row];
                NSString *fieldValue  = [[NSString alloc] initWithUTF8String:rowData];
                NSString *fieldValue1 = [[NSString alloc] initWithUTF8String:rowData1];
                NSString *fieldValue2 = [[NSString alloc] initWithUTF8String:rowData2];
                NSString *fieldValue3 = [[NSString alloc] initWithUTF8String:rowData3];
                NSString *fieldValue4 = [[NSString alloc] initWithUTF8String:rowData4];
                
                //NSLog(@"fieldName is :%@,fieldValue is :%@",fieldName,fieldValue);
                NSMutableArray *temp = [[NSMutableArray alloc] initWithObjects:fieldName,fieldValue,fieldValue1,fieldValue2,fieldValue3,fieldValue4, nil];
                [filmItems addObject:temp];
                count++;
                offset++;
                
                [temp release];
                [fieldName release];
                [fieldValue release];
            }
            if (count!=5) {
                self.canLoadMore = NO;
            }
            sqlite3_finalize(statement);
        //}
    }
    
    
    [self.tableView reloadData];
    
    if (filmItems.count > 50)
        self.canLoadMore = NO; // signal that there won't be any more items to load
    //else
    //    self.canLoadMore = YES;
    
    // Inform STableViewController that we have finished loading more items
    [self loadMoreCompleted];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{//设置每行高度
    return 80;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString *) createRandomValue
{
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
    
    return [NSString stringWithFormat:@"%@ %@", [dateFormatter stringFromDate:[NSDate date]],
            [NSNumber numberWithInt:rand()]];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Standard TableView delegates

////////////////////////////////////////////////////////////////////////////////////////////////////
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"%d",filmItems.count);
    return filmItems.count;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *kCellID = @"cellID";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellID];
    
	if (cell == nil)
	{
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kCellID] autorelease];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}
	NSMutableArray *temp = [filmItems objectAtIndex:indexPath.row];
    
    NSString *name = [temp objectAtIndex:2];
    name = [name stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *imgUrl = [[NSString alloc] initWithFormat:@"%@%@",@"http://192.168.1.11/Movie/images/imgs/small_icon/",[temp objectAtIndex:5]];
    NSURL *url = [NSURL URLWithString:imgUrl];
    UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
    NSString *performer = [temp objectAtIndex:3];
    performer = [performer stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    cell.imageView.image = img;
	cell.textLabel.text = name;
    cell.detailTextLabel.text = performer;
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SharedViewController *detailsViewController = [[SharedViewController alloc] init];
    detailsViewController.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height+44)];//加上tabbar的高度
    detailsViewController.webView.delegate = detailsViewController;
    NSLog(@"selectrow");
    NSMutableArray *temp = [filmItems objectAtIndex:indexPath.row];
    NSString *url = [[NSString alloc]  initWithFormat:@"%@%@",@"http://192.168.1.11/Movie/index.php?r=site/filmDetailIphone&fid=",[temp objectAtIndex:4]];
    NSLog(@"%@",url);
    [detailsViewController.webView loadRequest:[[NSURLRequest alloc] initWithURL:[[NSURL alloc] initWithString:url]]];
    [detailsViewController viewDidLoad];
    [detailsViewController.view addSubview:detailsViewController.webView];
    detailsViewController.return_flag = YES;
    [[self navigationController] pushViewController:detailsViewController animated:YES];
    
	
	detailsViewController.title = [temp objectAtIndex:2];
    
    //[[self navigationController] pushViewController:detailsViewController animated:YES];
    [detailsViewController release];
}

- (void)tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSUInteger row = [indexPath row];
    
    NSMutableArray *temp = [filmItems objectAtIndex:row];
    
    NSLog(@"row %d",row);
    NSString *fid = [temp objectAtIndex:1];
    [self deleteCollectedFilm:fid];
    offset--;
    [filmItems removeObjectAtIndex:row];
    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                     withRowAnimation:UITableViewRowAnimationAutomatic];
    
    
    
}

- (void)deleteCollectedFilm:(NSString *)fid{
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *paths = [[path objectAtIndex:0] stringByAppendingPathComponent:kFileName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL findFile = [fileManager fileExistsAtPath:paths];
    NSLog(@"Database file path = %@",paths);
    if(findFile)
    {
        NSLog(@"Database file have already existed.");
        
        if(sqlite3_open([paths UTF8String], &database) != SQLITE_OK)//打开数据库失败
        {
            sqlite3_close(database);
            NSAssert(0,@"Failed to open database");
        }
    }else{
        NSLog(@"Database file does not exsit!");
        if(sqlite3_open([paths UTF8String], &database) != SQLITE_OK)//打开数据库失败
        {
            sqlite3_close(database);
            NSAssert(0,@"Failed to open database");
        }
    }
    char* errorMsg;
    NSString *deleteSQL = [NSString stringWithFormat:@"%@'%@';",@"delete from myfilm where fid = ",fid] ;
    NSLog(@"%@",deleteSQL);
    if(sqlite3_exec(database, [deleteSQL UTF8String],NULL,NULL,&errorMsg)!=SQLITE_OK)
    {
        sqlite3_close(database);
        NSAssert1(0,@"Error deleting table: %s",errorMsg);
    }
}
@end
