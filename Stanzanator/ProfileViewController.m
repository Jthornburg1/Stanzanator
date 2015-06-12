//
//  ProfileViewController.m
//  Stanzanator
//
//  Created by jonathan thornburg on 5/30/15.
//  Copyright (c) 2015 jonathan thornburg. All rights reserved.
//

#import "ProfileViewController.h"
#import "PoemController.h"

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
    // Do any additional setup after loading the view.
    self.inEditingMode = NO;
    
    self.nameText.text = [PFUser currentUser].username;
    
    PFUser *user = [PFUser new];
    
    
    if ([PFUser currentUser]) {
        self.editButton.enabled = YES;
        self.uploadPhotoButton.enabled = YES;
    }else{
        self.editButton.enabled = NO;
        self.uploadPhotoButton.enabled = NO;
    }
}
- (void)viewWillAppear:(BOOL)animated
{
    [[PoemController sharedInstance] getPoemsFromWriter:^(BOOL success) {
        [self.tableView reloadData];
    }];
    
    PFUser *user = [PFUser currentUser];
    
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
    cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    cell.backgroundColor = [UIColor yellowColor];
    
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [PoemController sharedInstance].writersPoems.count;
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
