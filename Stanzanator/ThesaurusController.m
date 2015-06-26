//
//  ThesaurusController.m
//  Stanzanator
//
//  Created by jonathan thornburg on 6/26/15.
//  Copyright (c) 2015 jonathan thornburg. All rights reserved.
//

#import "ThesaurusController.h"
#import "Thesaurus.h"

@implementation ThesaurusController


+ (instancetype)sharedInstance
{
    static ThesaurusController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        sharedInstance = [[ThesaurusController alloc] init];
        sharedInstance.thesaurusObjects = @[];
    });
        return sharedInstance;
}

#pragma mark - NSURLSessions method(S)

- (Thesaurus *)makeThesaurus
{
    Thesaurus *thesaurus = [Thesaurus new];
    self.thesaurusObjects = [self.thesaurusObjects arrayByAddingObjectsFromArray:@[thesaurus]];
    return thesaurus;
}

- (void)synonymsForWords:(NSString *)word completion:(void (^)(BOOL success))completion {
    
    NSString *urlString = [NSString stringWithFormat:@"http://words.bighugelabs.com/api/2/8a6556b707b238b1f8c60c394627d24f/%@/json", word];
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLSession *session = [NSURLSession sharedSession];
    self.thesaurusObjects = @[];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (!error) {
            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil] ;
            
            
            //NSMutableArray *resultsToObjects = [NSMutableArray new];
            
            for (NSString *partOfSpeach in [dictionary allKeys]) {
                Thesaurus *thesaurus = [self makeThesaurus];
                thesaurus.partOfSpeach = partOfSpeach;
                thesaurus.synonymn = dictionary[partOfSpeach][@"syn"];
                thesaurus.antonym = dictionary[partOfSpeach][@"ant"];
        }
            completion (YES);
        
            
        }else{
            completion (NO);
    }
    }];
    [dataTask resume];
}

//- (void)representativesByZipCode:(NSString *)zip completion:(void (^)(NSArray * reps))completion {
//
//    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://whoismyrepresentative.com/getall_mems.php?zip=%@&output=json", zip]];
//
//    NSURLSession *session = [NSURLSession sharedSession];
//    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//
//        NSArray *representatives = [[NSJSONSerialization JSONObjectWithData:data options:0 error:nil] objectForKey:@"results"];
//
//        NSLog(@"%@", error);
//
//        NSMutableArray *convertedReps = [NSMutableArray new];
//
//        for (NSDictionary *dictionary in representatives) {
//            Representative *rep = [[Representative alloc] initWithDictionary:dictionary];
//
//            [convertedReps addObject:rep];
//        }
//        completion(convertedReps);
//    }];
//
//    [dataTask resume];
//
//}


@end
