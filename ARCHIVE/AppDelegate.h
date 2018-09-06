//
//  AppDelegate.h
//  Herbstfest2
//
//  Created by Michael Dietz on 22.07.13.
//  Copyright (c) 2013 Michael Dietz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "ProgramUpdateLoader.h"
#import "ShareLocation.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, NewProgramArrivalDelegate, CLLocationManagerDelegate> {
    
    CLLocationManager* locationManager;
    
}

@property (strong, nonatomic) UIWindow *window;



@end
