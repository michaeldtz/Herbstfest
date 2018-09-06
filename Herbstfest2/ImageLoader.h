//
//  ImageLoader.h
//  Herbstfest2
//
//  Created by Michael Dietz on 22.08.13.
//  Copyright (c) 2013 Michael Dietz. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ImageLoaderDelegate

-(void)     imageLoaded:(NSData*)imgData;
-(void)     imageLoadError:(NSString*)error;


@end

@interface ImageLoader : NSObject{
    
    id<ImageLoaderDelegate> _delegate;
    NSString* _imageURL;
    NSMutableData* receivedData;
    
}


-(void)loadImageAndCacheForFeed:(NSString*)imageURL :(id<ImageLoaderDelegate>)delegate;
	

@end
