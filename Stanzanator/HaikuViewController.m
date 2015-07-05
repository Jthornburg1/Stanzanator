//
//  HaikuViewController.m
//  Stanzanator
//
//  Created by jonathan thornburg on 7/1/15.
//  Copyright (c) 2015 jonathan thornburg. All rights reserved.
//

#import "HaikuViewController.h"

@interface HaikuViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textview;

@end

@implementation HaikuViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.textview.text = @"\t\tI’ve, in forty years,\n\t\tnot competed a haiku\n\t\t…till this one right now!\n\nYes, it’s tempting to think that if you jot down three lines that have 5, 7, and 5 syllables, you’ve got haiku. Here’s another:\n\t\tThe angry man says,\n\t'HAIKUS MUST REFER TO NATURE!'\n\t\tHis face with tattoos\n\nSure of himself as he was, although it is common for them to pertain to nature in some way, the angry man was wrong. Haiku is an art form so adherance to form is voluntary and may be loose.Maybe a better guideline is that good haiku transfers the experience of an instant to the reader in dramatic and illuminating way.";

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
