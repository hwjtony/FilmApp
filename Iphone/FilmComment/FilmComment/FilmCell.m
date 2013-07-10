//
//  FilmCell.m
//  FilmComment
//
//  Created by TonyKID on 12-12-21.
//  Copyright (c) 2012年 TonyKID. All rights reserved.
//

#import "FilmCell.h"

@implementation FilmCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setTheImage:(UIImage *)icon{
    
    imageView = [[UIImageView alloc]initWithImage:icon];
    imageView.frame = CGRectMake(0, 0, 320, 45);
    [self.contentView addSubview:imageView];
    
    
}

@end
