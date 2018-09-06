//
//  ZeltZeitViewController.m
//  Herbstfest2
//
//  Created by Michael Dietz on 24.08.15.
//  Copyright (c) 2015 Michael Dietz. All rights reserved.
//

#import "ZeltZeitViewController.h"

@implementation ZeltZeitViewController

-(void)viewDidLoad{
    
    /* [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"ZZ_NICKNAME"];
     [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"ZZ_ACTIVE"];*/
    
    [self checkIfActive];
    
}

-(void)viewDidAppear:(BOOL)animated{
    NSLog(@"ViewDIDAPPEAR");
    if(timer != nil){
        [timer  invalidate];
    }
    
    timer = [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(timer60Tick) userInfo:nil repeats:YES];
    [timer fire];
    
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(appEnteredBackground:)
                                                 name: UIApplicationDidEnterBackgroundNotification
                                               object: nil];
}

-(void)viewWillDisappear:(BOOL)animated{
   [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)appEnteredBackground:(NSNotification *)appEnteredBackgroundNotification {
    if(timer != nil){
        [timer  invalidate];
    }
    timer = nil;
}


-(void)checkIfActive{
    
    bool active = [[NSUserDefaults standardUserDefaults] boolForKey:@"ZZ_ACTIVE"];
    
    if(active == true){
        [initialView setHidden:YES];
        [initialView setUserInteractionEnabled:NO];
        [activeView setHidden:NO];
        [activeView setUserInteractionEnabled:YES];
        [self startZeltZeit];
    } else {
        [initialView setHidden:NO];
        [initialView setUserInteractionEnabled:YES];
        [activeView setHidden:YES];
        [activeView setUserInteractionEnabled:NO];
    }
}

-(void)askForNickname{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Name für die Highscore" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.keyboardType = UIKeyboardTypeAlphabet;
        textField.placeholder = @"Spitzname";
    }];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction *action) {
                                                         UITextField *textField = [alert.textFields firstObject];
                                                         [[NSUserDefaults standardUserDefaults] setValue:[textField text] forKey:@"ZZ_NICKNAME"];
                                                         [self activateZeltZeit];
                                                     }];
    
    [alert addAction:okAction];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction *action) {
                                                             //[self dismissViewControllerAnimated:YES completion:nil];
                                                         }];
    
    [alert addAction:cancelAction];
    
    [self presentViewController:alert animated:YES completion:nil];
    
    
}



-(IBAction)activateZeltZeit{
    
    if([[UIApplication sharedApplication] backgroundRefreshStatus] == UIBackgroundRefreshStatusDenied){
        
        UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"Fehler"
                                                         message:@"Zeltzeit kann nicht aktiviert werden, da die App keine Berechtigung hat im Hintergrund zu laufen"
                                                        delegate:nil
                                               cancelButtonTitle:@"Ok"
                                               otherButtonTitles:nil, nil];
        [alert show];
        return;
        
    } else if([[UIApplication sharedApplication] backgroundRefreshStatus] == UIBackgroundRefreshStatusRestricted){
        
        UIAlertView*  alert = [[UIAlertView alloc]initWithTitle:@"Fehler"
                                                          message:@"Zeltzeit kann nicht aktiviert werden, da die App keine Berechtigung hat im Hintergrund zu laufen."
                                                         delegate:nil
                                                cancelButtonTitle:@"Ok"
                                                otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    
    bool active = [[NSUserDefaults standardUserDefaults] boolForKey:@"ZZ_ACTIVE"];
    
    if(active != true){
        NSString* nickname = [[NSUserDefaults standardUserDefaults] stringForKey:@"ZZ_NICKNAME"];
        if(nickname == nil){
            [self askForNickname];
        } else {
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"ZZ_ACTIVE"];
            [self checkIfActive];
        }
    }
    
}

-(void)timer60Tick {
    
    bool active = [[NSUserDefaults standardUserDefaults] boolForKey:@"ZZ_ACTIVE"];
    
    if(active == YES){
        NSString* nickname = [[NSUserDefaults standardUserDefaults] stringForKey:@"ZZ_NICKNAME"];
        ShareLocation* shareLocationModel = [ShareLocation sharedLocationModel];
        
        
        if([shareLocationModel isInZelt]){
            zeltzeitLbl.textColor = [UIColor greenColor];
            [inOutLbl setText:[NSString stringWithFormat:@"%@, Du bist im Zelt",nickname]];
        } else {
            zeltzeitLbl.textColor = [UIColor redColor];
            [inOutLbl setText:[NSString stringWithFormat:@"%@, Du bist leider nicht im Zelt",nickname]];
        }
        
        
        long minutes = [shareLocationModel getMinutesInZelt];
        
        [zeltzeitLbl setText:[NSString stringWithFormat:@"Zeltzeit : %ld Minuten", minutes]];
        
        NSLog(@"TIMER FIRED");
        
    }
}


- (IBAction)startZeltZeit
{
    
    ShareLocation* shareLocationModel = [ShareLocation sharedLocationModel];
    
    if (nil == shareLocationModel.fgLocationManager)
        shareLocationModel.fgLocationManager = [[CLLocationManager alloc] init];
    
    
    shareLocationModel.fgLocationManager.delegate = self;
    shareLocationModel.fgLocationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    shareLocationModel.fgLocationManager.activityType = CLActivityTypeOther;
    
    [shareLocationModel.fgLocationManager requestAlwaysAuthorization];
    [shareLocationModel.fgLocationManager startMonitoringSignificantLocationChanges];
    
    //Check if current location is in region
    CLLocation* currentloc = [shareLocationModel.fgLocationManager location];
    [shareLocationModel addLocationChange:currentloc];
    
    NSLog(@"Location Listening FG Startet");
    
    
}

/*

-(void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region{
    NSLog(@"FG LOCATION DID ENTER REGION");
    ShareLocation* shareLocationModel = [ShareLocation sharedLocationModel];
    [shareLocationModel addLocationChange:[manager location]];
}

-(void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region{
    NSLog(@"FG LOCATION DID EXIT REGION");
    ShareLocation* shareLocationModel = [ShareLocation sharedLocationModel];
    [shareLocationModel addLocationChange:[manager location]];
}
*/

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    NSLog(@"FG LOCATION UPDATE");
    ShareLocation* shareLocationModel = [ShareLocation sharedLocationModel];
    [shareLocationModel addLocationChange:[locations objectAtIndex:0]];
    
}





@end
