//
//  ImageLoaderAndCacher.h
//  DieMauer
//
//  Created by Dietz, Michael on 9/7/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ProgramLoaderDelegate

-(void)     contentLoaded:(NSString*)filename;
-(void)     contentLoadingFailed:(NSString*)error;

@end


@interface ProgramLoaderAndCacher : NSObject {

	NSMutableData*            receivedData; 
    id<ProgramLoaderDelegate> _delegate;
	NSString*                 fullPath; 
	
}

-(void)    loadContent:(NSString*)filename :(id<ProgramLoaderDelegate>)delegate;

@end

