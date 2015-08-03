//
//  ProfileViewController.m
//  Stanzanator
//
//  Created by jonathan thornburg on 5/30/15.
//  Copyright (c) 2015 jonathan thornburg. All rights reserved.
//

#import "ProfileViewController.h"
#import "PoemController.h"
#import "PoemToReadViewController.h"
#import <MessageUI/MessageUI.h>

@interface ProfileViewController ()<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIAlertViewDelegate, MFMailComposeViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *nameText;
@property (weak, nonatomic) IBOutlet UITextField *ageText;
@property (weak, nonatomic) IBOutlet UITextField *locationText;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *editButton;
@property (weak, nonatomic) IBOutlet UIButton *uploadPhotoButton;
@property (nonatomic, readwrite) BOOL inEditingMode;
@property (weak, nonatomic) IBOutlet UIButton *flagButton;
@property (nonatomic, strong) NSArray *poems;
@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.inEditingMode = NO;
    
    if (self.userProfile == [PFUser currentUser]) {
        
        PFUser *user = [PFUser currentUser];
        self.nameText.text = user.username;
        self.ageText.text = user[@"age"];
        self.locationText.text = user[@"location"];
        PFFile *photoFile = user[@"photo"];
        [photoFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.image.image = [UIImage imageWithData:data];
            });
        }];
    }
        else {
            self.editButton.enabled = NO;
            self.uploadPhotoButton.enabled = NO;
            self.nameText.userInteractionEnabled = NO;
            self.ageText.userInteractionEnabled = NO;
            self.locationText.userInteractionEnabled = NO;
            [self updateProfileForNewUser:self.userProfile];
        }
}
- (void)viewWillAppear:(BOOL)animated
{
    [[PoemController sharedInstance] poemsByWriter:self.userProfile withCompletion:^(NSArray *poems) {
        self.poems = poems;
        
        [self.tableView reloadData];

    }];
    

}


- (IBAction)homeBound:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

# pragma mark - flag user methods

// sends alert to be sure flag is not accidental
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
                [mail setMessageBody:[NSString stringWithFormat:@"The user %@ has had their photo flagged as objectionable", self.userProfile.username] isHTML:NO];
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
//- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
//{
//    self dismissViewControllerAnimated:YES completion:^{
//        <#code#>
//    }
//}

- (void)updateProfileForNewUser:(PFUser *)user
{
    
    self.nameText.text = user.username;
    self.ageText.text = user[@"age"];
    self.locationText.text = user[@"location"];
    PFFile *photoFile = user[@"photo"];
    [photoFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.image.image = [UIImage imageWithData:data];
        });
    }];

}

- (IBAction)blockOffensiveSwitchChanged:(id)sender {
}


- (IBAction)editProfileButtonTapped:(id)sender {
    
    self.inEditingMode = !self.inEditingMode;
    
    self.ageText.borderStyle = UITextBorderStyleRoundedRect;
    self.ageText.backgroundColor = [UIColor brownColor];
    self.ageText.userInteractionEnabled = YES;
    
    self.locationText.borderStyle = UITextBorderStyleRoundedRect;
    self.locationText.backgroundColor = [UIColor brownColor];
    self.locationText.userInteractionEnabled = YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    PFUser *user = [PFUser currentUser];
    if (textField.tag == 1) {
        user[@"age"] = textField.text;
        textField.borderStyle = UITextBorderStyleNone;
        textField.userInteractionEnabled = NO;
        textField.backgroundColor = [UIColor clearColor];
        [user saveInBackground];
    }else{
        user[@"location"] = textField.text;
        textField.borderStyle = UITextBorderStyleNone;
        textField.userInteractionEnabled = NO;
        textField.backgroundColor = [UIColor clearColor];
        [user saveInBackground];
    }
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    PFUser *user = [PFUser currentUser];
    if (textField.tag == 1) {
        user[@"age"] = textField.text;
        textField.borderStyle = UITextBorderStyleNone;
        textField.userInteractionEnabled = NO;
        [user saveInBackground];

    }else{
        user[@"location"] = textField.text;
        textField.borderStyle = UITextBorderStyleNone;
        textField.userInteractionEnabled = NO;
        [user saveInBackground];
    }
    return YES;
}

- (IBAction)uploadPhotoButtonTapped:(id)sender {
    
    UIImagePickerController *picker = [UIImagePickerController new];
    picker.delegate = self;
    
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    PFUser *user = [PFUser currentUser];
    
    self.image.image = image;
    
    user[@"photo"] = [PFFile fileWithData:UIImageJPEGRepresentation(self.image.image, 0.95)];
    
    [user saveInBackground];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}


# pragma mark - TableView delegate methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [UITableViewCell new];
    
    Poem *poem = self.poems[indexPath.row];
    
    
    cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    cell.textLabel.text = poem.title;
    cell.detailTextLabel.text = @"";
    
    
    if (poem.isPrivate == YES) {
        if (poem.writerOfPoem == [PFUser currentUser]) {
            cell.userInteractionEnabled = YES;
        } else {
            cell.userInteractionEnabled = NO;
            cell.detailTextLabel.text = @"private";

        }
    } else {
        cell.userInteractionEnabled = YES;
    }
    
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [PoemController sharedInstance].poemsByWriter.count;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"myPoem"]) {
        PoemToReadViewController *viewController = [segue destinationViewController];
        NSIndexPath *path = [self.tableView indexPathForCell:sender];
        
        Poem *poem = [PoemController sharedInstance].poemsByWriter[path.row];
        [viewController updateWithPoem:poem];
    }
}


@end
