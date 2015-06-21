//
//  PoemToReadViewController.m
//  Stanzanator
//
//  Created by jonathan thornburg on 6/2/15.
//  Copyright (c) 2015 jonathan thornburg. All rights reserved.
//

#import "PoemToReadViewController.h"
#import "StanzaViewController.h"

@interface PoemToReadViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextView *poemBodyText;

@end

@implementation PoemToReadViewController
- (IBAction)deletePoem:(id)sender {
    self.titleLabel.text = @"";
    self.poemBodyText.text = @"";
    
    [[PoemController sharedInstance]removePoem:self.poem];
    [self.navigationController popToRootViewControllerAnimated:YES];
    [self.poem deleteInBackground];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleLabel.text = self.poem.title;
    self.poemBodyText.text = self.poem.bodyText;    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)editButtonTapped:(id)sender {
    [self performSegueWithIdentifier:@"editTapped" sender:sender];
    self.titleLabel.text = @"";
    self.poemBodyText.text = @"";
    [[PoemController sharedInstance]removePoem:self.poem];
    [self.poem deleteInBackground];


}
- (void)updateWithPoem:(Poem *)poem
{
    self.poem = poem;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"editTapped"]) {
        StanzaViewController *stanzaViewController = segue.destinationViewController;
        stanzaViewController.updatePoem = self.poem;
        
        
        
    }
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
