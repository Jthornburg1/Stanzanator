//
//  ThesaurusController.h
//  Stanzanator
//
//  Created by jonathan thornburg on 6/26/15.
//  Copyright (c) 2015 jonathan thornburg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ThesaurusController : NSObject

@property (strong, nonatomic) NSArray *thesaurusObjects;

+ (instancetype)sharedInstance;

- (void)synonymsForWords:(NSString *)word completion:(void (^)(BOOL success))completion;


@end
