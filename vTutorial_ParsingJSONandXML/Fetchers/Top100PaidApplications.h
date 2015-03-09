//
//  Top100PaidApplications.h
//  vTutorial_ParsingJSONandXML
//
//  Created by Vichare, Vivek on 3/8/15.
//  Copyright (c) 2015 Vichare, Pallavi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppSummaryModel.h"

// The completion block will be passed an Array of the top 100 paid applications.
// It will be an NSArray of AppSummaryModel objects.
typedef void(^Top100FetcherCompletionBlock)(NSArray *);

@interface Top100PaidApplications : NSObject

+(void)fetchWithCompletionBlock:(Top100FetcherCompletionBlock)completion;

@end
