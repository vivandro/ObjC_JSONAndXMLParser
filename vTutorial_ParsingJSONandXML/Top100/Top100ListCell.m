//
//  Top100ListCell.m
//  vTutorial_ParsingJSONandXML
//
//  Created by Vichare, Vivek on 3/8/15.
//  Copyright (c) 2015 Vichare, Pallavi. All rights reserved.
//

#import "Top100ListCell.h"

@interface Top100ListCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *rankLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;

@end

@implementation Top100ListCell

-(void)updateForAppSummary:(AppSummaryModel *)appSummary {
    self.rankLabel.text = [NSString stringWithFormat:@"%@", appSummary.rank];
    self.titleLabel.text = appSummary.title;
    self.subTitleLabel.text = appSummary.subTitle;
    // TODO: Need to kick off a download block that downloads the image from the url and loads an image in the image view.
    //       User prepareForReuse: method to cancel the download if possible.
}

@end
