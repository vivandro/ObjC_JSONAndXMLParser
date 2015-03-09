//
//  Top100PaidApplications.m
//  vTutorial_ParsingJSONandXML
//
//  Created by Vichare, Vivek on 3/8/15.
//  Copyright (c) 2015 Vichare, Pallavi. All rights reserved.
//

#import "Top100PaidApplications.h"
#import "VVNetworkDataFetcher.h"
#import "AppSummaryModel.h"

@interface Top100PaidApplications ()

@property (nonatomic) NSString *urlString;
@property (nonatomic, copy) Top100FetcherCompletionBlock completion;
@property (nonatomic) VVNetworkDataFetcher *fetcher;

@property (retain) id me;

@end

@implementation Top100PaidApplications

+(void)fetchWithCompletionBlock:(Top100FetcherCompletionBlock)completion {
    Top100PaidApplications *top100 = [[Top100PaidApplications alloc] initWithUrl:@"https://itunes.apple.com/us/rss/toppaidapplications/limit=100/json"
                                                               anCompletionBlock:^(NSArray *top100Apps) {
                                                                   completion(top100Apps);
                                                               }];
    [top100 fetch];
}

-(instancetype)initWithUrl:(NSString *)urlString anCompletionBlock:(Top100FetcherCompletionBlock)completion {
    if (self = [super init]) {
        _urlString = urlString;
        _completion = [completion copy];
        _me = self;
    }
    
    return self;
}

-(void)fetch {
    __weak Top100PaidApplications *weakSelf = self;
    [VVNetworkDataFetcher fetchFromUrl:self.urlString
                   withCompletionBlock:^(NSData *data){
                       if (data == nil) {
                           weakSelf.completion(nil);
                           weakSelf.me = nil;
                           return;
                       }
                       NSMutableArray *rval = [[NSMutableArray alloc] init];
                       for (int i = 1; i <= 50; ++i) {
                           AppSummaryModel *dummyModel = [AppSummaryModel new];
                           dummyModel.rank = @(i);
                           dummyModel.title = @"aaaha";
                           dummyModel.subTitle = @"hello workd";
                           [rval addObject:dummyModel];
                       }
                       weakSelf.completion(rval);
                       weakSelf.me  = nil;
                   }];
}

@end
