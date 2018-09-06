//
//  PDFView.h
//  Herbstfest
//
//  Created by Michael Dietz on 04.08.11.
//  Copyright 2011 MD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProgramLoaderAndCacher.h"

@interface WebFileView: UIViewController <ProgramLoaderDelegate> {
    
	UIWebView	*webView;
	NSString    *pdfName;
    
}

@property (nonatomic, retain) IBOutlet UIWebView	*webView;
@property (nonatomic, retain) NSString			    *pdfName;

-(IBAction)back;

@end