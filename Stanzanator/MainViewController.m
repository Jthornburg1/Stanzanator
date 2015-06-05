//
//  ViewController.m
//  Stanzanator
//
//  Created by jonathan thornburg on 5/30/15.
//  Copyright (c) 2015 jonathan thornburg. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()<PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate>

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
    if (![PFUser currentUser]) {
        PFLogInViewController *login = [PFLogInViewController new];
        login.fields = PFLogInFieldsUsernameAndPassword | PFLogInFieldsFacebook | PFLogInFieldsTwitter | PFLogInFieldsSignUpButton | PFLogInFieldsLogInButton | PFLogInFieldsDismissButton;
        [self presentViewController:login animated:YES completion:nil];
       
        // login.signUpController.emailAsUsername = YES;
        login.delegate = self;
        login.signUpController.delegate = self;
    }

}
- (void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)logInViewControllerDidCancelLogIn:(PFLogInViewController *)logInController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)signUpViewController:(PFSignUpViewController *)signUpController didSignUpUser:(PFUser *)user
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)signUpViewControllerDidCancelSignUp:(PFSignUpViewController *)signUpController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
