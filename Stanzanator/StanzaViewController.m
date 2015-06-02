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
- (IBAction)doneButtonTapped:(id)sender {
    if (self.poem) {
        self.poem.title = self.titleTextField.text;
        self.poem.bodyText = self.poemBodyText.text;
        self.poem.timestamp = [NSDate date];
        [[PoemController sharedInstance] updatePoem:self.poem];
    } else {
        [[PoemController sharedInstance] addPoemWithTitle:self.titleTextField.text bodyText:self.poemBodyText.text date:[NSDate date]];
    }
}
- (IBAction)makePrivateButtonTapped:(id)sender {
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   // self.poemBodyText.text = @"";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
