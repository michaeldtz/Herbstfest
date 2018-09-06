//
//  ShareLocation.h
//  Herbstfest2
//
//  Created by Michael Dietz on 25.08.15.
//  Copyright (c) 2015 Michael Dietz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface ShareLocation : NSObject

@property (nonatomic) CLLocationManager *fgLocationManager;
@property (nonatomic) CLLocationManager *bgLocationManager;

@property (nonatomic) NSMutableArray    *loctionChanges;

@property (nonatomic) BOOL isFGRunning;
@property (nonatomic) BOOL isBGRunning;

+(id)sharedLocationModel;
-(void)addLocationChange:(CLLocation*)loction;
-(long)getMinutesInZelt;
-(bool)isInZelt;
-(CLRegion*)region;

@end
