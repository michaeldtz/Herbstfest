//
//  Countdown.m
//  Herbstfest
//
//  Created by Dietz, Michael on 7/23/11.
//  Copyright 2011 Michael Dietz. All rights reserved.
//

#import "CountdownView.h"

@implementation CountdownView



@synthesize allCountdownELements, infoText,timeText;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    

	
    int xStart = 30;
    int yStart = 110;
    
    cd_days_V1 = [[CountdownNumber alloc] initWithFrame:CGRectMake(xStart,        yStart, 35, 48) value:@"" andTag:0];
    cd_days_V2 = [[CountdownNumber alloc] initWithFrame:CGRectMake(xStart+=35,    yStart, 35, 48) value:@"" andTag:0];
    cd_days_T = [[CountdownNumber alloc] initWithFrame:CGRectMake(xStart+=60,     yStart, 35, 48) value:@"T" andTag:1000];
    cd_days_A = [[CountdownNumber alloc] initWithFrame:CGRectMake(xStart+=35,     yStart, 35, 48) value:@"A" andTag:1000];
    cd_days_G = [[CountdownNumber alloc] initWithFrame:CGRectMake(xStart+=35,     yStart, 35, 48) value:@"G" andTag:1000];
    cd_days_E = [[CountdownNumber alloc] initWithFrame:CGRectMake(xStart+=35,     yStart, 35, 48) value:@"E" andTag:1000];
    cd_days_S = [[CountdownNumber alloc] initWithFrame:CGRectMake(xStart+=35,     yStart, 35, 48) value:@"T" andTag:1000];
    

    [self.view addSubview:cd_days_V1];
    [self.view addSubview:cd_days_V2];
    [self.view addSubview:cd_days_T];
    [self.view addSubview:cd_days_A];
    [self.view addSubview:cd_days_G];
    [self.view addSubview:cd_days_E];
    [self.view addSubview:cd_days_S];
    
    
    yStart += 60;
    xStart = 30;
    
    cd_hors_V1 = [[CountdownNumber alloc] initWithFrame:CGRectMake(xStart,        yStart, 35, 48) value:@"" andTag:0];
    cd_hors_V2 = [[CountdownNumber alloc] initWithFrame:CGRectMake(xStart+=35,    yStart, 35, 48) value:@"" andTag:0];
    cd_hors_S = [[CountdownNumber alloc] initWithFrame:CGRectMake(xStart+=60,     yStart, 35, 48) value:@"S" andTag:1000];
    cd_hors_T = [[CountdownNumber alloc] initWithFrame:CGRectMake(xStart+=35,     yStart, 35, 48) value:@"T" andTag:1000];
    cd_hors_U = [[CountdownNumber alloc] initWithFrame:CGRectMake(xStart+=35,     yStart, 35, 48) value:@"D" andTag:1000];
    cd_hors_N = [[CountdownNumber alloc] initWithFrame:CGRectMake(xStart+=35,     yStart, 35, 48) value:@"" andTag:1000];
    cd_hors_D = [[CountdownNumber alloc] initWithFrame:CGRectMake(xStart+=35,     yStart, 35, 48) value:@"" andTag:1000];
    
    
    [self.view addSubview:cd_hors_V1];
    [self.view addSubview:cd_hors_V2];
    [self.view addSubview:cd_hors_S];
    [self.view addSubview:cd_hors_T];
    [self.view addSubview:cd_hors_U];
    [self.view addSubview:cd_hors_N];
    [self.view addSubview:cd_hors_D];
    
    yStart += 60;
    xStart = 30;
    
    cd_minu_V1 = [[CountdownNumber alloc] initWithFrame:CGRectMake(xStart,        yStart, 35, 48) value:@"" andTag:0];
    cd_minu_V2 = [[CountdownNumber alloc] initWithFrame:CGRectMake(xStart+=35,    yStart, 35, 48) value:@"" andTag:0];
    cd_minu_M = [[CountdownNumber alloc] initWithFrame:CGRectMake(xStart+=60,     yStart, 35, 48) value:@"M" andTag:1000];
    cd_minu_I = [[CountdownNumber alloc] initWithFrame:CGRectMake(xStart+=35,     yStart, 35, 48) value:@"I" andTag:1000];
    cd_minu_N = [[CountdownNumber alloc] initWithFrame:CGRectMake(xStart+=35,     yStart, 35, 48) value:@"N" andTag:1000];
    cd_minu_U = [[CountdownNumber alloc] initWithFrame:CGRectMake(xStart+=35,     yStart, 35, 48) value:@"" andTag:1000];
    cd_minu_S = [[CountdownNumber alloc] initWithFrame:CGRectMake(xStart+=35,     yStart, 35, 48) value:@"" andTag:1000];
    
    
    [self.view addSubview:cd_minu_V1];
    [self.view addSubview:cd_minu_V2];
    [self.view addSubview:cd_minu_M];
    [self.view addSubview:cd_minu_I];
    [self.view addSubview:cd_minu_N];
    [self.view addSubview:cd_minu_U];
    [self.view addSubview:cd_minu_S];
    
    
    yStart += 60;
    xStart = 30;
    
    
    cd_seco_V1 = [[CountdownNumber alloc] initWithFrame:CGRectMake(xStart,        yStart, 35, 48) value:@"" andTag:0];
    cd_seco_V2 = [[CountdownNumber alloc] initWithFrame:CGRectMake(xStart+=35,    yStart, 35, 48) value:@"" andTag:0];
    cd_seco_S = [[CountdownNumber alloc] initWithFrame:CGRectMake(xStart+=60,     yStart, 35, 48) value:@"S" andTag:1000];
    cd_seco_E = [[CountdownNumber alloc] initWithFrame:CGRectMake(xStart+=35,     yStart, 35, 48) value:@"E" andTag:1000];
    cd_seco_K = [[CountdownNumber alloc] initWithFrame:CGRectMake(xStart+=35,     yStart, 35, 48) value:@"K" andTag:1000];
    cd_seco_U = [[CountdownNumber alloc] initWithFrame:CGRectMake(xStart+=35,     yStart, 35, 48) value:@"" andTag:1000];
    cd_seco_N = [[CountdownNumber alloc] initWithFrame:CGRectMake(xStart+=35,     yStart, 35, 48) value:@"" andTag:1000];
    
    
    [self.view addSubview:cd_seco_V1];
    [self.view addSubview:cd_seco_V2];
    [self.view addSubview:cd_seco_S];
    [self.view addSubview:cd_seco_E];
    [self.view addSubview:cd_seco_K];
    [self.view addSubview:cd_seco_U];
    [self.view addSubview:cd_seco_N];
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    DateDetermination *dd = [[DateDetermination alloc] init];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    dateFormat.dateFormat = @"dd.MM.yyyy HH";
    
    if([CountdownView getIntervalToHerbstfest] > 0){
        mode = 1;
        infoText.text = @"Das Herbstfest beginnt in...";
        NSString* dateString = [dateFormat  stringFromDate:[dd determineThisYearsHerbsfestStart]];
        timeText.text = [NSString stringWithFormat:@"Start: Freitag %@ Uhr", dateString ];
        cd_days_S.value = @"N";
    } else if([CountdownView getIntervalToEndOfHerbstfest] > 0){
        mode = 2;
        infoText.text = @"Das Herbstfest is da und das noch für...";
        NSString* dateString = [dateFormat  stringFromDate:[dd determineThisYearsHerbsfestEnd]];
        timeText.text = [NSString stringWithFormat:@"Ende: Montag %@ Uhr", dateString ];
        cd_days_S.value = @"";
    } else {
        mode = 3;
        infoText.text = @"Das Herbstfest beginnt in...";
        NSString* dateString = [dateFormat  stringFromDate:[dd determineNextYearsHerbstfestStart]];
        timeText.text = [NSString stringWithFormat:@"Start: Freitag %@ Uhr", dateString ];
        cd_days_S.value = @"N";
    }
    
}

+(NSTimeInterval)getIntervalToNextHerbstfest{

    DateDetermination *dd = [[DateDetermination alloc] init];
    NSDate* nextYearDate = [dd determineNextYearsHerbstfestStart];
    
    return [nextYearDate timeIntervalSinceDate:[NSDate date]];
}

+(NSTimeInterval)getIntervalToEndOfHerbstfest{
    
    DateDetermination *dd = [[DateDetermination alloc] init];
    NSDate* endDate = [dd determineThisYearsHerbsfestEnd];

    return [endDate timeIntervalSinceDate:[NSDate date]];
}

+(NSTimeInterval)getIntervalToHerbstfest{
    
    DateDetermination *dd = [[DateDetermination alloc] init];
    NSDate* startDate = [dd determineThisYearsHerbsfestStart];
    
    return [startDate timeIntervalSinceDate:[NSDate date]];
}

-(NSTimeInterval)getRelevantTimeInterval{
    if(mode == 1){
        return [CountdownView getIntervalToHerbstfest];
    } else if(mode == 2){
        return [CountdownView getIntervalToEndOfHerbstfest];
    } else if (mode == 3){
        return [CountdownView getIntervalToNextHerbstfest];
    }
    return 0;
}

-(void)updateCounter{
    
	NSTimeInterval interval = [self getRelevantTimeInterval];
	
	//Calculate Forward
	float minutes  = interval / 60;
	float hours   = minutes / 60;
	int   days    = hours / 24;
	
	//Calc Hours
	hours -= days * 24; 
	int hoursI = hours;
	
	//Calc Minutes
	minutes -= (24 * days + hoursI) * 60;
	int minutesI = minutes;
	
	//Calc Seconds
	int seconds = interval - ((24 * days + hoursI) * 60 + minutesI) * 60;
	
	//Label Hours
	int daysT = days / 10;
	days -= daysT * 10;
	
    
	cd_days_V1.value = [NSString stringWithFormat:@"%i", daysT]; 
	cd_days_V2.value = [NSString stringWithFormat:@"%i", days]; 
	
    if(daysT >= 10){
        cd_days_V1.frame = CGRectMake(13, cd_days_V1.frame.origin.y, 52, cd_days_V1.frame.size.height);
    }
    
	int hoursT = hoursI / 10;
	hoursI -= hoursT * 10;
	cd_hors_V1.value = [NSString stringWithFormat:@"%i", hoursT];
	cd_hors_V2.value = [NSString stringWithFormat:@"%i", hoursI];
	
	int minutesT = minutesI / 10;
	minutesI -= minutesT * 10;
	cd_minu_V1.value = [NSString stringWithFormat:@"%i", minutesT];
	cd_minu_V2.value = [NSString stringWithFormat:@"%i", minutesI];
	
    int secondsT = seconds / 10;
	seconds -= secondsT * 10;
	cd_seco_V1.value = [NSString stringWithFormat:@"%i", secondsT];
	cd_seco_V2.value = [NSString stringWithFormat:@"%i", seconds];
    
    
}

-(void)viewDidAppear:(BOOL)animated{
	[self updateCounter];
	timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateCounter) userInfo:nil repeats:YES];
	[timer fire];
}

-(void)viewWillDisappear:(BOOL)animated{
	[timer invalidate]; timer = nil;
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}



@end
