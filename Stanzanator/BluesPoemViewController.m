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
    
    self.textView.text = @"Simple but powerful, blues poems are known for themes of perseverance through adversity as well as voicing feelings of temptation the world offers and the hardships caused by giving in to them. The Weary Blues by Langston Hughes is widely viewed as a great representation of the genre. It is rhythmic and melodic much like the musical variety that goes by the same name.\n\nOften blues poems follow a structure in the second line is a reiteration of the first--sometimes identical to the first. The third is a similar statement but with an additional element of humor, irony or darkness\n\nTry it!";
    
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
