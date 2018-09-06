//
//  ModelPersitanceManager.h
//  HANA Manager
//
//  Created by Michael Dietz on 18.07.13.
//  Copyright (c) 2013 Michael Dietz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface ModelPersistanceManager : NSObject{
    
    NSManagedObjectContext *managedObjectContext;
    NSManagedObjectModel *managedObjectModel;
    NSPersistentStoreCoordinator *persistentStoreCoordinator;
    
}



+(ModelPersistanceManager*)getInstance;

- (NSManagedObjectContext *)getManagedObjectContext;
- (NSManagedObjectModel *)getManagedObjectModel;
- (NSPersistentStoreCoordinator *)getPersistentStoreCoordinator;
- (NSURL *)applicationDocumentsDirectory;


@end
