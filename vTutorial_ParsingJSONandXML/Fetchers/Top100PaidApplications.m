//
//  Top100PaidApplications.m
//  vTutorial_ParsingJSONandXML
//
//  Created by Vichare, Vivek on 3/8/15.
//  Copyright (c) 2015 Vichare, Pallavi. All rights reserved.
//

#import <Foundation/Foundation.h>
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

                       weakSelf.completion([weakSelf extractAppListFromJSONData:data]);
                       weakSelf.me  = nil;
                   }];
}

-(NSArray *)extractAppListFromJSONData:(NSData *)data {
    if (!data) {
        return nil;
    }
    NSError *error;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:data
                                                    options:NSJSONReadingAllowFragments
                                                      error:&error];
    if (!jsonObject
        || ![jsonObject isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    
    NSDictionary *jsonAsDictionary = (NSDictionary *)jsonObject;

    jsonObject = jsonAsDictionary[@"feed"];
    if (!jsonObject
        || ![jsonObject isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    NSDictionary *feed = (NSDictionary *)jsonObject;

    jsonObject = feed[@"entry"];
    if (!jsonObject
        || ![jsonObject isKindOfClass:[NSArray class]]) {
        return nil;
    }
    NSArray *entries = (NSArray *)jsonObject;
    
    NSMutableArray *appList = [[NSMutableArray alloc] init];
    for (int i = 0; i < entries.count; ++i) {
        NSDictionary *entryDict = (NSDictionary *)entries[i];
        if (!entryDict
            || ![entryDict isKindOfClass:[NSDictionary class]]) {
            return nil;
        }
        AppSummaryModel *dummyModel = [AppSummaryModel new];
        dummyModel.rank = @(i+1);
        
        NSDictionary *subEntry = entryDict[@"im:name"];
        if (!subEntry
            || ![subEntry isKindOfClass:[NSDictionary class]]) {
            return nil;
        }
        
        NSString *title = subEntry[@"label"];
        if (!title
            || ![title isKindOfClass:[NSString class]]) {
            return nil;
        }
        dummyModel.title = title;
        
        subEntry = entryDict[@"summary"];
        if (!subEntry
            || ![subEntry isKindOfClass:[NSDictionary class]]) {
            return nil;
        }
        
        NSString *subTitle = subEntry[@"label"];
        if (!subTitle
            || ![subTitle isKindOfClass:[NSString class]]) {
            return nil;
        }
        dummyModel.subTitle = subTitle;
        
        NSArray *imageArray = entryDict[@"im:image"];
        if (!imageArray
            || ![imageArray isKindOfClass:[NSArray class]]
            || (0 == imageArray.count)) {
            return nil;
        }
        
        subEntry = imageArray[imageArray.count - 1];
        if (!subEntry
            || ![subEntry isKindOfClass:[NSDictionary class]]) {
            return nil;
        }
        NSString *imageUrlString = (NSString *)subEntry[@"label"];
        if (!imageUrlString
            || ![imageUrlString isKindOfClass:[NSString class]]) {
            return nil;
        }
        dummyModel.imageUrlString = imageUrlString;
        [appList addObject:dummyModel];
    }
    return appList;
}

@end
