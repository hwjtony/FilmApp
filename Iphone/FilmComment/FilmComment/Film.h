//
//  Film.h
//  FilmComment
//
//  Created by TonyKID on 12-12-3.
//  Copyright (c) 2012年 TonyKID. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Film : NSObject {
	NSString *url;
	NSString *name;
    NSString *performer;
    NSString *time;
    UIImage *img;
}

@property (nonatomic, copy) NSString *url, *name, *performer, *time;
@property (nonatomic, copy) UIImage *img;

+ (id)productWithUrl:(NSString *)url name:(NSString *)name img:(UIImage *)img performer:(NSString *)performer time:(NSString *)time;

@end

