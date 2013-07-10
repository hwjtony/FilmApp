//
//  Comment.h
//  FilmComment
//
//  Created by TonyKID on 12-12-4.
//  Copyright (c) 2012年 TonyKID. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Comment : NSObject {
    NSString *time;
    NSString *cid;
	NSString *name;
    NSString *content;
    NSString *title;
}

@property (nonatomic, copy) NSString *name, *content, *title, *cid, *time;

+ (id)commentWithName:(NSString *)name content:(NSString *)content title:(NSString *) title cid:(NSString *) cid time:(NSString *) time;

@end

