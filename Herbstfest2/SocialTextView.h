//
//  SocialTextView.h
//  Herbstfest2
//
//  Created by Michael Dietz on 20.08.14.
//  Copyright (c) 2014 Michael Dietz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SocialTextView : UIView {

    NSString*    _text;
    UITextView* _textView;
    UIImageView* _logoView;
}



-(void)setText:(NSString*)text andImage:(NSString*)image;


@end
