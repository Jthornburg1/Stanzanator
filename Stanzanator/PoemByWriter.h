//
//  PoemByWriter.h
//  Stanzanator
//
//  Created by jonathan thornburg on 6/17/15.
//  Copyright (c) 2015 jonathan thornburg. All rights reserved.
//

@import Foundation;
@import UIKit;

@interface PoemByWriter : NSObject

@property (nonatomic, strong)NSString *title;
@property (nonatomic, strong)NSString *bodyText;
@property (nonatomic, strong)NSDate *timeStamp;


-(instancetype)initWithDictionary:(NSDictionary *)dictionary;


@end
