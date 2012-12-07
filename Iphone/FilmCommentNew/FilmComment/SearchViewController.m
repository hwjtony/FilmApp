#import "SearchViewController.h"
#import "CJSONDeserializer.h"
#import "SharedViewController.h"

@implementation SearchViewController

@synthesize listContent, filteredListContent,searchDisplayController;

#pragma mark -
#pragma mark Lifecycle methods
- (id)initWithNibName:(NSString *)nibName bundle:(NSBundle *)nibBundle{
    self = [super initWithNibName:nibName bundle:nibBundle];
    if (self) {
		self.navigationController.navigationBarHidden = NO;
    }
    return self;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender

{
    NSLog(@"The segue id is %@", segue.identifier );
    UIViewController *destination = segue.destinationViewController;
    
    if ([destination respondsToSelector:@selector(setData:)])
    {
        [destination setValue:segue.identifier forKey:@"data"];
    }
}

- (void)viewDidLoad{
	self.filteredListContent = [[NSMutableArray alloc] init];
	
	UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch
																					target:self
																					action:@selector(searchBar:)];
	self.navigationItem.rightBarButtonItem = rightBarButton;
	
	UISearchBar *mySearchBar = [[UISearchBar alloc] init];
	mySearchBar.delegate = self;
	[mySearchBar setAutocapitalizationType:UITextAutocapitalizationTypeNone];
	[mySearchBar sizeToFit];
	self.tableView.tableHeaderView = mySearchBar;
	/*
	 fix the search bar width problem in landscape screen
	 */
	if (UIInterfaceOrientationLandscapeRight == [[UIDevice currentDevice] orientation] ||
		UIInterfaceOrientationLandscapeLeft == [[UIDevice currentDevice] orientation])
	{
		self.tableView.tableHeaderView.frame = CGRectMake(0.f, 0.f, 480.f, 44.f);
	}
	else
	{
		self.tableView.tableHeaderView.frame = CGRectMake(0.f, 0.f, 320.f, 44.f);
	}
	/*
	 set up the searchDisplayController programically
	 */
	searchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:mySearchBar contentsController:self];
	[self setSearchDisplayController:searchDisplayController];
	[searchDisplayController setDelegate:self];
	[searchDisplayController setSearchResultsDataSource:self];
    
	[mySearchBar release];
	
	[self.tableView reloadData];
	self.tableView.scrollEnabled = YES;
}

- (void)viewWillAppear:(BOOL)animated {
	/*
	 Hide the search bar
	 */
	[self.tableView setContentOffset:CGPointMake(0, 44.f) animated:NO];
	NSIndexPath *tableSelection = [self.tableView indexPathForSelectedRow];
	[self.tableView deselectRowAtIndexPath:tableSelection animated:NO];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

- (void)dealloc{
	[listContent release];
	[filteredListContent release];
	
	[super dealloc];
}

#pragma mark -
#pragma mark UITableView data source and delegate methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	if (tableView == self.searchDisplayController.searchResultsTableView)
	{
        return [self.filteredListContent count];
    }
	else
	{
        return [self.listContent count];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{//设置每行高度
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	static NSString *kCellID = @"cellID";
    Film *film = nil;
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellID];
	if (cell == nil)
	{
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kCellID] autorelease];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}
	if (tableView == self.searchDisplayController.searchResultsTableView)
	{
        film = [self.filteredListContent objectAtIndex:indexPath.row];
    }
	cell.imageView.image = film.img;
	cell.textLabel.text = film.name;
    cell.detailTextLabel.text = film.performer;
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SharedViewController *detailsViewController = [[SharedViewController alloc] init];
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height)];
    webView.delegate = detailsViewController;
	Film *film = nil;
	if (tableView == self.searchDisplayController.searchResultsTableView)
	{
        film = [self.filteredListContent objectAtIndex:indexPath.row];
        NSString *url = [NSString stringWithFormat:@"http://192.168.3.12/index.php?r=site/filmDetail&fid=%@",film.url];
        NSLog(@"%@",url);
        [webView loadRequest:[[NSURLRequest alloc] initWithURL:[[NSURL alloc] initWithString:url]]];
        [detailsViewController viewDidLoad];
        [detailsViewController.view addSubview:webView];
        [[self navigationController] pushViewController:detailsViewController animated:YES];
    }
	detailsViewController.title = film.name;
    //[[self navigationController] pushViewController:detailsViewController animated:YES];
    [detailsViewController release];
}



#pragma mark -
#pragma mark UISearchDisplayController Delegate Methods

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString{
    [self SearchData:searchString];
    return NO;
}

- (void)searchDisplayControllerDidBeginSearch:(UISearchDisplayController *)controller{
	/*
     Bob: Because the searchResultsTableView will be released and allocated automatically, so each time we start to begin search, we set its delegate here.
     */
	[self.searchDisplayController.searchResultsTableView setDelegate:self];
}

- (void)searchDisplayControllerDidEndSearch:(UISearchDisplayController *)controller{
	/*
	 Hide the search bar
	 */
	[self.searchDisplayController.searchResultsTableView setContentOffset:CGPointMake(0, 44.f) animated:YES];
}

#pragma mark -

-(void)searchBar:(id)sender{
	[searchDisplayController setActive:YES animated:YES];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    NSLog(@"pressed!");
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
}

-(void)SearchData:(NSString *)searchtext{
    NSString *urlString = [NSString stringWithFormat:@"http://192.168.3.12/index.php?r=site/IphoneSearch&search=%@",searchtext];
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding (kCFStringEncodingGB_18030_2000);
    NSString *strUrld8 = [urlString stringByAddingPercentEscapesUsingEncoding:enc];
    //调用http get请求方法
    [self sendRequestByGet:strUrld8];
}

//HTTP get请求方法
- (void)sendRequestByGet:(NSString*)urlString
{
    NSURL *url=[NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url
                                                                cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                            timeoutInterval:60];
    //设置请求方式为get
    [request setHTTPMethod:@"GET"];
    //添加用户会话id
    [request addValue:@"text/html" forHTTPHeaderField:@"Content-Type"];
    //连接发送请求
    self.receivedData=[[NSMutableData alloc] initWithData:nil];
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [request release];
    [conn release];
}
- (void)connection:(NSURLConnection *)aConn didReceiveResponse:(NSURLResponse *)response {
    
}
//接收NSData数据
- (void)connection:(NSURLConnection *)aConn didReceiveData:(NSData *)data {
    [self.receivedData appendData:data];
    NSLog(@"receiveData%@",nil);
}
- (void)connection:(NSURLConnection *)aConn didFailWithError:(NSError *)error{
    NSLog(@"fail");
}
//接收完毕,显示结果
- (void)connectionDidFinishLoading:(NSURLConnection *)aConn {
    NSData *data = [[NSData alloc]
                    initWithBytes:[self.receivedData bytes]
                    length:[self.receivedData length]];
    NSError *error;
    NSMutableDictionary *root = [[CJSONDeserializer deserializer] deserialize:data error:&error];
    
    NSLog(@"%@ %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
    NSMutableArray *picArray = [[NSMutableArray alloc] init];
    [self.filteredListContent removeAllObjects];// First clear the filtered array.
    for (NSMutableDictionary *picture in root) {
        NSString *name = [picture objectForKey:@"name"];
        NSString *surl = [picture objectForKey:@"url"];
        NSString *imgUrl = [picture objectForKey:@"imgUrl"];
        NSURL *url = [NSURL URLWithString:imgUrl];
        UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
        NSString *performer = [picture objectForKey:@"performer"];
        NSLog(@"imgUrl is %@",imgUrl);
        [self.filteredListContent addObject:[Film productWithUrl:surl name:name img:img performer:performer]];
        
    }
    [self.searchDisplayController.searchResultsTableView reloadData];
    [data release];
    [picArray release];
}

@end
