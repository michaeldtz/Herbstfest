//
//  SocialViewViewController.h
//  Herbstfest2
//
//  Created by Michael Dietz on 24.07.13.
//  Copyright (c) 2013 Michael Dietz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>

@interface SocialViewViewController : UIViewController{
    
    IBOutlet UIScrollView* feedContainer;
    IBOutlet UIActivityIndicatorView* loading;
    
}



-(IBAction)reloadPicturesFromInstagram;
-(void)showFeeds;


-(IBAction)openInstagram;
-(IBAction)openTweet;
-(IBAction)openFacebook;


@end
