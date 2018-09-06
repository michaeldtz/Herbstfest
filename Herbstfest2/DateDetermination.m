//
//  DateDetermination.m
//  Herbstfest2
//
//  Created by Michael Dietz on 23.08.15.
//  Copyright (c) 2015 Michael Dietz. All rights reserved.
//

#import "DateDetermination.h"

@implementation DateDetermination

-(NSDate*) determineThisYearsHerbsfestStart{
    
    NSDate* nullDate;
    NSCalendar* cal = [NSCalendar currentCalendar];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    dateFormat.dateFormat = @"dd.MM.yyyy-HH:mm:ss";
    
    long thisYear = [[cal components:NSYearCalendarUnit fromDate:[NSDate date]] year];

    int cnt = 2;
    
    //Find second Saturday in September
    for(int i = 1; i < 22; i++){
        
        NSString* dateString = [NSString stringWithFormat:@"%.2d.09.%ld-12:00:00",i,thisYear];
        NSDate* date = [dateFormat dateFromString:dateString];
        long weekday = [[cal components:NSWeekdayCalendarUnit fromDate:date] weekday];
        
        if(weekday == 7){
            if(--cnt == 0){
                NSString* fridayStartDateString = [NSString stringWithFormat:@"%.2d.09.%ld-19:00:00",(i-1),thisYear];
                NSLog(@"Herbsfest start is %@", fridayStartDateString);
                NSDate* fridayStartDate = [dateFormat dateFromString:fridayStartDateString];
                return fridayStartDate;
            }
        }
        
    }
    
    return nullDate;
    
}

-(NSDate*) determineThisYearsHerbsfestEnd{
    
    NSDate* nullDate;
    
    NSCalendar* cal = [NSCalendar currentCalendar];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    dateFormat.dateFormat = @"dd.MM.yyyy-HH:mm:ss";
    
    long thisYear = [[cal components:NSYearCalendarUnit fromDate:[NSDate date]] year];
    
    int cnt = 2;
    
    //Find second Saturday in September
    for(int i = 1; i < 22; i++){
        
        NSString* dateString = [NSString stringWithFormat:@"%.2d.09.%ld-12:00:00",i,thisYear];
        NSDate* date = [dateFormat dateFromString:dateString];
        long weekday = [[cal components:NSWeekdayCalendarUnit fromDate:date] weekday];
        
        if(weekday == 7){
            if(--cnt == 0){
                NSString* mondayEndDateString = [NSString stringWithFormat:@"%.2d.09.%ld-23:59:59",(i+2),thisYear];
                NSLog(@"Herbsfest end is %@", mondayEndDateString);
                NSDate* mondayEndDate = [dateFormat dateFromString:mondayEndDateString];
                return mondayEndDate;
            }
        }
    }
    
    return nullDate;
    
}

-(NSDate*) determineNextYearsHerbstfestStart{
    
    NSDate* nullDate;
    NSCalendar* cal = [NSCalendar currentCalendar];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    dateFormat.dateFormat = @"dd.MM.yyyy-HH:mm:ss";
    
    long nextYear = ([[cal components:NSYearCalendarUnit fromDate:[NSDate date]] year])+1;
    
    int cnt = 2;
    
    //Find second Saturday in September
    for(int i = 1; i < 22; i++){
        
        NSString* dateString = [NSString stringWithFormat:@"%.2d.09.%ld-12:00:00",i,nextYear];
        NSDate* date = [dateFormat dateFromString:dateString];
        long weekday = [[cal components:NSWeekdayCalendarUnit fromDate:date] weekday];
        
        if(weekday == 7){
            if(--cnt == 0){
                NSString* fridayStartDateString = [NSString stringWithFormat:@"%.2d.09.%ld-19:00:00",(i-1),nextYear];
                NSLog(@"Herbsfest next year start is %@", fridayStartDateString);
                NSDate* fridayStartDate = [dateFormat dateFromString:fridayStartDateString];
                return fridayStartDate;
            }
        }
        
    }
    
    return nullDate;
    
}


@end
