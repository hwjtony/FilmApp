//
// DemoTableHeaderView.m
//
// @author Shiki
//

#import "DemoTableHeaderView.h"

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation DemoTableHeaderView

@synthesize title;
@synthesize activityIndicator;

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) awakeFromNib
{
  self.backgroundColor = [UIColor clearColor];
  [super awakeFromNib];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void) dealloc
{
  [title release];
  [activityIndicator release];
  [super dealloc];
}

@end