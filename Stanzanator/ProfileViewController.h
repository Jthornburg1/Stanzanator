//
//  ProfileViewController.h
//  Stanzanator
//
//  Created by jonathan thornburg on 5/30/15.
//  Copyright (c) 2015 jonathan thornburg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface ProfileViewController : UIViewController

- (void)updateProfileForNewUser:(PFUser *)user;
@property (nonatomic, strong)PFUser *userProfile;

@end
