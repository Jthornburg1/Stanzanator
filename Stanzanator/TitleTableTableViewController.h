//
//  TitleTableTableViewController.h
//  Stanzanator
//
//  Created by jonathan thornburg on 5/30/15.
//  Copyright (c) 2015 jonathan thornburg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Poem.h"
#import "CustomCellTableViewCell.h"



@interface TitleTableTableViewController : UITableViewController
//@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) Poem *poem;

@end
