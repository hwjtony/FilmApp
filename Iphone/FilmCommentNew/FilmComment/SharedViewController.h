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
    bool return_flag;
}

-(IBAction)showModalPanel:(id)sender;
@property (nonatomic,retain) UIWebView *webView;
@property (nonatomic) bool return_flag;


@end
