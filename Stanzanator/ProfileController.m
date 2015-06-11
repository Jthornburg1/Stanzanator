//
//  ProfileController.m
//  Stanzanator
//
//  Created by jonathan thornburg on 6/1/15.
//  Copyright (c) 2015 jonathan thornburg. All rights reserved.
//

#import "ProfileController.h"

@implementation ProfileController

+ (instancetype)sharedInstance
{
    static ProfileController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        sharedInstance = [[ProfileController alloc] init];
    });
        return sharedInstance;
}

- (void)loadUsersFromParse
{
    PFQuery *query = [PFUser query];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        self.users = objects;
    }];
}
@end
