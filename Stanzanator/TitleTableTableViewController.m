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
#import "SeachListTableViewController.h"

@interface TitleTableTableViewController () <UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating, UISearchBarDelegate>

@property (strong, nonatomic) UISearchController *searchController;
@property (strong, nonatomic) NSArray *filteredSearchResults;
@property (strong, nonatomic) NSPredicate *searchPredicate;
@property (strong, nonatomic) SeachListTableViewController *filteredTableViewController;


@end

@implementation TitleTableTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[PoemController sharedInstance] loadPoemsFromParse];
    [[ProfileController sharedInstance]loadUsersFromParseWithCompletion:^(bool boolean) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
    
    self.filteredTableViewController = [SeachListTableViewController new];
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:self.filteredTableViewController];
    self.searchController.searchResultsUpdater = self;
    self.searchController.dimsBackgroundDuringPresentation = NO;
    self.searchController.searchBar.scopeButtonTitles = @[@"Title",@"Username"];
    
    self.searchController.searchBar.delegate = self;
    // self should be the delegate for the filtered table so DidSelectRowAtIndexPath is called for both tables 
    self.filteredTableViewController.tableView.delegate = self;
    
    self.tableView.tableHeaderView = self.searchController.searchBar;
    self.definesPresentationContext = YES;
    [self.searchController.searchBar sizeToFit];
}



-(void)viewWillAppear:(BOOL)animated{
    [self.tableView reloadData];
}

# pragma mark - SearchController Methods


- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    NSString *searchString = searchController.searchBar.text;
    [self searchForText:searchString scope:searchController.searchBar.selectedScopeButtonIndex];
    [self.filteredTableViewController.tableView reloadData];
}

- (void)searchForText:(NSString *)searchText scope:(NSInteger)scopeOption
{
    NSString *predicateFormat = @"%K CONTAINS[cd] %@";
    NSString *searchAtrribute = @"title";
    
    if (scopeOption == 1) {
        searchAtrribute = @"writersOfPoem.@userName";
    }
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:predicateFormat, searchAtrribute, searchText];
    
    self.filteredSearchResults = [[PoemController sharedInstance].poems filteredArrayUsingPredicate:predicate];
    self.filteredTableViewController.searchResultsList = self.filteredSearchResults;
    
    NSLog(@"~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
    
    for (Poem *poem in self.filteredSearchResults) {
        
        NSLog(@"%@", poem.title);
    }
}

#pragma mark - UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}

/*
- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope
{
}
 */


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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.filteredTableViewController.tableView) {
        [self performSegueWithIdentifier:@"showPoem" sender:self.filteredTableViewController.tableView];
    }
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
    
        Poem *poem;
        
        if (sender == self.filteredTableViewController.tableView) {
            NSIndexPath *path = [sender indexPathForSelectedRow];

            //filtered tableview tapped
            poem = self.filteredSearchResults[path.row];
        }
        else
        {//regular table view
            poem = [PoemController sharedInstance].poems[path.row];
        }
        [viewController updateWithPoem:poem];
    }

}


@end
