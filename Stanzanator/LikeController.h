//
//  LikeController.h
//  Stanzanator
//
//  Created by jonathan thornburg on 7/9/15.
//  Copyright (c) 2015 jonathan thornburg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Like.h"

@interface LikeController : NSObject

@property (strong, nonatomic) Like *isLiked;

+ (instancetype)sharedInstance;

- (void)createLike;
- (void)deleteLike;
- (NSInteger)getLikesForPoem;
- (NSArray *)getLikersForPoems;


@end
