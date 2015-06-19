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

@interface ProfileViewController ()<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *nameText;
@property (weak, nonatomic) IBOutlet UITextField *ageText;
@property (weak, nonatomic) IBOutlet UITextField *locationText;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *editButton;
@property (weak, nonatomic) IBOutlet UIButton *uploadPhotoButton;
@property (nonatomic, readwrite) BOOL inEditingMode;
@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.inEditingMode = NO;
    
    if (self.userProfile[@"username"] == nil) {
        
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
            self.editButton.hidden = YES;
            self.uploadPhotoButton.hidden = YES;
            [self updateProfileForNewUser:self.userProfile];
        }
}
- (void)viewWillAppear:(BOOL)animated
{
//    [[PoemController sharedInstance] getPoemsFromWriter:^(BOOL success) {
//        [self.tableView reloadData];
//    }];
    
    [self.tableView reloadData];
//    
//    PFUser *user = [PFUser currentUser];
//    
//    self.ageText.text = user[@"age"];
//    self.locationText.text = user[@"location"];
//    PFFile *photoFile = user[@"photo"];
//    [photoFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            self.image.image = [UIImage imageWithData:data];
//        });
//    }];
}

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



- (IBAction)editProfileButtonTapped:(id)sender {
    
    self.inEditingMode = !self.inEditingMode;
    
    self.ageText.borderStyle = UITextBorderStyleRoundedRect;
    self.ageText.userInteractionEnabled = YES;
    
    self.locationText.borderStyle = UITextBorderStyleRoundedRect;
    self.locationText.userInteractionEnabled = YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
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
    
    Poem *poem = [PoemController sharedInstance].poemsByWriter[indexPath.row];
    
    cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    cell.backgroundColor = [UIColor yellowColor];
    cell.textLabel.text = poem.title;
    
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
        // As of now, this pushes to PTRVC but displays the wrong poem.
        [viewController updateWithPoem:poem];
    }
}


@end
