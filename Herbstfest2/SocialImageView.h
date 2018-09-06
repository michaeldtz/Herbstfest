//
//  LazyImageView.h
//  Herbstfest2
//
//  Created by Michael Dietz on 22.08.13.
//  Copyright (c) 2013 Michael Dietz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageLoader.h"

@interface SocialImageView : UIView <ImageLoaderDelegate>{
    NSString*    _imageURL;
    NSString*    _imageText;
    UIImageView* _imageView;
    
    
    UITapGestureRecognizer *tap;
    UITapGestureRecognizer *tap2;
    
    BOOL isFullScreen;
    CGRect prevFrame;
    CGRect prevImageFrame;
    UIView* fullView;
    
}

-(void)setImageURL:(NSString*)url andText:(NSString*)text;

@end
