//
//  PoemController.h
//  Stanzanator
//
//  Created by jonathan thornburg on 6/1/15.
//  Copyright (c) 2015 jonathan thornburg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Poem.h"
#include "MainViewController.h"

@interface PoemController : NSObject

@property (strong, nonatomic) NSArray *poems;
@property (strong, nonatomic) NSArray *poemsByWriter;

+ (instancetype)sharedInstance;
- (Poem *)addPoemWithTitle:(NSString *)title bodyText:(NSString *)text date:(NSDate *)date private:(BOOL)privateSet;
- (void)removePoem:(Poem *)poem;
- (void)updatePoem:(Poem *)poem;
- (void)loadPoemsFromParse;
- (void)poemsByWriterSearch:(NSString *)writer withCompletion:(void (^)(NSArray *poems))completion;



-(void)writersPoemsforUser:(PFUser*)user;

- (void)poemsByWriter:(PFUser *)writer withCompletion:(void (^)(NSArray *poems))completion;

@end
