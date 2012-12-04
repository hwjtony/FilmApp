//
//  SharedViewController.m
//  FilmComment
//
//  Created by TonyKID on 12-11-30.
//  Copyright (c) 2012年 TonyKID. All rights reserved.
//

#import "SharedViewController.h"
#import "UAExampleModalPanel.h"
#import "UANoisyGradientBackground.h"
#import "UAGradientBackground.h"

@interface SharedViewController ()

@end

@implementation SharedViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void) performDismiss
{
    [loadView dismissWithClickedButtonIndex:0 animated:NO];
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    loadView = [[[UIAlertView alloc] initWithTitle:@"Please Wait" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles: nil] autorelease];
    [loadView show];
    
	// Create and add the activity indicator
	UIActivityIndicatorView *aiv = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
	aiv.center = CGPointMake(loadView.bounds.size.width / 2.0f, loadView.bounds.size.height - 40.0f);
	[aiv startAnimating];
	[loadView addSubview:aiv];
	[aiv release];
    
	// Auto dismiss after 3 seconds
	//[self performSelector:@selector(performDismiss) withObject:nil afterDelay:3.0f];
    NSLog(@"load");
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [self performSelector:@selector(performDismiss) withObject:nil afterDelay:1.0f];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString *requestString = [[request URL] absoluteString];
    NSArray *components = [requestString componentsSeparatedByString:@":"];
    if ([components count] > 0 && [(NSString *)[components objectAtIndex:0] isEqualToString:@"pinglun"]) {
        [self showModalPanel:[components objectAtIndex:1]];
        return NO;
    }else if([(NSString *)[components objectAtIndex:0] isEqualToString:@"addComment"]){
        [self->webView reload];
    }
    return YES;
}

- (IBAction)showModalPanel:(id)sender {
	
	UAExampleModalPanel *modalPanel = [[[UAExampleModalPanel alloc] initWithFrame:self.view.bounds title:@"test" data:sender] autorelease];
    
	/////////////////////////////////
	// Randomly use the blocks method, delgate methods, or neither of them
	//int blocksDelegateOrNone = arc4random() % 3;
    int blocksDelegateOrNone = 0;
	
	
	////////////////////////
	// USE BLOCKS
	if (0 == blocksDelegateOrNone) {
		///////////////////////////////////////////
		// The block is responsible for closing the panel,
		//   either with -[UAModalPanel hide] or -[UAModalPanel hideWithOnComplete:]
		//   Panel is a reference to the modalPanel
		modalPanel.onClosePressed = ^(UAModalPanel* panel) {
			// [panel hide];
			[panel hideWithOnComplete:^(BOOL finished) {
				[panel removeFromSuperview];
                [webView reload];
			}];
		};
		
		UADebugLog(@"UAModalView will display using blocks: %@", modalPanel);
        
        ////////////////////////
        // USE DELEGATE
	} else if (1 == blocksDelegateOrNone) {
		///////////////////////////////////
		// Add self as the delegate so we know how to close the panel
		modalPanel.delegate = self;
		
		UADebugLog(@"UAModalView will display using delegate methods: %@", modalPanel);
        
        ////////////////////////
        // USE NOTHING
	} else {
		// no-op. No delegate or blocks
		UADebugLog(@"UAModalView will display without blocks or delegate methods: %@", modalPanel);
	}
	
	
	///////////////////////////////////
	// Add the panel to our view
	[self.view addSubview:modalPanel];
	
	///////////////////////////////////
	// Show the panel from the center of the button that was pressed
	[modalPanel showFromPoint:[sender center]];
}

-(void)goBack
{
    [webView goBack];
}

@end
