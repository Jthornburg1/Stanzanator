//
//  Poem.m
//  Stanzanator
//
//  Created by jonathan thornburg on 6/1/15.
//  Copyright (c) 2015 jonathan thornburg. All rights reserved.
//

#import "Poem.h"

static NSString * const poemClassName = @"Poem";

@implementation Poem

@dynamic title;
@dynamic bodyText;
@dynamic timestamp;
//@dynamic writerOfPoem;

+ (NSString *)parseClassName
{
    return poemClassName;
}

@end
