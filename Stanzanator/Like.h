//
//  Like.h
//  Stanzanator
//
//  Created by jonathan thornburg on 7/9/15.
//  Copyright (c) 2015 jonathan thornburg. All rights reserved.
//

#import <Parse/Parse.h>
#import "Poem.h"

@interface Like : PFObject

//@property (strong, nonatomic) Poem *poem;
@property (nonatomic) BOOL isliked;
@property (strong, nonatomic) PFUser *liker;
@property (strong, nonatomic) Poem *liked;

@end
