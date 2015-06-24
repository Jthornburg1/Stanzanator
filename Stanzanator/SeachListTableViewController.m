//
//  SeachListTableViewController.m
//  Stanzanator
//
//  Created by jonathan thornburg on 6/23/15.
//  Copyright (c) 2015 jonathan thornburg. All rights reserved.
//

#import "SeachListTableViewController.h"
#import "Poem.h"
#import "PoemController.h"
#import "PoemToReadViewController.h"
#import "TitleTableTableViewController.h"

@interface SeachListTableViewController ()

@property (strong, nonatomic) TitleTableTableViewController *titleVC;

@end

@implementation SeachListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"showPoem" sender:nil];
}

//-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    TitleTableTableViewController *titleVC = [TitleTableTableViewController new];
//    
//        PoemToReadViewController *viewController = [segue destinationViewController];
//        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
//        Poem *poem = [PoemController sharedInstance].poems[indexPath.row];
//        [viewController updateWithPoem:poem];
//    
//}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    
    return self.searchResultsList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
    }
    
    Poem *poem = self.searchResultsList[indexPath.row];
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


@end
