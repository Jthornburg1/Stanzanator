//
//  PoemController.m
//  Stanzanator
//
//  Created by jonathan thornburg on 6/1/15.
//  Copyright (c) 2015 jonathan thornburg. All rights reserved.
//

#import "PoemController.h"

@interface PoemController()

@property (strong, nonatomic) NSArray *poems;

@end

@implementation PoemController

@synthesize writersPoems = _writersPoems;

+ (instancetype)sharedInstance
{
    static PoemController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        sharedInstance = [[PoemController alloc] init];
        [sharedInstance loadPoemsFromParse];
    });
        return sharedInstance;
}
- (void)loadPoemsFromParse
{
    PFQuery *query = [Poem query];
    
    // Without notifications to update the tableview we'll need to restart the app to get the tableview to load
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        for (Poem *poem in objects) {
            [poem pin];
        }
    }];
}
- (NSArray *)poems
{
    PFQuery *query = [Poem query];
    [query fromLocalDatastore];
    return [query findObjects];
}
- (void)addPoemWithTitle:(NSString *)title bodyText:(NSString *)text date:(NSDate *)date
{
    Poem *poem = [Poem object];
    
    poem.title = title;
    poem.bodyText = text;
    poem.timestamp = date;
    //poem.writerOfPoem = [PFUser currentUser];
    [poem setObject:[PFUser currentUser] forKey:@"writersPoems"];
    
    [poem pinInBackground];
    [poem saveInBackground];
}
- (void)removePoem:(Poem *)poem
{
    [poem unpinInBackground];
    [poem deleteInBackground];
}
- (void)updatePoem:(Poem *)poem
{
    [poem pinInBackground];
    [poem save];
}

-(void)getPoemsFromWriter:(void (^)(BOOL success))completion
{
    PFQuery *query = [Poem query];
    
    [query whereKey:@"writersPoems" equalTo:[PFUser currentUser]];
    
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        self.writersPoems = objects;
        completion(YES);
    }];
    
    
}

-(void)writersPoemsforUser:(PFUser*)user completion:(void (^)(NSArray *poems))completion

{
    PFQuery *query = [PFQuery new];
    [query whereKey:@"writersPoem" equalTo:user];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
    
        completion(objects);
    }];
}

@end
