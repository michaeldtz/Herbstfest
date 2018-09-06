//
//  DateDetermination.h
//  Herbstfest2
//
//  Created by Michael Dietz on 23.08.15.
//  Copyright (c) 2015 Michael Dietz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateDetermination : NSObject

-(NSDate*) determineThisYearsHerbsfestStart;
-(NSDate*) determineThisYearsHerbsfestEnd;
-(NSDate*) determineNextYearsHerbstfestStart;

@end
