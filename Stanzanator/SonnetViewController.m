//
//  SonnetViewController.m
//  Stanzanator
//
//  Created by jonathan thornburg on 7/1/15.
//  Copyright (c) 2015 jonathan thornburg. All rights reserved.
//

#import "SonnetViewController.h"

@interface SonnetViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation SonnetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.textView.text = @"Shakespeare wrote sonnets and so can you! There are two kinds: English and Italian. Both have fourteen lines written in iambic pentameter. That is, each line has ten syllables with even numbered syllables accented\n\nItalian or ‘Petrachan’ sonnets have the following pattern of rhymes: nddn, nddn, xyzxyz or cdcdcd. If you can see how each line (14) is represented by a letter, then consider like letters to represent lines with rhyming final syllables. Traditionally, at the ninth line, Italian sonnets transition from asking a question to answering it.\n\nEnglish or ‘Shakespearian’ sonnets differ in rhyme scheme and may require an author to be a bit more quick-witted because the first 12 lines are generally pointed in the same direction and, together, set the scene for the last two lines to act as the punch-line. That is, they either heighten, refute, or skew the overall meaning of the lines that precede them. Here is their pattern: ghgh, byby, qfqf, aa.\n\nThere. You can write a sonnet now. But know that this writing has done a disservice to the genre in the name of brevity. There are many more resources readily available.";
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
