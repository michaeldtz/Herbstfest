//
//  MapDataUpdate.m
//  DieMauer
//
//  Created by Dietz, Michael on 9/4/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ProgramUpdateLoader.h"
#import "Connection.h"

#define BASE_URL @"http://space-labs.appspot.com/repo/268001/"
#define VERBOSE 0

@implementation ProgramUpdateLoader

#pragma mark External Map Data Loading

-(void)checkForProgramUpdate:(id<NewProgramArrivalDelegate>) delegate{
	_delegate = delegate;
    
#if VERBOSE >= 1
	NSLog(@"Check for Program Update");
#endif
    
	NSString* url = [NSString stringWithFormat:@"%@%@", BASE_URL, @"contentversion"];
	
	connection = [[Connection alloc] init];
	[connection callURLAsync:url:self];	
}


-(void)loadContentAndStoreWithFilename:(NSString*)filename{
	FileLoaderAndCacher* fileLoader = [[FileLoaderAndCacher alloc] init];
	NSArray*  paths     = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString* path      = [paths objectAtIndex:0];
	NSString* fullPath  = [path stringByAppendingPathComponent:filename];
	NSString* url = [NSString stringWithFormat:@"%@%@", BASE_URL, filename];
	[fileLoader loadFileAsync:url :self :fullPath];
}

#pragma mark Delegate of Connection

-(void)     dataLoadingSuccessful:(NSString*)resultString{
    
#if VERBOSE >= 1
	NSLog(@"New Program Version Received");
#endif
    
	if(resultString != nil){
        newestVersion = [resultString intValue];
		int localVersion = (int)[[NSUserDefaults standardUserDefaults] integerForKey:@"programversion"];
        
#if VERBOSE >= 1
		NSLog(@"Program Version on iPhone is %d , newest Version is %d", localVersion, newestVersion);
#endif
        
		if(newestVersion > localVersion){
            
#if VERBOSE >= 1
			NSLog(@"Start Loading Program Update");
#endif
			[self loadContentAndStoreWithFilename:@"program.plist"];
			 connection = nil;
			return;
		}
	}
	
	connection = nil;
	[_delegate noNewProgramArrived];
	
}


-(void)     dataLoadingError:(NSString*) errorText{
    
#if VERBOSE >= 1
	NSLog(@"Error Checking Program Version: %@", errorText);
#endif
    
	connection = nil;
	[_delegate noNewProgramArrived];
}


#pragma mark Delegate of FileLoader

-(void) fileLoadingFinished:(BOOL)success :(NSString*)message{
    if(success == YES){
        
#if VERBOSE >= 1
        NSLog(@"Update Program Loading Finished");
#endif
        
        [[NSUserDefaults standardUserDefaults] setInteger:newestVersion forKey:@"programversion"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [_delegate newProgramArrived];
    } else{
        [_delegate noNewProgramArrived];
    }
}





@end
