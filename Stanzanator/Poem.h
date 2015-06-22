//
//  Poem.h
//  Stanzanator
//
//  Created by jonathan thornburg on 6/1/15.
//  Copyright (c) 2015 jonathan thornburg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface Poem : PFObject <PFSubclassing>

@property (retain, nonatomic) NSString *title;
@property (retain, nonatomic) NSString *bodyText;
@property (retain, nonatomic) NSDate *timestamp;
@property (strong, nonatomic) PFUser *writerOfPoem;
@property (nonatomic) BOOL isPrivate;

+ (NSString *)parseClassName;


@end
