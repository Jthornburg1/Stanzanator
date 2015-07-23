//
//  BluesPoemViewController.m
//  Stanzanator
//
//  Created by jonathan thornburg on 7/1/15.
//  Copyright (c) 2015 jonathan thornburg. All rights reserved.
//

#import "BluesPoemViewController.h"

@interface BluesPoemViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation BluesPoemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.textView.text = @"In a plane, a train, as a passenger in a car\n\nIn an ER waiting room\n\nWhile waiting for other members of a wedding party to gather their belongings\n\nWhen you’re waiting for a relative to be born\n\nIn a meeting for members of your local startup community\n\nAt the DMV\n\nIf ever shame about a line you’ve written previously overwhelms you and demands that you edit it right now(!)";
    
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
