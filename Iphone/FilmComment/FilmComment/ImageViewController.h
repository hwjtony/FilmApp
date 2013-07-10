//
//  ImageViewController.h
//  FilmComment
//
//  Created by TonyKID on 12-12-14.
//  Copyright (c) 2012年 TonyKID. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageCycleScrollView.h"


@interface ImageViewController : UIViewController<IXLCycleScrollViewDatasource,IXLCycleScrollViewDelegate>{
    NSMutableArray *imageArray;
    ImageCycleScrollView *csView;
    NSString *fid;
}

@property (retain) NSString *data;
@property (nonatomic,assign) NSMutableArray *imageArray;
@property (nonatomic,assign) NSString *fid;

@end
