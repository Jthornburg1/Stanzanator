//
//  ThesaurusTableViewController.m
//  Stanzanator
//
//  Created by jonathan thornburg on 6/23/15.
//  Copyright (c) 2015 jonathan thornburg. All rights reserved.
//

#import "ThesaurusTableViewController.h"


@interface ThesaurusTableViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *thesaurusTextField;

@end

@implementation ThesaurusTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [ThesaurusController sharedInstance].thesaurusObjects = 0;
    [self.tableView reloadData];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [ThesaurusController sharedInstance].thesaurusObjects.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return ((Thesaurus *)[ThesaurusController sharedInstance].thesaurusObjects[section]).synonymn.count
    +      ((Thesaurus *)[ThesaurusController sharedInstance].thesaurusObjects[section]).antonym.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"thesaurusCell"];
    
    Thesaurus *thesaurus = [ThesaurusController sharedInstance].thesaurusObjects[indexPath.section];
    
    if (indexPath.row >= thesaurus.synonymn.count) {
        cell.textLabel.text = [NSString stringWithFormat:@"%@ - ant", thesaurus.antonym[indexPath.row - thesaurus.synonymn.count]];
    } else {
        cell.textLabel.text = thesaurus.synonymn[indexPath.row];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    NSString *poemWithAddedSynonym = [NSString stringWithFormat:@" %@", cell.textLabel.text];
    [self.delegate wordSelected:poemWithAddedSynonym];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    [[ThesaurusController sharedInstance] synonymsForWords:self.thesaurusTextField.text completion:^(BOOL success) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
    
    return YES;
}


@end
