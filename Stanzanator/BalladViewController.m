//
//  BalladViewController.m
//  Stanzanator
//
//  Created by jonathan thornburg on 7/1/15.
//  Copyright (c) 2015 jonathan thornburg. All rights reserved.
//

#import "BalladViewController.h"

@interface BalladViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation BalladViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.textView.text = @"Did something happen? A contour of events? Drama is at home in the ballad. There are characters who’s emotions are shaped by events. As readers, we come to relate to the emotions because the events are narrated to us yet we are often left with more questions than answers.\n\nBallads often accompany music. ‘Poncho And Lefty’ by Townes Van Zandt is a classic, country-folk tune and an exemplary ballad: Two outlaws make cross border journey. Van Zandt tells us few things but leads us to infer many others about the nature of each of the characters and the relationship between them. He hint strongly at a betrayal that leaves us lamenting the death of one character and the survival of the other.\n\nWrite your ballad. Better yet, let it write itself. It seems as though some of the best ones may have been done that way.";
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
