//
//  ProfileController.m
//  Stanzanator
//
//  Created by jonathan thornburg on 6/1/15.
//  Copyright (c) 2015 jonathan thornburg. All rights reserved.
//

#import "ProfileController.h"
#import "PoemController.h"

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

- (void)loadUsersFromParseWithCompletion:(void (^)(bool boolean))completion
{
    PFQuery *query = [PFUser query];
    [query includeKey:@"Poems"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        self.users = objects;
        completion(YES);
    }];
    
}


@end
