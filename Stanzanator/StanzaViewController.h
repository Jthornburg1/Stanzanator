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

@interface StanzaViewController : UIViewController

- (void)updateWithPoem:(Poem *)poem;

@end
