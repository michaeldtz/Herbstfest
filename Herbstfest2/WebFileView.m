//
//  PDFView.m
//  Herbstfest
//
//  Created by Michael Dietz on 04.08.11.
//  Copyright 2011 MD. All rights reserved.
//

#import "WebFileView.h"

@implementation WebFileView

@synthesize webView, pdfName;

#pragma mark -
#pragma mark UIViewController methods

// View Did Load method -- Load the PDF
- (void)viewDidLoad {
	[super viewDidLoad];
    self.navigationItem.title = @"Herbstfest Programm";
    
	// Tells the webView to load pdfUrl
    ProgramLoaderAndCacher* loader  = [[ProgramLoaderAndCacher alloc] init];
    [loader loadContent:pdfName :self];

}

-(void)     contentLoaded:(NSString*)path{
    NSLog(@"Path to PDF: %@", path);
	[webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:path]]];    
}

-(void)     contentLoadingFailed:(NSString*)error{    
    NSLog(@"Failed: %@", error);
}

-(IBAction)back{
    [self.navigationController popViewControllerAnimated:YES];
}



@end
