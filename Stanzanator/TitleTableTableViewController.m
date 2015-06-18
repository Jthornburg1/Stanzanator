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

@interface TitleTableTableViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *allPoems;
@property (nonatomic, strong) NSMutableArray *writerPoems;
@property (nonatomic, strong) NSArray *allWriters;

@end

@implementation TitleTableTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[PoemController sharedInstance] loadPoemsFromParse];
    [[ProfileController sharedInstance]loadUsersFromParseWithCompletion:^(bool boolean) {
        
            [self.tableView reloadData];
        
    }];
}



-(void)viewWillAppear:(BOOL)animated{
    [self.tableView reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSInteger integer = [PoemController sharedInstance].poems.count;
    return integer;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    
    Poem *poem = [PoemController sharedInstance].poems[indexPath.row];
    cell.textLabel.text = poem.title;
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  
    PoemToReadViewController *viewController = [segue destinationViewController];
    
    NSIndexPath *path = [self.tableView indexPathForCell:sender];
    
    Poem *poem = [PoemController sharedInstance].poems[path.row];
    [viewController updateWithPoem:poem];
    
}


@end
