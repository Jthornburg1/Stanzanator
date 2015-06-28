//
//  StanzaViewController.h
//  Stanzanator
//
//  Created by jonathan thornburg on 5/30/15.
//  Copyright (c) 2015 jonathan thornburg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Poem.h"
#import "PoemToReadViewController.h"
#import "ThesaurusTableViewController.h"

@interface StanzaViewController : UIViewController
@property (nonatomic, strong)Poem *updatePoem;

- (void)updateWithPoem:(Poem *)poem;

@end
