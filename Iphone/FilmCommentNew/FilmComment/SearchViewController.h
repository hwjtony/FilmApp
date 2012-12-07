#import <UIKit/UIKit.h>

#import "Film.h"

@interface SearchViewController : UITableViewController <UISearchDisplayDelegate, UISearchBarDelegate>
{
	NSArray						*listContent;			// The master content.
	NSMutableArray				*filteredListContent;	// The content filtered as a result of a search.
	NSMutableData *receivedData;
	UISearchDisplayController	*searchDisplayController;
}

@property (nonatomic, retain) NSArray *listContent;
@property (nonatomic, retain) NSMutableArray *filteredListContent;
@property (nonatomic, retain) UISearchDisplayController	*searchDisplayController;
@property (nonatomic,retain) NSMutableData *receivedData;

@end
