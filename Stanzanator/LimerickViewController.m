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

    self.textView.text = @"Everyone knows the bouncy limerick. It may be the cleverest of all poetic forms. It is but a meter and rhyme structure and could apply to any theme but usually defaults to humor, mischief, smut, slander and the like. Limericks generally, but not necessarily veer away from drama, seriousness or even sincerity. Most will recognize the layout:\n\nblah BLAH blah blah BLAH blah blah BLAH\nblah BLAH blah blah BLAH blah blah BLAH\nblah BLAH blah blah BLAH\nblah BLAH blah blah BLAH\nblah BLAH blah blah BLAH blah blah BLAH\n\nOh!..the last words of lines 1, 2, and 5 ought to rhyme as well as the last words of lines 3 and 4!\n\nWriting limericks can help build poetic chops and likely yield some real zingers!\n\n";

    
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
