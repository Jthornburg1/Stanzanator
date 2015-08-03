//
//  PoemToReadViewController.m
//  Stanzanator
//
//  Created by jonathan thornburg on 6/2/15.
//  Copyright (c) 2015 jonathan thornburg. All rights reserved.
//

#import "PoemToReadViewController.h"
#import "StanzaViewController.h"
#import <MessageUI/MessageUI.h>


@interface PoemToReadViewController ()<MFMailComposeViewControllerDelegate, UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *editButton;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property (weak, nonatomic) IBOutlet UITextView *poemBodyText;
@property (weak, nonatomic) IBOutlet UITextView *titleTexView;
@property (weak, nonatomic) IBOutlet UILabel *timeStampLabel;

@end

@implementation PoemToReadViewController
- (IBAction)deletePoem:(id)sender {
    self.titleTexView.text = @"";
    self.poemBodyText.text = @"";
    
    [[PoemController sharedInstance]removePoem:self.poem];
    [self.poem deleteInBackground];
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleTexView.text = self.poem.title;
    self.poemBodyText.text = self.poem.bodyText;
    NSDateFormatter *dateformatter = [NSDateFormatter new];
    [dateformatter setDateFormat:@"MM/dd/YYYY"];
    self.timeStampLabel.text = [dateformatter stringFromDate:self.poem.timestamp];

    self.titleTexView.font = [UIFont fontWithName:@"Times New Roman" size:20];
    self.titleTexView.textAlignment = NSTextAlignmentCenter;

    if (self.poem.writerOfPoem == [PFUser currentUser]) {
        self.editButton.enabled = YES;
        self.deleteButton.enabled = YES;
    }else{
        self.editButton.hidden = YES;
        self.deleteButton.hidden = YES;
    }
}

- (IBAction)homeBound:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - flag user methods

- (IBAction)flagButtonTapped:(id)sender {
    UIAlertView *flag = [[UIAlertView alloc] initWithTitle:@"Flag this user?"
                                                   message:@"If 'YES,' then this user's content will be subject to administrative review and you'll need to log back in to use Stanzanator again."
                                                  delegate:self
                                         cancelButtonTitle:@"NO"
                                         otherButtonTitles:@"YES", nil];
    flag.tag = 1;
    [flag show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1) {
        if (buttonIndex == 1) {
            if ([MFMailComposeViewController canSendMail])
            {
                MFMailComposeViewController *mail = [[MFMailComposeViewController alloc] init];
                mail.mailComposeDelegate = self;
                [mail setSubject:@"Stanzanator user flagged"];
                [mail setMessageBody:[NSString stringWithFormat:@"The user %@ has had the poem, %@, flagged as objectionable", self.poem.writerOfPoem.username, self.poem.title] isHTML:NO];
                [mail setToRecipients:@[@"stanzanatorflagged@gmail.com"]];
                
                [self presentViewController:mail animated:YES completion:NULL];
            }
            else
            {
                NSLog(@"This device cannot send email");
            }
            
        }
    }
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)editButtonTapped:(id)sender {
    self.titleTexView.text = @"";
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
