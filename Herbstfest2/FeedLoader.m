//
//  InstagramAccess.m
//  Herbstfest2
//
//  Created by Michael Dietz on 25.07.13.
//  Copyright (c) 2013 Michael Dietz. All rights reserved.
//

#import "FeedLoader.h"
#import "ModelPersistanceManager.h"
#import "Feed.h"

#define VERBOSE 0


@implementation FeedLoader

-(void)loadInstagramFeedAndStoreToCoreData:(void (^)(void))completionBlock{
    _completionBlock = completionBlock;
    
    [self deleteAllFeeds];
    
    
    NSString* url = [NSString stringWithFormat:@"http://space-labs.appspot.com/repo/268001/checkAndLoadFeedsV2.sjs?definitionid=278001"];
    Connection *conn =    [[Connection alloc] init];
    [conn callURLAsync:url :self];
}


-(void)     dataLoadingSuccessful:(NSString*)resultString{
    
    //Parse JSON String
    NSData* jsonData = [resultString dataUsingEncoding:NSUTF8StringEncoding];
    NSArray* feeds = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:nil];
    
    ModelPersistanceManager* model = [ModelPersistanceManager getInstance];
    NSManagedObjectContext *context = [model getManagedObjectContext];
     
    
    for(int i = 0; i < feeds.count; i++){
        NSObject* item = [feeds objectAtIndex:i];

        int h = [[item valueForKey:@"ImageH"] intValue];
        int w = [[item valueForKey:@"ImageW"] intValue];
        
        Feed* feed    = [NSEntityDescription insertNewObjectForEntityForName:@"Feed" inManagedObjectContext:context];
        feed.type     = [item valueForKey:@"Type"];
        feed.feedid   = [item valueForKey:@"FeedID"];
        feed.text     = [item valueForKey:@"Text"];
        feed.imageURL = [item valueForKey:@"ImageURL"];
        feed.username = [item valueForKey:@"Username"];
        feed.imgHeight = [NSNumber numberWithInteger:h];
        feed.imgWidth =  [NSNumber numberWithInteger:w];
        
    
        
#if VERBOSE >= 1
        NSLog(@"Loaded Feed %@", feed.feedid );
#endif
        
    }

    NSError *error;
    if (![context save:&error]) {
        NSLog(@"Model Saving Error: %@", [error localizedDescription]);
    }

    _completionBlock();
}


-(void)deleteAllFeeds{
    
    ModelPersistanceManager* model = [ModelPersistanceManager getInstance];
    NSManagedObjectContext *context = [model getManagedObjectContext];
   
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Feed" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];

    NSError *error;
    NSArray *items = [context executeFetchRequest:fetchRequest error:&error];
    
    
    for (NSManagedObject *managedObject in items) {
    	[context deleteObject:managedObject];
#if VERBOSE >= 1
    	NSLog(@"%@ object deleted",@"Feed");
#endif
    }
    if (![context save:&error]) {
    	NSLog(@"Error deleting %@ - error:%@",@"Feed",error);
    }

}


-(void)     dataLoadingError:(NSString*) errorText{
    NSLog(@"Error loading: %@",errorText);
}

@end
