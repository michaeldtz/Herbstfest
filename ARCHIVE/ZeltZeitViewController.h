//
//  ZeltZeitViewController.h
//  Herbstfest2
//
//  Created by Michael Dietz on 24.08.15.
//  Copyright (c) 2015 Michael Dietz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "ShareLocation.h"

@interface ZeltZeitViewController : UIViewController <CLLocationManagerDelegate> {
        
    NSTimer *timer;
    
    IBOutlet UIView* initialView;
    IBOutlet UIView* activeView;
    
    IBOutlet UILabel* zeltzeitLbl;
    IBOutlet UILabel* inOutLbl;
    IBOutlet UITableView* tableView;
}

-(IBAction)activateZeltZeit;
- (IBAction)startZeltZeit;

@end
