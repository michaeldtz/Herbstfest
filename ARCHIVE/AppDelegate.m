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
    
    if([[UIApplication sharedApplication] backgroundRefreshStatus] != UIBackgroundRefreshStatusDenied &&
       [[UIApplication sharedApplication] backgroundRefreshStatus] != UIBackgroundRefreshStatusRestricted){
        
        if ([launchOptions objectForKey:UIApplicationLaunchOptionsLocationKey]) {
            
            NSLog(@"Receiving UIApplicationLaunchOptionsLocationKey");
            
            bool active = [[NSUserDefaults standardUserDefaults] boolForKey:@"ZZ_ACTIVE"];
            
            if(active == YES){
                
                ShareLocation* shareLocationModel = [ShareLocation sharedLocationModel];
                
                if(shareLocationModel.bgLocationManager == nil){
                    
                    
                    shareLocationModel.bgLocationManager = [[CLLocationManager alloc]init];
                    
                    shareLocationModel.bgLocationManager.delegate = self;
                    shareLocationModel.bgLocationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
                    shareLocationModel.bgLocationManager.activityType = CLActivityTypeOther;
                    
                    [shareLocationModel.bgLocationManager requestAlwaysAuthorization];
                    [shareLocationModel.bgLocationManager pausesLocationUpdatesAutomatically];
                }
                
                [shareLocationModel.bgLocationManager startMonitoringForRegion:[shareLocationModel region]];
                
                
            }
        }
    }
    
    return YES;
}




- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    
}


-(void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region{
    NSLog(@"BG LOCATION DID ENTER REGION");
    ShareLocation* shareLocationModel = [ShareLocation sharedLocationModel];
    [shareLocationModel addLocationChange:[locationManager location]];
}

-(void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region{
    NSLog(@"BG LOCATION DID EXIT REGION");
    ShareLocation* shareLocationModel = [ShareLocation sharedLocationModel];
    [shareLocationModel addLocationChange:[locationManager location]];
}



- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [[[ProgramUpdateLoader alloc] init] checkForProgramUpdate:self];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
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
