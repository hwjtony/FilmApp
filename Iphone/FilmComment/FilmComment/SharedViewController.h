//
//  SharedViewController.h
//  FilmComment
//
//  Created by TonyKID on 12-11-30.
//  Copyright (c) 2012年 TonyKID. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UAModalPanel.h"

@interface SharedViewController : UIViewController <UIWebViewDelegate,UIPopoverControllerDelegate,UAModalPanelDelegate>{
    UIAlertView *loadView;
    UIWebView *webView;
}

-(IBAction)showModalPanel:(id)sender;

@end
