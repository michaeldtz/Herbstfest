//
//  DescriptionView.h
//  Herbstfest
//
//  Created by Michael Dietz on 07.08.11.
//  Copyright 2011 MD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DescriptionView : UIViewController{
    
    NSString* description;
    UITextView* textView;
}

@property (nonatomic, retain) NSString *description;
@property (nonatomic, retain) IBOutlet  UITextView* textView;

-(IBAction)back;

@end
