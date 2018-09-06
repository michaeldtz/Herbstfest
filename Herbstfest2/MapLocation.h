	//
	//  PointOfInterest.h
	//  MapGame
	//
	//  Created by Michael Dietz on 07.07.10.
	//  Copyright 2010 __MyCompanyName__. All rights reserved.
	//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@class MainViewController;

@interface MapLocation : MKAnnotationView <MKAnnotation>  {
	
	MKPinAnnotationView* annView;
	MainViewController* parentViewController;
	CLLocationCoordinate2D coord;
	
    NSString* title;
	NSString* subtitle;

	BOOL      alreadyFalling;
	int       zoomType;
}



@property MainViewController* parentViewController;
@property MKPinAnnotationView* annView;
@property CLLocationCoordinate2D coord;
@property NSString* viewTitle;
@property NSString* viewSubtitle;

@property(assign) int       zoomType;

-(MKAnnotationView *) mapView:(MKMapView *)mapView;

@end
