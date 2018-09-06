//
//  MapDataUpdate.h
//  DieMauer
//
//  Created by Dietz, Michael on 9/4/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FileLoaderAndCacher.h"


@protocol NewProgramArrivalDelegate

@required
-(void)newProgramArrived;
-(void)noNewProgramArrived;

@end

@class Connection;

@interface ProgramUpdateLoader : NSObject <FileLoaderDelegate> {

	Connection* connection;
	id<NewProgramArrivalDelegate> _delegate;


	int  newestVersion;
}

-(void)checkForProgramUpdate:(id<NewProgramArrivalDelegate>) delegate;

@end
