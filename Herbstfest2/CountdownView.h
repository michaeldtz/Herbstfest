//
//  Countdown.h
//  Herbstfest
//
//  Created by Dietz, Michael on 7/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CountdownNumber.h"
#import "DateDetermination.h"

#ifndef IBOutletCollection
#define IBOutletCollection(CountdownNumber)
#endif

@interface CountdownView : UIViewController {
    
	NSTimer* timer;
	
    UILabel* infoText;
    UILabel* timeText;
    
    BOOL moved;
    int mode;
    
	CountdownNumber* cd_days_T;
	CountdownNumber* cd_days_A;
	CountdownNumber* cd_days_G;
	CountdownNumber* cd_days_E;
	CountdownNumber* cd_days_S;
	CountdownNumber* cd_days_V1;
	CountdownNumber* cd_days_V2;
	
	CountdownNumber* cd_hors_S;
	CountdownNumber* cd_hors_T;
	CountdownNumber* cd_hors_U;
	CountdownNumber* cd_hors_N;
	CountdownNumber* cd_hors_D;
	CountdownNumber* cd_hors_V1;
	CountdownNumber* cd_hors_V2;
	
	CountdownNumber* cd_minu_M;
	CountdownNumber* cd_minu_I;
	CountdownNumber* cd_minu_N;
	CountdownNumber* cd_minu_U;
	CountdownNumber* cd_minu_S;
	CountdownNumber* cd_minu_V1;
	CountdownNumber* cd_minu_V2;
	
	CountdownNumber* cd_seco_S;
	CountdownNumber* cd_seco_E;
	CountdownNumber* cd_seco_K;
	CountdownNumber* cd_seco_U;
	CountdownNumber* cd_seco_N;
	CountdownNumber* cd_seco_V1;
	CountdownNumber* cd_seco_V2;

    NSArray* allCountdownELements;
	
}

+(NSTimeInterval)getIntervalToHerbstfest;
+(NSTimeInterval)getIntervalToEndOfHerbstfest;
+(NSTimeInterval)getIntervalToNextHerbstfest;

@property(retain) IBOutlet UILabel* infoText;
@property(retain) IBOutlet UILabel* timeText;


@property (nonatomic, retain) IBOutletCollection(CountdownNumber) NSArray *allCountdownELements;


@end
