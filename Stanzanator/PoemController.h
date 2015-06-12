//
//  PoemController.h
//  Stanzanator
//
//  Created by jonathan thornburg on 6/1/15.
//  Copyright (c) 2015 jonathan thornburg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Poem.h"

@interface PoemController : NSObject

@property (strong, nonatomic, readonly) NSArray *poems;
@property (strong, nonatomic) NSArray *writersPoems;

+ (instancetype)sharedInstance;
- (void)addPoemWithTitle:(NSString *)title bodyText:(NSString *)text date:(NSDate *)date;
- (void)removePoem:(Poem *)poem;
- (void)updatePoem:(Poem *)poem;
- (void)loadWritersPoemsFromParse;

-(void)getPoemsFromWriter:(void (^)(BOOL success))completion;



@end
