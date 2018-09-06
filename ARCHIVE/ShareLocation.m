//
//  ShareLocation.m
//  Herbstfest2
//
//  Created by Michael Dietz on 25.08.15.
//  Copyright (c) 2015 Michael Dietz. All rights reserved.
//

#import "ShareLocation.h"

@implementation ShareLocation

//Class method to make sure the share model is synch across the app
+ (id)sharedLocationModel
{
    static id sharedMyModel = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyModel = [[self alloc] init];
    });
    return sharedMyModel;
}

-(void)addLocationChange:(CLLocation*)loction{
    
    CLLocation *location = [[CLLocation alloc] initWithLatitude:49.624898 longitude:7.820975];
    CLRegion* zeltRegion = [[CLCircularRegion alloc] initWithCenter:[location coordinate] radius:200 identifier:@"HERBSTFESTZELT"];
    
    
    NSLog(@"LOCATION CHANGED");
    
}

-(long)getMinutesInZelt{
    return 35;
}

-(bool)isInZelt{
    return YES;
}

-(CLRegion*)region{
    CLLocation *location = [[CLLocation alloc] initWithLatitude:49.624898 longitude:7.820975];
    CLRegion* zeltRegion = [[CLCircularRegion alloc] initWithCenter:[location coordinate] radius:200 identifier:@"HERBSTFESTZELT"];
    return zeltRegion;
}

@end
