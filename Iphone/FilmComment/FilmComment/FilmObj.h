//
//  FilmObj.h
//  FilmComment
//
//  Created by TonyKID on 12-12-6.
//  Copyright (c) 2012年 TonyKID. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FilmObj : NSObject {
	NSString *url;
	NSString *name;
    NSString *introduce;
    NSString *imgUrl;
    NSString *score;
}

@property (nonatomic, copy) NSString *url, *name, *introduce, *imgUrl, *score;

+ (id)productWithUrl:(NSString *)url name:(NSString *)name img:(NSString *)imgUrl introduce:(NSString *)introduce score:(NSString *)score;

@end
