//
//  DescriptionView.m
//  Herbstfest
//
//  Created by Michael Dietz on 07.08.11.
//  Copyright 2011 MD. All rights reserved.
//

#import "DescriptionView.h"

@implementation DescriptionView

@synthesize description, textView;

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"Programm";
}

-(void)viewWillAppear:(BOOL)animated{
    textView.text = description;
}


-(IBAction)back{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



@end
