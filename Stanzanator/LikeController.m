//
//  LikeController.m
//  Stanzanator
//
//  Created by jonathan thornburg on 7/9/15.
//  Copyright (c) 2015 jonathan thornburg. All rights reserved.
//

#import "LikeController.h"

@implementation LikeController

+ (instancetype)sharedInstance
{
    static LikeController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        sharedInstance = [[LikeController alloc] init];
    });
        return sharedInstance;
}

- (void)deleteLike
{
    
}

- (void)createLike
{
    
}

- (NSInteger)getLikesForPoem
{
    return 1;
}

- (NSArray *)getLikersForPoems
{
    NSArray *likers = [NSArray new];
    return likers;
}

@end
