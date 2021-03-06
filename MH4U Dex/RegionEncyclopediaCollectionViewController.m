//
//  RegionEncyclopediaCollectionViewController.m
//  MH4U Dex
//
//  Created by Joseph Goldberg on 2/20/15.
//  Copyright (c) 2015 Joseph Goldberg. All rights reserved.
//

#import "RegionEncyclopediaCollectionViewController.h"

#import <CoreData/CoreData.h>

#import "Constants.h"
#import "CoreDataController.h"

#import "RegionContainerViewController.h"

#import "Region.h"

#import "RegionEncyclopediaCollectionViewCell.h"

@interface RegionEncyclopediaCollectionViewController ()

@property (nonatomic, strong) NSArray *regions;

@end

@implementation RegionEncyclopediaCollectionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"Region Encyclopedia";
    
    NSError *fetchError = nil;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:[Region entityName]];
    fetchRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:RegionAttributes.id ascending:YES]];
    self.regions = [[CoreDataController sharedCDController].managedObjectContext executeFetchRequest:fetchRequest error:&fetchError];
    if (fetchError) {
        NSLog(@"Error fetching region data.");
        NSLog(@"%@, %@", fetchError, fetchError.localizedDescription);
    }
    self.collectionView.accessibilityIdentifier = MHDRegionEncyclopediaCollectionIdentifier;
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.regions.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    RegionEncyclopediaCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([RegionEncyclopediaCollectionViewCell class]) forIndexPath:indexPath];
    [cell displayContentsWithRegion:[self regionAtIndexPath:indexPath]];
    //If cell.contentView.frame isn't explicitly set, then it is (0,0;0,0) for some reason, which it definitely shouldn't be!
    cell.contentView.frame = cell.bounds;
    return cell;
}

#pragma mark - Helper Methods

- (Region *)regionAtIndexPath:(NSIndexPath *)indexPath
{
    return self.regions[indexPath.row];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showRegionDetails"]) {
        RegionContainerViewController *regionVC = (RegionContainerViewController *)segue.destinationViewController;
        if ([sender isMemberOfClass:[RegionEncyclopediaCollectionViewCell class]]) {
            RegionEncyclopediaCollectionViewCell *cell = (RegionEncyclopediaCollectionViewCell *)sender;
            Region *region = [self regionAtIndexPath:[self.collectionView indexPathForCell:cell]];
            regionVC.region = region;
        }
    }
}

@end
