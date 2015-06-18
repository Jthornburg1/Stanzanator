//
//  PoemByWriter.m
//  Stanzanator
//
//  Created by jonathan thornburg on 6/17/15.
//  Copyright (c) 2015 jonathan thornburg. All rights reserved.
//

#import "PoemByWriter.h"

@implementation PoemByWriter

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.title = dictionary[@"title"];
        self.bodyText = dictionary[@"bodyText"];
        self.timeStamp = dictionary[@"timestamp"];
    }
    return self;
}


@end
