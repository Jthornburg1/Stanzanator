//
//  Like.m
//  Stanzanator
//
//  Created by jonathan thornburg on 7/9/15.
//  Copyright (c) 2015 jonathan thornburg. All rights reserved.
//

#import "Like.h"

static NSString * const likeClassName = @"Like";


@implementation Like

@dynamic liker;
@dynamic liked;

+ (NSString *)parseClassName
{
    return likeClassName;
}

@end
