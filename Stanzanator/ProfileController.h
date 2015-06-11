//
//  ProfileController.h
//  Stanzanator
//
//  Created by jonathan thornburg on 6/1/15.
//  Copyright (c) 2015 jonathan thornburg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface ProfileController : NSObject

@property (strong, nonatomic) NSArray *users;

+ (instancetype)sharedInstance;
- (void)loadUsersFromParse;



@end
