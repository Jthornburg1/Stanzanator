//
//  Poem.h
//  Stanzanator
//
//  Created by jonathan thornburg on 6/1/15.
//  Copyright (c) 2015 jonathan thornburg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Poem : NSObject

@property (strong, nonatomic, readonly) NSString *title;
@property (strong, nonatomic, readonly) NSString *bodyText;
@property (strong, nonatomic) NSDate *timestamp;

@end
