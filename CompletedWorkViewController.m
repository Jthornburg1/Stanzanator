//
//  CompletedWorkViewController.m
//  Stanzanator
//
//  Created by jonathan thornburg on 5/30/15.
//  Copyright (c) 2015 jonathan thornburg. All rights reserved.
//

#import "CompletedWorkViewController.h"

@interface CompletedWorkViewController ()
@property (strong, nonatomic) IBOutlet UIView *titleLabel;
@property (weak, nonatomic) IBOutlet UITextView *poemTextView;

@end

@implementation CompletedWorkViewController
- (IBAction)goToAuthorsProfie:(id)sender {
}
- (IBAction)makePrivateButtonTapped:(id)sender {
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
