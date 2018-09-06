//
//  AppDelegate.m
//  Herbstfest2
//
//  Created by Michael Dietz on 22.07.13.
//  Copyright (c) 2013 Michael Dietz. All rights reserved.
//

#import "AppDelegate.h"
#import "ProgramView.h"


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    return YES;
}




- (void)applicationWillResignActive:(UIApplication *)application
{
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [[[ProgramUpdateLoader alloc] init] checkForProgramUpdate:self];
}

- (void)applicationWillTerminate:(UIApplication *)application
{

}

#pragma mark images update


#pragma mark Content Update

-(void)newProgramArrived{
    [ProgramView updateRequired];
}

-(void)noNewProgramArrived{
    //Nothing to do
}


@end
