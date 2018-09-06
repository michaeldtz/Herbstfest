//
//  CountdownNumber.m
//  Herbstfest
//
//  Created by Dietz, Michael on 7/25/11.
//  Copyright 2011 MD. All rights reserved.
//

#import "CountdownNumber.h"


@implementation CountdownNumber

@synthesize outer, inner, background, sheet1, sheet2, text;

-(id)initWithFrame:(CGRect)frame value:(NSString*)aValue andTag:(NSInteger)tag{
    self = [super initWithFrame:frame];
    self.value = aValue;
    self.tag = tag;
    
    if (self) {
		
		if(self.tag >= 1000){
			xouter = 6;
			youter = 3;
			inner = 1;
			background = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
			sheet1 = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1];
			sheet2 = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1];
			text = [UIColor colorWithRed:0.05 green:0.05 blue:0.05 alpha:1];
			self.backgroundColor = [UIColor clearColor];
		} else {
			xouter = 6;
			youter = 3;
			inner = 1;
			background = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
			sheet1 = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:1];
			sheet2 = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1];
			text = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
			self.backgroundColor = [UIColor clearColor];
		}
		
		//Auto Dertmine Value Based on Tags
		if(self.tag != 1000 && self.tag != 0){
			char c = self.tag;
			if(self.tag > 1000)
				c = (self.tag - 1000);
			unichar chr[] = { c };
			value = [[NSString alloc] initWithCharacters:chr length:1];
		}
		
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
	
	//Get Context
	CGContextRef ctx = UIGraphicsGetCurrentContext();
	
	//Fill Background
	CGContextSetFillColorWithColor(ctx, background.CGColor);
	CGContextFillRect(ctx, rect);
	
	//Fill Sheet Part 1
	const CGFloat* components = CGColorGetComponents(sheet1.CGColor);
	CGFloat colors1[] = {
		components[0],components[1],components[2],1.0,
		components[0],components[1],components[2],0.8 
	};
	CGRect sheet1Rect = CGRectMake(youter, xouter, rect.size.width - 2*youter, (rect.size.height/2) - inner);
	[self drawGradientRect:ctx:sheet1Rect:colors1];
	
	//Fill Sheet Part 2
	const CGFloat* components2 = CGColorGetComponents(sheet2.CGColor);	
	CGFloat colors2[] = {
		components2[0],components2[1],components2[2],1.0,
		components2[0],components2[1],components2[2],0.7
	};
	CGRect sheet2Rect = CGRectMake(youter, (rect.size.height/2) + inner, rect.size.width - 2*youter, (rect.size.height/2)- inner - xouter);
	[self drawGradientRect:ctx:sheet2Rect:colors2];
	
	//Draw Labels
	CGContextSetFillColorWithColor(ctx, text.CGColor);
	UIFont* font = [UIFont fontWithName:@"Arial-BoldMT" size:rect.size.height-12];
    NSDictionary *attributes = @{NSFontAttributeName:font,NSForegroundColorAttributeName:text};

    
	CGSize lblSize = [value sizeWithAttributes:attributes];
	CGRect lblRect = CGRectMake((rect.size.width - lblSize.width)/2, 5, lblSize.width, lblSize.height);
	[value drawInRect:lblRect withAttributes:attributes];
	
	//Draw Line
	CGContextSetFillColorWithColor(ctx, [UIColor colorWithRed:0 green:0 blue:0 alpha:1].CGColor);
	CGRect line = CGRectMake(0,rect.size.height / 2 , rect.size.width, 2*inner);
	CGContextFillRect(ctx, line);
	
}

-(void)drawGradientRect:(CGContextRef)ctx :(CGRect)rect :(CGFloat*)colors{
	CGContextSaveGState(ctx);
	CGMutablePathRef path = CGPathCreateMutable();
	CGPathAddRect(path, NULL, rect);
	CGContextAddPath(ctx, path);
	CGContextClip(ctx);
	CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
	CGGradientRef gradi = CGGradientCreateWithColorComponents(space, colors, NULL, 2);
	CGPoint startPoint = CGPointMake(0,rect.origin.y);
	CGPoint endPoint = CGPointMake(0,rect.origin.y + rect.size.height);
	CGContextDrawLinearGradient(ctx, gradi, startPoint, endPoint, 0);
	CGContextRestoreGState(ctx);
}

- (NSString *)value {
    return value;
}

- (void)setValue:(NSString *)aValue {
    if (aValue != value) {
        value = aValue;
		[self setNeedsDisplay];
    }
}


@end
