//
//  Top100ListCell.h
//  vTutorial_ParsingJSONandXML
//
//  Created by Vichare, Vivek on 3/8/15.
//  Copyright (c) 2015 Vichare, Vivek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppSummaryModel.h"

/*
 * We want to display the image, rank, title and description of app.
 */

@interface Top100ListCell : UICollectionViewCell

-(void) updateForAppSummary:(AppSummaryModel *)appSummary;

@end
