//
//  StanzifestoViewController.m
//  Stanzanator
//
//  Created by jonathan thornburg on 6/30/15.
//  Copyright (c) 2015 jonathan thornburg. All rights reserved.
//

#import "StanzifestoViewController.h"

@interface StanzifestoViewController ()
@property (weak, nonatomic) IBOutlet UITextView *festoTextView;

@end

@implementation StanzifestoViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.festoTextView.text = @"";

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
