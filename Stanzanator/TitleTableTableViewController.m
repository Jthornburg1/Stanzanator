//
//  TitleTableTableViewController.m
//  Stanzanator
//
//  Created by jonathan thornburg on 5/30/15.
//  Copyright (c) 2015 jonathan thornburg. All rights reserved.
//

#import "TitleTableTableViewController.h"
#import "PoemController.h"
#import "PoemToReadViewController.h"
#import "ProfileController.h"
#import "ProfileViewController.h"

@interface TitleTableTableViewController () <UITableViewDelegate, UITableViewDataSource>


@end

@implementation TitleTableTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[PoemController sharedInstance] loadPoemsFromParse];
    [[ProfileController sharedInstance]loadUsersFromParseWithCompletion:^(bool boolean) {
        
            [self.tableView reloadData];
        
    }];
    self.poem.isPrivate = NO;
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
    PFUser *user = poem.writerOfPoem;
    
    cell.textLabel.text = poem.title;
    
    if (poem.isPrivate) {
        cell.detailTextLabel.text = @"private";
        if (poem.writerOfPoem == [PFUser currentUser]) {
            cell.userInteractionEnabled = YES;
        } else {
            cell.userInteractionEnabled = NO;
        }
    } else {
        cell.detailTextLabel.text = user[@"username"];
        cell.userInteractionEnabled = YES;
    }
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"showProfile" sender:[tableView cellForRowAtIndexPath:indexPath]];
    
    
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"showProfile"]) {
        ProfileViewController *profileViewController = segue.destinationViewController;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        Poem *poem = [PoemController sharedInstance].poems[indexPath.row];
        PFUser *user = poem.writerOfPoem;
        profileViewController.userProfile = user;
    } else {
                PoemToReadViewController *viewController = [segue destinationViewController];
        
                NSIndexPath *path = [self.tableView indexPathForCell:sender];
    
                Poem *poem = [PoemController sharedInstance].poems[path.row];
    
                [viewController updateWithPoem:poem];
    }
//    NSIndexPath *indexPath = [NSIndexPath new];
//    if ([PoemController sharedInstance].poems[indexPath.row].isPrivate == YES) {
//        //here is where either an alert is sprung and no segue is permitted or the detailTextLabel.text is changed to private and no segue is permitted.
//        NSLog(@"PRIVATE");
//    } // or segue is performed.
}


@end
