//
//  ImageLoaderAndCacher.m
//  DieMauer
//
//  Created by Dietz, Michael on 9/7/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ProgramLoaderAndCacher.h"

#define BASE_URL @"http://space-labs.appspot.com/repo/268001/"
#define VERBOSE 0

@implementation ProgramLoaderAndCacher

-(void)    loadContent:(NSString*)filename :(id<ProgramLoaderDelegate>)delegate{
	
	_delegate = delegate;
    
	/*
	 1.) Check if the image is in the delievered content
	 */	
	NSString*  path1     = [[NSBundle mainBundle] bundlePath];
	fullPath             = [[path1 stringByAppendingPathComponent:filename] copy];
	
	if([[NSFileManager defaultManager] fileExistsAtPath:fullPath]){
        [_delegate contentLoaded:fullPath];
        return;
	}
	
	/*
	 2.) Check if the image had already been loaded and is now available
	 */	
	NSArray*  paths     = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString* path      = [paths objectAtIndex:0];
	fullPath            = [[path stringByAppendingPathComponent:filename] copy];
	
	if([[NSFileManager defaultManager] fileExistsAtPath:fullPath]){
        [_delegate contentLoaded:fullPath];
        return;
	}
	
	/*
	 3.) If the image had not been created successfully then load it
     */
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];  
	[request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASE_URL,filename]]];  
	[request setHTTPMethod:@"GET"];  
    
#if VERBOSE >= 1
    NSLog(@"Loading Program remote %@", [NSString stringWithFormat:@"%@%@",BASE_URL,filename]);
#endif
    
	NSURLConnection *connection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
	if (connection) {
		receivedData=[NSMutableData data];
	} else {
		[_delegate contentLoadingFailed:@"Error during connection initialization"];
	}
	
}


#pragma mark ConnectionDelegateMethods

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	[receivedData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	NSString* errorText = [[NSString alloc] initWithFormat:@"Load Failed! Error - %@", [error localizedDescription]];
	
	[_delegate contentLoadingFailed:errorText];

}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	[receivedData writeToFile:fullPath atomically:YES];
	[_delegate contentLoaded:fullPath];
}

@end
