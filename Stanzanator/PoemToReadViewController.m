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
@property (weak, nonatomic) IBOutlet UIButton *editButton;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextView *poemBodyText;
@property (weak, nonatomic) IBOutlet UILabel *timeStampLabel;

@end

@implementation PoemToReadViewController
- (IBAction)deletePoem:(id)sender {
    self.titleLabel.text = @"";
    self.poemBodyText.text = @"";
    
    [[PoemController sharedInstance]removePoem:self.poem];
    [self.poem deleteInBackground];
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleLabel.text = self.poem.title;
    self.poemBodyText.text = self.poem.bodyText;
    NSDateFormatter *dateformatter = [NSDateFormatter new];
  
    [dateformatter setDateFormat:@"MM/dd/YYYY"];
    self.timeStampLabel.text = [dateformatter stringFromDate:self.poem.timestamp];
    
    if (self.poem.writerOfPoem == [PFUser currentUser]) {
        self.editButton.enabled = YES;
        self.deleteButton.enabled = YES;
    }else{
        self.editButton.hidden = YES;
        self.deleteButton.hidden = YES;
    }
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)editButtonTapped:(id)sender {
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
        [stanzaViewController updateWithPoem:self.poem];
    }
}



@end
