//
//  PoemController.m
//  Stanzanator
//
//  Created by jonathan thornburg on 6/1/15.
//  Copyright (c) 2015 jonathan thornburg. All rights reserved.
//

#import "PoemController.h"
#import "ProfileController.h"

@interface PoemController()

//@property (strong, nonatomic) NSArray *poems;

@end

@implementation PoemController

@synthesize poemsByWriter = _poemsByWriter;

+ (instancetype)sharedInstance
{
    static PoemController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        sharedInstance = [[PoemController alloc] init];
    });
        return sharedInstance;
}
- (void)loadPoemsFromParse
{
    PFQuery *query = [Poem query];
    
    // Without notifications to update the tableview we'll need to restart the app to get the tableview to load
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        NSMutableArray *array = [NSMutableArray new];
        NSEnumerator *enumerator = [objects reverseObjectEnumerator];
        for (id element in enumerator) {
            [array addObject:element];
        }
        self.poems = [array copy];
    }];
}
//- (NSArray *)poems
//{
//    PFQuery *query = [Poem query];
//    [query fromLocalDatastore];
//    return [query findObjects];
//}
- (Poem *)addPoemWithTitle:(NSString *)title bodyText:(NSString *)text date:(NSDate *)date private:(BOOL)privateSet
{
    Poem *poem = [Poem object];
    
    poem.title = title;
    poem.bodyText = text;
    poem.timestamp = date;
    poem.isPrivate = privateSet;
    
    
    [poem setObject:[PFUser currentUser] forKey:@"writersPoems"];
    poem.writerOfPoem = [PFUser currentUser];
    
    // [poem setObject:[PFUser currentUser] forKey:@"writersPoems"];
    //    [PFUser currentUser][@"Poems"] = poem;
    
    [poem pinInBackground];
    [poem saveInBackground];
    
    return poem;
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



- (void)poemsByWriter:(PFUser *)writer
       withCompletion:(void (^)(NSArray *poems))completion
{
 
    PFQuery *poemQuery = [Poem query];
    [poemQuery whereKey:@"writersPoems" equalTo:writer];
    [poemQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        NSMutableArray *array = [NSMutableArray new];
        NSEnumerator *enumerator = [objects reverseObjectEnumerator];
        for (id element in enumerator) {
            [array addObject:element];
        }
        
        self.poemsByWriter = [array copy];
        completion([array copy]);
    }];
}

- (void)poemsByWriterSearch:(NSString *)writer
       withCompletion:(void (^)(NSArray *poems))completion
{
    
    PFQuery *poemQuery = [Poem query];
    [poemQuery whereKey:@"writersPoems" containsString:writer];
    [poemQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        self.poemsByWriter = objects;
        completion(objects);
    }];
}


    

-(void)writersPoemsforUser:(PFUser*)user
{
    PFQuery *query = [Poem query];
    [query includeKey:@"writersPoems"];
    [query whereKey:@"writersPoems" equalTo:user];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        for (Poem *poem in objects) {
            user[@"Poems"] = poem;
            [user saveInBackground];
        }
    }];
}







@end
