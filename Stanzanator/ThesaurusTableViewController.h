//
//  SeachListTableViewController.h
//  Stanzanator
//
//  Created by jonathan thornburg on 6/23/15.
//  Copyright (c) 2015 jonathan thornburg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThesaurusController.h"
#import "Thesaurus.h"

@protocol ThesaurusWordDelegate <NSObject>

- (void)wordSelected:(NSString *)word;

@end


@interface ThesaurusTableViewController : UITableViewController

@property (strong, nonatomic) NSArray *searchResultsList;
@property (strong, nonatomic) id <ThesaurusWordDelegate>delegate;

@end