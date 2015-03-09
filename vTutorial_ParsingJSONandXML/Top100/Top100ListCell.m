//
//  Top100ListCell.m
//  vTutorial_ParsingJSONandXML
//
//  Created by Vichare, Vivek on 3/8/15.
//  Copyright (c) 2015 Vichare, Palla. All rights reserved.
//

#import "Top100ListCell.h"
#import "VVNetworkDataFetcher.h"

@interface Top100ListCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *rankLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;

@property (nonatomic, copy) NSString *imageUrlString;

@end

@implementation Top100ListCell

-(void)updateForAppSummary:(AppSummaryModel *)appSummary {
    self.rankLabel.text = [NSString stringWithFormat:@"%@", appSummary.rank];
    // I've hidden the rank label because the layout did not look good with it in the cell.
    self.titleLabel.text = [NSString stringWithFormat:@"%@: %@", appSummary.rank, appSummary.title];
    self.subTitleLabel.text = appSummary.subTitle;

    // save the imageUrlString for comparison whenthe image fetch is finished.
    self.imageUrlString = appSummary.imageUrlString;
    __weak Top100ListCell *weakSelf = self;
    NSString *urlStringCopy = [self.imageUrlString copy];
    [VVNetworkDataFetcher fetchFromUrl:self.imageUrlString
                   withCompletionBlock:^(NSData *data){
                       if (![urlStringCopy isEqualToString:weakSelf.imageUrlString]) {
                           return;
                       }
                       UIImage *image = [UIImage imageWithData:data];
                       weakSelf.imageView.image = image;
                   }];
}

-(void)prepareForReuse {
    self.imageView.image = nil;
}

@end
