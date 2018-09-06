//
//  ImageLoader.m
//  Herbstfest2
//
//  Created by Michael Dietz on 22.08.13.
//  Copyright (c) 2013 Michael Dietz. All rights reserved.
//

#import "ImageLoader.h"
#import "ModelPersistanceManager.h"
#import "Feed.h"

#define VERBOSE 0

@implementation ImageLoader

-(NSData*)getCachedImage:(NSString*)imageURL{
 
    ModelPersistanceManager* model = [ModelPersistanceManager getInstance];
    NSManagedObjectContext *context = [model getManagedObjectContext];
    
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"imageURL == %@", imageURL]];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Feed" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    NSError *error;
    NSArray *items = [context executeFetchRequest:fetchRequest error:&error];
    
    
    for (NSManagedObject *managedObject in items) {
        Feed* feed = (Feed*) managedObject;
        return feed.imageData;
    }
    
    
    return nil;

    
}

-(void)loadImageAndCacheForFeed:(NSString*)imageURL :(id<ImageLoaderDelegate>)delegate{
    
    _imageURL = imageURL;
    _delegate = delegate;
    
    NSData* cache = [self getCachedImage:imageURL];
    
    if(cache == nil){
    
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:[NSURL URLWithString:imageURL]];
        [request setHTTPMethod:@"GET"];
        
        NSURLConnection *connection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
        if (connection) {
            receivedData=[NSMutableData data];
        } else {
            [_delegate imageLoadError:@"Intialization Error"];
        }
        
    } else {

#if VERBOSE >= 1
        NSLog(@"Image was cached");
#endif
        [_delegate imageLoaded:cache];
    }
    
}

#pragma mark ConnectionDelegateMethods

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	[receivedData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {

#if VERBOSE >= 1
	NSLog(@"Load Failed");
#endif
    
	NSString* errorText = [[NSString alloc] initWithFormat:@"Load Failed! Error - %@", [error localizedDescription]];
    [_delegate imageLoadError:errorText];    
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    ModelPersistanceManager* model = [ModelPersistanceManager getInstance];
    NSManagedObjectContext *context = [model getManagedObjectContext];
    
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"imageURL == %@", _imageURL]];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Feed" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    NSError *error;
    NSArray *items = [context executeFetchRequest:fetchRequest error:&error];
    
    
    for (NSManagedObject *managedObject in items) {
        [managedObject setValue:receivedData forKey:@"ImageData"];
    	NSLog(@"%@ object deleted",@"Feed");
    }
    
    [context save:&error];   
    
    [_delegate imageLoaded:receivedData];
}

@end
