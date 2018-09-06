//
//  LazyImageView.m
//  Herbstfest2
//
//  Created by Michael Dietz on 22.08.13.
//  Copyright (c) 2013 Michael Dietz. All rights reserved.
//

#import "SocialImageView.h"

@implementation SocialImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, frame.size.width -10, frame.size.height -10)];
        self.backgroundColor = [UIColor blackColor];
        _imageView.backgroundColor = [UIColor blackColor];
        [self addSubview:_imageView];
        
        tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgToFullScreen)];
        [self addGestureRecognizer:tap];
    }
    return self;
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch;
{
    BOOL shouldReceiveTouch = YES;
    
    if (gestureRecognizer == tap) {
        if(touch.view == self)
            shouldReceiveTouch = YES;
        else if (touch.view == fullView)
            shouldReceiveTouch = YES;
        
        shouldReceiveTouch = NO;
    }
    
    return shouldReceiveTouch;
}

-(void)closeFullScreen{
    [fullView removeFromSuperview];
    [fullView removeGestureRecognizer:tap2];
    fullView = nil;
}

-(void)imgToFullScreen{
    
    CGRect fullRect = [[UIScreen mainScreen] bounds];
    CGRect imgRect  = _imageView.frame;
    
    float imgWidth  = 280;
    float imgHeight = (imgRect.size.height / imgRect.size.width) * imgWidth;
    
    if(imgHeight > 280){
        imgHeight = 280;
        imgWidth  = (imgRect.size.width / imgRect.size.height) * imgHeight;
    }
    
    CGRect imageRect = CGRectMake(20, 20, imgWidth, imgHeight);
    CGRect textRect = CGRectMake(20, imgHeight + 30, 280, fullRect.size.height - imgHeight - 30 - 20);
    
    
    UIImageView *fullImageView = [[UIImageView alloc] initWithFrame:imageRect];
    [fullImageView setImage:_imageView.image];
    
    UITextView* textView = [[UITextView alloc] initWithFrame:textRect];
    textView.editable = NO;
    textView.backgroundColor = [UIColor clearColor];
    [textView setText:_imageText];
    
    fullView      = [[UIView alloc] initWithFrame:fullRect];
    fullView.backgroundColor = self.superview.superview.backgroundColor;
    [fullView addSubview:fullImageView];
    [fullView addSubview:textView];
    
    
    //Register Tap to close
    tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeFullScreen)];
    [fullView addGestureRecognizer:tap2];
    
    
    [self.superview.superview.superview addSubview:fullView];
    
}



-(void)setImageURL:(NSString*)url andText:(NSString*)text{
    _imageURL = url;
    _imageText = text;
    [[ImageLoader alloc] loadImageAndCacheForFeed:_imageURL :self];
}

-(void)     imageLoaded:(NSData*)imgData{
    UIImage* image = [UIImage imageWithData:imgData];
    [_imageView setImage:image];
    [_imageView setContentMode:UIViewContentModeScaleAspectFill];
    //UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(y, x, width, height)];
    
}

-(void)     imageLoadError:(NSString*)error{
    
}

@end
