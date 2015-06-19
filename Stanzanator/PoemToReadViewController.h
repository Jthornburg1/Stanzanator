//
//  PoemToReadViewController.h
//  Stanzanator
//
//  Created by jonathan thornburg on 6/2/15.
//  Copyright (c) 2015 jonathan thornburg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StanzaViewController.h"
#import "PoemController.h"

static NSString * const isPrivateNotification = @"isPrivateNotification";

@interface PoemToReadViewController : UIViewController



@property (nonatomic, strong) Poem *poem;

- (void)updateWithPoem:(Poem *)poem;


@end
