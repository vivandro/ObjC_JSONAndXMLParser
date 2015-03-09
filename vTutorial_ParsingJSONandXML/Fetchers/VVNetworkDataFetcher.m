//
//  VVNetworkDataFetcher.m
//  vTutorial_ParsingJSONandXML
//
//  Created by Vichare, Vivek on 3/8/15.
//  Copyright (c) 2015 Vichare, Pallavi. All rights reserved.
//

#import "VVNetworkDataFetcher.h"

@interface VVNetworkDataFetcher () <NSURLConnectionDataDelegate>

@property (nonatomic) NSURLRequest *urlRequest;
@property (nonatomic, copy) FetcherCompletionBlock completionBlock;

@property (nonatomic) NSMutableData *receivedData;

@property (retain) id me;

@end

@implementation VVNetworkDataFetcher

+(void)fetchFromUrl:(NSString *)urlString withCompletionBlock:(FetcherCompletionBlock)completion {
    VVNetworkDataFetcher *fetcher = [[VVNetworkDataFetcher alloc] initWithUrl:urlString
                                                            anCompletionBlock:completion];
    [fetcher fetch];
}

-(instancetype)initWithUrl:(NSString *)urlString anCompletionBlock:(FetcherCompletionBlock)completion {
    if (self = [super init]) {
        NSURL *url = [NSURL URLWithString:urlString];
        _urlRequest = [NSURLRequest requestWithURL:url];
        _completionBlock = [completion copy];
        _me  = self;
    }
    return self;
}

-(void)fetch {
    [NSURLConnection connectionWithRequest:self.urlRequest delegate:self];
}

#pragma mark NSURLConnectionDataDelegate adoption
// Beginning of response.
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    self.receivedData = [NSMutableData new];
}

// Received next part of the response data.
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.receivedData appendData:data];
}

// Finished receiving the response.
-(void)connectionDidFinishLoading:(NSURLConnection *)connection {
    self.completionBlock(self.receivedData);
    self.receivedData = nil;
    self.me = nil;
}

// Failed to receive response data.
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    self.receivedData = nil;
    self.completionBlock(nil);
    self.me = nil;
}

@end
