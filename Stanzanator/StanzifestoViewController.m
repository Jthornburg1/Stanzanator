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

    self.festoTextView.text = @"If you’ve ever been compelled by the force of concise, minimal statements of poetry, try your hand at it with an audience. Stanzanator is at your disposal during moments of joy or suffering that you wish to rivet down in time so that you can spectate on them, share them, and deepen your perspective on being a person.\n\nThe surest path to writing a great poem is the same as the path toward making any great thing: make stacks of bad ones first. For this reason, Stanzanator allows you to flick a switch and keep any piece you choose private. You are equipped with a thesaurus tool and outlines of some common poetic forms available on the bar below.";

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
