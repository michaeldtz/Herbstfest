//
//  CountdownNumber.h
//  Herbstfest
//
//  Created by Dietz, Michael on 7/25/11.
//  Copyright 2011 MD. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CountdownNumber : UIView {

	NSString* value;
	
	int xouter;
	int youter;
	int inner;
	
	UIColor* background;
	UIColor* sheet1;
	UIColor* sheet2;
	UIColor* text;
	
}

@property(retain) NSString* value;

@property(assign) int outer;
@property(assign) int inner;

@property(retain) UIColor* background;
@property(retain) UIColor* sheet1;
@property(retain) UIColor* sheet2;
@property(retain) UIColor* text;


-(id)initWithFrame:(CGRect)frame value:(NSString*)text andTag:(NSInteger)tag;
-(void)drawGradientRect:(CGContextRef)ctx :(CGRect)rect :(CGFloat*)colors;

@end
