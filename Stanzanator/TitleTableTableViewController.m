//
//  TitleTableTableViewController.m
//  Stanzanator
//
//  Created by jonathan thornburg on 5/30/15.
//  Copyright (c) 2015 jonathan thornburg. All rights reserved.
//

#import "TitleTableTableViewController.h"
#import "Poem.h"
#import "PoemController.h"
#import "PoemToReadViewController.h"
#import "ProfileController.h"

@interface TitleTableTableViewController () <UITableViewDelegate>

@property (nonatomic, strong) NSArray *allPoems;
@property (nonatomic, strong) NSMutableArray *writerPoems;
@property (nonatomic, strong) NSArray *allWriters;

@end

@implementation TitleTableTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[PoemController sharedInstance] loadPoemsFromParse];
    [[ProfileController sharedInstance]loadUsersFromParseWithCompletion:^(bool boolean) {
        if (YES) {
            [self createUserPoemDictionary];
            [self.tableView reloadData];
        }
    }];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


-(void)createUserPoemDictionary {
    
    self.allPoems = [PoemController sharedInstance].poems;
    self.allWriters = [ProfileController sharedInstance].users;
    
    NSDictionary *userDictionary = [NSDictionary new];
    
    for (PFUser *user in self.allWriters){
        NSMutableArray *writersPoems = [NSMutableArray new];

        for (Poem *poem in self.allPoems){
            if (user == poem.writerOfPoem){
                [writersPoems addObject:poem];
            }
        }
        [userDictionary setValue:writersPoems forKey:[NSString stringWithFormat:@"%@",user]];
        [self.writerPoems addObject:userDictionary];
    }
}
-(void)viewWillAppear:(BOOL)animated{
    [self.tableView reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    
    return [ProfileController sharedInstance].users.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    
    PFUser *user = [ProfileController sharedInstance].users[section];
    self.writerPoems = user[@"Poem"];
    return [PoemController sharedInstance].poems.count;
    
//    return self.writerPoems.count;
//    NSArray *arrayOfPoems = user[@"Poems"];
    
//    [[PoemController sharedInstance] poemsByWriter:user withCompletion:^(NSArray *poems) {
//        self.writerPoems = poems;
//    }];
//    return self.writerPoems.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    PFUser *user = [ProfileController sharedInstance].users[indexPath.section];
    
    
    
    Poem *poem = [PoemController sharedInstance].poems[indexPath.row];
    cell.textLabel.text = poem.title;
    return cell;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [[ProfileController sharedInstance].users[section] username];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  
    PoemToReadViewController *viewController = [segue destinationViewController];
    
    NSIndexPath *path = [self.tableView indexPathForCell:sender];
    
    Poem *poem = [PoemController sharedInstance].poems[path.row];
    [viewController updateWithPoem:poem];
    
}


@end
