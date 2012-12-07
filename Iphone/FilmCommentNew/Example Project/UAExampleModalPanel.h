//
//  UAModalExampleView.h
//  UAModalPanel
//
//  Created by Matt Coneybeare on 1/8/12.
//  Copyright (c) 2012 Urban Apps. All rights reserved.
//

#import "UATitledModalPanel.h"

@interface UAExampleModalPanel : UAModalPanel <UITableViewDataSource> {
	UIView			*v;
	IBOutlet UIView	*viewLoadedFromXib;
}

@property (nonatomic, retain) IBOutlet UIView *viewLoadedFromXib;

- (id)initWithFrame:(CGRect)frame title:(NSString *)title data:(NSString *)data;
- (IBAction)buttonPressed:(id)sender;

@end
