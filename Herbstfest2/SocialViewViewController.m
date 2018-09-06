//
//  SocialViewViewController.m
//  Herbstfest2
//
//  Created by Michael Dietz on 24.07.13.
//  Copyright (c) 2013 Michael Dietz. All rights reserved.
//

#import "SocialViewViewController.h"
#import "FeedLoader.h"
#import "ModelPersistanceManager.h"
#import "Feed.h"
#import "SocialImageView.h"
#import "SocialTextView.h"

@interface SocialViewViewController ()

@end

@implementation SocialViewViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(IBAction)openInstagram{
    //
    NSURL *instagramURL = [NSURL URLWithString:@"instagram://camera&tag?name=HerbstfestRok"];
    if ([[UIApplication sharedApplication] canOpenURL:instagramURL]) {
        [[UIApplication sharedApplication] openURL:instagramURL];
    } else {
        NSURL *instagramWebURL = [NSURL URLWithString:@"http://instagram.com/"];
        [[UIApplication sharedApplication] openURL:instagramWebURL];        
    }
}
-(IBAction)openTweet{
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *tweetSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        [tweetSheet setInitialText:@"#HerbstfestRok "];
        [self presentViewController:tweetSheet animated:YES completion:nil];
    }
}
-(IBAction)openFacebook{
    
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
    {
        SLComposeViewController *fbSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        [fbSheet setInitialText:@"#HerbstfestRok "];
        [self presentViewController:fbSheet animated:YES completion:nil];
    }
}


-(void)clearFeeds{

    //Clear View
    for (UIView *view in feedContainer.subviews) {
        if([view isKindOfClass:[SocialImageView class]]){
            [view removeFromSuperview];
        }
        if([view isKindOfClass:[SocialTextView class]]){
            [view removeFromSuperview];
       }
    }
    
}


-(IBAction)reloadPicturesFromInstagram{
    
    [loading startAnimating];
    [feedContainer scrollsToTop];
    [self clearFeeds];
    
    FeedLoader* insta = [[FeedLoader alloc] init];
    [insta loadInstagramFeedAndStoreToCoreData:^{
        [self showFeeds];
    }];
    
}

-(void)showFeeds{
    
    [self clearFeeds];
    
    ModelPersistanceManager* model = [ModelPersistanceManager getInstance];
    NSManagedObjectContext *context = [model getManagedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Feed" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    NSError *error;
    NSArray *items = [context executeFetchRequest:fetchRequest error:&error];
    
    [loading stopAnimating];
    
    //Decide about reloading
    if([items count] == 0){
        
        [self reloadPicturesFromInstagram];
        return;
        
    } else {
        
        BOOL lane1Placed = NO;
        
        int imgNextY  = 20;
        int imgNextX  = 90;
        int textNextX = 90;

        
        for (NSManagedObject *managedObject in items) {
            
            Feed* feed = (Feed*)managedObject;
            
            if(feed.imageURL == nil || [feed.imageURL isEqualToString:@""]){
                
                NSNumber* imgH   = feed.imgHeight;
                int imgHint = [imgH intValue];
                
                if(imgHint <= 40)
                    imgHint = 40;
                

                int x      = textNextX;
                int y      = 20;
            
                int width  = 280;
                int height = 40;

                
                NSString* imageName = @"leaf.png";
                if([feed.type isEqualToString:@"Facebook"]){
                    imageName = @"fblogo.png";
                } else if([feed.type isEqualToString:@"Twitter"]){
                    imageName = @"twitterLogo.png";
                } else if([feed.type isEqualToString:@"Instagram"]){
                    imageName = @"instgram.png";
                }
                
                SocialTextView* textView = [[SocialTextView alloc] initWithFrame:CGRectMake(y, x, width, height)];
                [textView setText:feed.text andImage:imageName];
                [feedContainer addSubview:textView];
                
                
                textNextX = textNextX + textView.frame.size.height + 10;
                if(lane1Placed == NO){
                    imgNextX = textNextX;
                }

                
            } else {
            
                NSNumber* imgH   = feed.imgHeight;
                NSNumber* imgW   = feed.imgWidth;
                
                int imgHint = [imgH intValue];
                int imgWint = [imgW intValue];
                
                if(imgH == 0 || imgW == 0)
                    continue;
                
                int width  = 130;
                int height = (imgHint / imgWint) * width;
                int x      = imgNextX;
                int y      = imgNextY;
                
                //Define Size
                if(lane1Placed == NO){
                
                    imgNextY = 170;
                    textNextX = x + height + 10;
                    lane1Placed = YES;
                    
                } else {
                    
                    imgNextY = 20;
                    imgNextX = textNextX;
                    lane1Placed = NO;
                }
                
                
                SocialImageView* imageView = [[SocialImageView alloc] initWithFrame:CGRectMake(y, x, width, height)];
                [imageView setImageURL:feed.imageURL andText:feed.text];
                imageView.backgroundColor= [UIColor blackColor];
                [feedContainer addSubview:imageView];
                
            }
            
        }
        
        
        
        int maxSize = textNextX;
        
        [feedContainer setContentSize:(CGSizeMake(320, maxSize+40))];
        
    }
    
}



- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidLoad];
    [self showFeeds];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
