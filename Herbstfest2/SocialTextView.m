#//
//  SocialTextView.m
//  Herbstfest2
//
//  Created by Michael Dietz on 20.08.14.
//  Copyright (c) 2014 Michael Dietz. All rights reserved.
//

#import "SocialTextView.h"

@implementation SocialTextView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];

        int y = (frame.size.height-30)/2;
        
        _logoView = [[UIImageView alloc] initWithFrame:CGRectMake(5, y, 30, 30)];
        [self addSubview:_logoView];
        
        _textView = [[UITextView alloc] initWithFrame:CGRectMake(41, 0, frame.size.width-42, frame.size.height)];
        _textView.backgroundColor = [UIColor clearColor];
        _textView.editable = NO;
        [_textView setTextColor:[UIColor whiteColor]];
        _textView.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_textView];
        
        
    }
    return self;
}

-(void)setText:(NSString*)text andImage:(NSString*)image{
    _text = text;
    [_textView setText:_text];
    [_textView sizeToFit];
    
    int height = _textView.frame.size.height;
    int yplus = 0;
    if(height < 40){
        height = 40;
        yplus = (height - _textView.frame.size.height) /2;
        [_textView setFrame:CGRectMake(_textView.frame.origin.x, yplus, _textView.frame.size.width, _textView.frame.size.height)];
    }

    [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, height)];
    
    int y = (self.frame.size.height-30)/2;
    [_logoView setFrame:CGRectMake(5, y, 30, 30)];

    
    [_logoView setImage:[UIImage imageNamed:image]];
}

@end
