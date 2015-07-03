//
//  LimerickViewController.m
//  Stanzanator
//
//  Created by jonathan thornburg on 7/1/15.
//  Copyright (c) 2015 jonathan thornburg. All rights reserved.
//

#import "LimerickViewController.h"

@interface LimerickViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation LimerickViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.textView.text = @"Everyone knows the the bouncy limerick:\n\nblah BLAH blah blah BLAH blah blah BLAH\nblah BLAH blah blah BLAH blah blah BLAH\nblah BLAH blah blah BLAH\nblah BLAH blah blah BLAH\nblah BLAH blah blah BLAH blah blah BLAH\n\n";

    
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
