//
//  TypeViewController.m
//  FilmComment
//
//  Created by TonyKID on 12-12-3.
//  Copyright (c) 2012年 TonyKID. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "TypeViewController.h"
#import "FilmByTypeViewController.h"

@interface TypeViewController ()

@end

@implementation TypeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.items = [[NSArray alloc] initWithObjects:@"最新影片",@"评分最高",@"动作", @"科幻",@"喜剧",@"惊悚",@"悬疑", nil];
        //[self.navigationController setNavigationBarHidden:NO];
        UIBarButtonItem *temporaryBarButtonItem =[[UIBarButtonItem alloc] initWithTitle:@"X"
                                                                                  style:UIBarButtonItemStylePlain
                                                                                 target:self action:@selector(close)];
        self.navigationItem.rightBarButtonItem = temporaryBarButtonItem;
        self.navigationItem.hidesBackButton = YES;
    }
    return self;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{//设置每行高度
    return 80;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.items count]; // or self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Step 1: Check to see if we can reuse a cell from a row that has just rolled off the screen
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    // Step 2: If there are no cells to reuse, create a new one
    if(cell == nil) cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    
    // Add a detail view accessory
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    
    // Step 3: Set the cell text
    cell.textLabel.text = [self.items objectAtIndex:indexPath.row];
    NSLog(@"%@",cell.textLabel.text);
    // Step 4: Return the cell
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *type = [self.items objectAtIndex:indexPath.row];
    NSLog(@"type %@", type );
    FilmByTypeViewController *destinationViewController = [[[FilmByTypeViewController alloc] initWithNibName:@"FilmByTypeViewController" bundle:nil] autorelease];
    [destinationViewController setValue:type forKey:@"data"];
    [self.navigationController pushViewController:destinationViewController animated:YES];
    
    
    
}

-(void)close{
    
    
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.7];
    [animation setType: kCATransitionReveal];
    [animation setSubtype: kCATransitionFromBottom];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
    [self.navigationController.view.layer addAnimation:animation forKey:nil];
    [self.navigationController popToRootViewControllerAnimated:NO];
    
}
@end
