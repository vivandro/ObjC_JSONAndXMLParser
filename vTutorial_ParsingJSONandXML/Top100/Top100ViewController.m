//
//  Top100ViewController.m
//  vTutorial_ParsingJSONandXML
//
//  Created by Vichare, Vivek on 3/8/15.
//  Copyright (c) 2015 Vichare, Pallavi. All rights reserved.
//

#import "Top100ViewController.h"
#import "Top100ListCell.h"
#import "AppSummaryModel.h"
#import "Top100PaidApplications.h"

@interface Top100ViewController ()

@property (nonatomic) NSArray *appList;

@end

@implementation Top100ViewController

static NSString * const reuseIdentifier = @"Top100ListCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    // V.V.Important: We should not register the cell class from code if we are setting it up
    // from the Storyboard. Otherwise the prototype cell is ignored entirely. Until I commented
    // out the line below, I was seeing the subviews of the cell as nil because it seems that the
    // collection view was instantiating the cell from the class name I'm registering below and thus
    // calling the incorrect init method. I'm guessing that the storyboard hookup results in a call
    // to the initwithxib*** method which correctly knows to create and hook up the sbviews as laid out
    // in the story board.
    //[self.collectionView registerClass:[Top100ListCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
    __weak Top100ViewController *weakSelf = self;
    [Top100PaidApplications fetchWithCompletionBlock:^(NSArray *appList) {
        weakSelf.appList = appList;
        [weakSelf.collectionView reloadData];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.appList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    Top100ListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    // The cells come with all elements having clearColor. So we paint the background for the cell
    // to become visible.
    cell.backgroundColor = [UIColor purpleColor];
    AppSummaryModel *dummyModel = self.appList[indexPath.row];
    [cell updateForAppSummary:dummyModel];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
