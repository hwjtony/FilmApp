//
//  Comment.h
//  FilmComment
//
//  Created by TonyKID on 12-12-4.
//  Copyright (c) 2012年 TonyKID. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Comment : NSObject {
	NSString *name;
    NSString *content;
}

@property (nonatomic, copy) NSString *name, *content;

+ (id)commentWithName:(NSString *)name content:(NSString *)content;

@end

