//
//  CoreDataController.h
//  MH4U Dex
//
//  Created by Joseph Goldberg on 2/6/15.
//  Copyright (c) 2015 Joseph Goldberg. All rights reserved.
//

#import <CoreData/CoreData.h>
#import <Foundation/Foundation.h>

@interface CoreDataController : NSObject

+ (CoreDataController *)sharedCDController;

/**
 Load into Core Data the data on Monsters and their damage zones.
 */
- (void)loadMonsterData;

/**
 Load into Core Data the data on what Items can be obtained from monsters.
 */
- (void)loadMonsterDropData;

/**
 Load into Core Data the data on Regions, Areas, and what Items can be obtained from Areas.
 */
- (void)loadRegionData;

/**
 Load into Core Data the data on Quests.
 */
- (void)loadQuestData;

/**
 Load into Core Data the rewards that can be obtained from Quests
 */
- (void)loadQuestDropData;

/**
 Attempt to save the persistent store, and return true if succesful
 */
- (BOOL)attemptSaveContext;

/**
 Returns the Unique entity that matches the entityName and predicate, or nil if the entity does not exist, or is not unique.
 */
- (NSManagedObject *)uniqueEntityWithEntityName:(NSString *)entityName withPredicate:(NSPredicate *)predicate;

#pragma mark - Boilerplate Core Data Code

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end