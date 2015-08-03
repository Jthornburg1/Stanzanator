//
//  EULAViewController.m
//  Stanzanator
//
//  Created by jonathan thornburg on 8/3/15.
//  Copyright (c) 2015 jonathan thornburg. All rights reserved.
//

#import "EULAViewController.h"

@interface EULAViewController ()

@property (weak, nonatomic) IBOutlet UITextView *agreement;

@end

@implementation EULAViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.agreement.text = @"Stanzanator End User License Agreement\n\nBy downloading and using Stanzanator, the user agrees to abide by the following terms of service:\n\nUsers may not post material that is deliberately offensive to other users. Text that contains statements that could reasonably be seen as bigoted, racist, inflammatory, sexually explicit, or threatening will be deleted from the app. Profile pictures that could similarly be seen as bigoted, racist, sexually explicit, or threatening will cause the corresponding user account to be removed along with all of his or her posts.\n\nStanzanator reserves the right to remove any account or text from the app without giving reason.";
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
