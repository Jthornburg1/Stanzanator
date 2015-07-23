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

    self.festoTextView.text = @"Ever lay out a scroll of parchment beside a well of calligraphy ink with a quill on a desk at the summit of a mountain, or on the bank of a brook and wait patiently for a poem to enter your head? Neither have I.\n\nBut why write poetry on a phone? Charles Bukowski wrote the screenplay for the movie 'Barfly.'  The character, Henry Chinaski, who he models after himself, is offered an arrangement with a wealthy matron of the arts where he could 'write in peace.' He responds, 'Nobody who could write worth a damn could ever write in peace.'\n\nIf you like that, write about it in Stanzanator. If you hate it do the same. If your inkwell has run dry, the mountains are far away, the brook is polluted, make a poem out of it. You'll be glad you did.";

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
