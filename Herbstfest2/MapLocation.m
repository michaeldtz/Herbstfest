	//
	//  PointOfInterest.m
	//  MapGame
	//
	//  Created by Michael Dietz on 07.07.10.
	//  Copyright 2010 __MyCompanyName__. All rights reserved.
	//

#import "MapLocation.h"


@implementation MapLocation

@synthesize annView, viewTitle, viewSubtitle, parentViewController, coord, zoomType;


-(CLLocationCoordinate2D)coordinate{
	return coord;
}

- (NSString *)title{
	return title;
}

- (NSString *)subtitle{
	return subtitle;
}

-(MKAnnotationView *) mapView:(MKMapView *)mapView{
	
	annView = [[MKPinAnnotationView alloc] initWithAnnotation:self reuseIdentifier:@"PLACE"];
	
		//Options
	annView.pinColor = MKPinAnnotationColorRed;
	annView.animatesDrop = TRUE;
	annView.canShowCallout = YES;
	annView.draggable = NO;
	annView.calloutOffset = CGPointMake(-5, 5);
	
	return annView;
}

#pragma mark Dealloc


@end
