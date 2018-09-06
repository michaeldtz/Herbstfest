//
//  DirectionsView.m
//  Herbstfest
//
//  Created by Michael Dietz on 28.07.11.
//  Copyright 2011 MD. All rights reserved.
//

#import "DirectionsView.h"
#import "MapLocation.h"

@implementation DirectionsView

@synthesize mapView;



#pragma mark UI Actions

-(IBAction)zoomIn{
    zoomLevel += 3;
    if(zoomLevel > 16)
        zoomLevel = 16;
    
    if(zoomLevel >= 13)    
        [self.mapView setCenterCoordinate:rokLocationPin zoomLevel:zoomLevel animated:YES];
    else
        [self.mapView setCenterCoordinate:rokLocationZoom zoomLevel:zoomLevel animated:YES];
}

-(IBAction)zoomOut{
    zoomLevel -= 3;
    if(zoomLevel < 7)
        zoomLevel = 7;
    
    if(zoomLevel >= 13)    
        [self.mapView setCenterCoordinate:rokLocationPin zoomLevel:zoomLevel animated:YES];
    else
        [self.mapView setCenterCoordinate:rokLocationZoom zoomLevel:zoomLevel animated:YES];
}

-(IBAction)gotToMapApp{
    [[UIApplication sharedApplication] openURL:[[NSURL alloc] initWithString: @"http://maps.google.com/maps?q=49.624786,7.820911"]];
}

#pragma mark - View lifecycle

-(void)viewDidAppear:(BOOL)animated{
    
    zoomLevel = 10;
    
    [self.mapView setCenterCoordinate:rokLocationZoom zoomLevel:zoomLevel animated:NO];

}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    //Initialize Coordinates    
    rokLocationPin.latitude = 49.624786;
    rokLocationPin.longitude = 7.820911;
    
    //For the outer zoom so that rok is more in the center
    rokLocationZoom.latitude = 49.598786;
    rokLocationZoom.longitude = 7.820911;
    
    //Add Pin
    MapLocation* pin = [[MapLocation alloc] init];
    pin.coord = rokLocationPin;
    pin.viewTitle = @"Herbstfest 2011";
    pin.viewSubtitle = @"Festgelände";
    [self.mapView addAnnotation:pin];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
