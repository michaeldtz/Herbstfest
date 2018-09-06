//
//  HomeViewController.m
//  Herbstfest2
//
//  Created by Michael Dietz on 25.07.13.
//  Copyright (c) 2013 Michael Dietz. All rights reserved.
//

#import "HomeViewController.h"



@interface HomeViewController ()

@end

@implementation HomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString* welcome = [NSString stringWithFormat:@"Unter dem Motto \"Die Kunst, Der Wein, Das Fest und So\" zieht es wie jedes Jahr viele Besucher am 2. Septemberwochenende in die wunder schöne Nordpfalz. \n Bereits im Jahr 2009 feierte das Fest sein 60 jähriges Bestehen und ist damit eines der ältesten und größten seiner Art in der Region. Traditionell und trotzdem zeitgemäß."];
    
    [welcomeText setText:welcome];
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
