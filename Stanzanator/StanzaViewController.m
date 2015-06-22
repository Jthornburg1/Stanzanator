//
//  StanzaViewController.m
//  Stanzanator
//
//  Created by jonathan thornburg on 5/30/15.
//  Copyright (c) 2015 jonathan thornburg. All rights reserved.
//

#import "StanzaViewController.h"
#import "PoemController.h"

@interface StanzaViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextView *poemBodyText;
@property (strong, nonatomic) Poem *poem;


@end

@implementation StanzaViewController
- (IBAction)visitTheWebforIdeas:(id)sender {
    // Links to yahoo.com: that string will be an index of an array of strings eventually
    NSArray *URLArray = @[@"https//anncoulter.com",@"https//eonlone.com",@"https//thugkitchen.com",@"https//http://www.openbible.info/topics/m",@"https//",@"https//",@"https//",@"https//",@"https//",@"https//",@"https//",@"https//",@"https//",@"https//",@"https//",@"https//",@"https//",@"https//",@"https//"];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.yahoo.com"]];
    // Needs to return the user to StanzaViewController
}
-(void)viewDidLoad {
    [super viewDidLoad];
    [self updateWithPoem:self.poem];
    self.poem.isPrivate = NO;
    
    self.titleTextField.text = self.updatePoem.title;
    self.poemBodyText.text = self.updatePoem.bodyText;
    
}


- (IBAction)titleChooserChoose:(id)sender {
    int rand = arc4random_uniform(9);
    NSArray *titleArray = @[@"Breakfast at Midnight", @"Title2", @"How to Raise Your Children",@"Just a Little Innocent Fun",@"She Presents Herself", @"He Presents Himself"];
    self.titleTextField.text = titleArray[rand];
}
- (IBAction)doneButtonTapped:(id)sender {
    [[PoemController sharedInstance]addPoemWithTitle:self.titleTextField.text bodyText:self.poemBodyText.text date:[NSDate date] private:self.poem.isPrivate];
    //[[PoemController sharedInstance] addPoemWithTitle:self.titleTextField.text bodyText:self.poemBodyText.text date:[NSDate date]];
}

- (IBAction)makePrivateButtonTapped:(id)sender {
    
    self.poem.isPrivate = !self.poem.isPrivate;
    if (self.poem.isPrivate) {
        self.view.backgroundColor = [UIColor redColor];
    } else {
        self.view.backgroundColor = [UIColor whiteColor];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)updateWithPoem:(Poem *)poem
{
    self.poem = poem;
    self.titleTextField.text = poem.title;
    self.poemBodyText.text = poem.bodyText;
    self.poem.isPrivate = poem.isPrivate;
    [self.poem saveInBackground];
    [self.poem pinInBackground];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
