//
//  DirectionsView.h
//  Herbstfest
//
//  Created by Michael Dietz on 28.07.11.
//  Copyright 2011 MD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "MKMapView+ZoomLevel.m"

@interface DirectionsView : UIViewController <MKMapViewDelegate> {
    
    MKMapView* mapView;
    
    CLLocationCoordinate2D rokLocationPin;
    CLLocationCoordinate2D rokLocationZoom;
    int zoomLevel;
}

@property(retain) IBOutlet MKMapView* mapView;

-(IBAction)zoomIn;
-(IBAction)zoomOut;
-(IBAction)gotToMapApp;

@end
