//
//  TypeViewController.m
//  FilmComment
//
//  Created by TonyKID on 12-12-3.
//  Copyright (c) 2012年 TonyKID. All rights reserved.
//

#import "TypeViewController.h"

@interface TypeViewController ()

@end

@implementation TypeViewController
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender

{
    NSLog(@"The segue id is %@", segue.identifier );
    UIViewController *destination = segue.destinationViewController;
    
    if ([destination respondsToSelector:@selector(setData:)])
    {
        [destination setValue:segue.identifier forKey:@"data"];
    }
}
@end
