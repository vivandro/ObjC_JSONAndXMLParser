//
//  VVNetworkDataFetcher.h
//  vTutorial_ParsingJSONandXML
//
//  Created by Vichare, Vivek on 3/8/15.
//  Copyright (c) 2015 Vichare, Vivek. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^FetcherCompletionBlock)(NSData *);

@interface VVNetworkDataFetcher : NSObject

// At some point, we may want to split this into initWith... , and another
// method named fetch. That would allow the creation and fetching to be initiated
// at different times. For now, I'm going for convenience.
+(void)fetchFromUrl:(NSString *)urlString withCompletionBlock:(FetcherCompletionBlock)completion;

@end
