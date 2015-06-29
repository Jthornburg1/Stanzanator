//
//  StanzaViewController.m
//  Stanzanator
//
//  Created by jonathan thornburg on 5/30/15.
//  Copyright (c) 2015 jonathan thornburg. All rights reserved.
//

#import "StanzaViewController.h"
#import "PoemController.h"


@interface StanzaViewController ()<UITextFieldDelegate, ThesaurusWordDelegate>
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UISwitch *privateSwitch;
@property (weak, nonatomic) IBOutlet UITextView *poemBodyText;
@property (strong, nonatomic) Poem *poem;
@property (nonatomic) BOOL privateFileOnly;

@end

@implementation StanzaViewController

-(void)wordSelected:(NSString *)word
{
    self.poemBodyText.text = [self.poemBodyText.text stringByAppendingString:word];
}

-(void)viewDidLoad {
    [super viewDidLoad];
    if (self.poem) {
        self.titleTextField.text = self.poem.title;
        self.poemBodyText.text = self.poem.bodyText;
        self.privateFileOnly = self.poem.isPrivate;
    }
}


- (IBAction)titleChooserChoose:(id)sender {
    int rand = arc4random_uniform(9);
    NSArray *titleArray = @[@"Breakfast at Midnight", @"Title2", @"How to Raise Your Children",@"Just a Little Innocent Fun",@"She Presents Herself", @"He Presents Himself", @"Not In My Backyard", @"Snapshots At Twilight", @"On The Median Strip"];
    self.titleTextField.text = titleArray[rand];
}
- (IBAction)makePrivateSwitched:(id)sender {
    self.privateFileOnly = !self.privateFileOnly;
}
- (IBAction)doneButtonTapped:(id)sender {
    [[PoemController sharedInstance]addPoemWithTitle:self.titleTextField.text bodyText:self.poemBodyText.text date:[NSDate date] private:self.privateFileOnly];
    //[self.navigationController popViewControllerAnimated:YES];
}




- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)updateWithPoem:(Poem *)poem
{
    self.poem = poem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqual:@"showThesaurus"]) {
        ThesaurusTableViewController *thesaurusTVC = [segue destinationViewController];
        thesaurusTVC.delegate = self;
    } else if ([segue.identifier isEqualToString:@"doneToProfile"]) {
        PFUser *user = [PFUser currentUser];
        ProfileViewController *profileViewController = [segue destinationViewController];
        profileViewController.userProfile = user;
    }
}








@end
