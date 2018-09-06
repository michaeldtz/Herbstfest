//
//  ProgramView.h
//  Herbstfest
//
//  Created by Michael Dietz on 01.08.11.
//  Copyright 2011 MD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArrayGrouper.h"

@interface ProgramView : UIViewController <UITableViewDelegate, UITableViewDataSource> {

    UITableView*  table;
    NSArray*      listElements;
    ArrayGrouper* arrayGrouper;
    
}

@property (nonatomic, retain) IBOutlet UITableView* table;
@property (nonatomic, retain) NSArray *listElements;

+(void)updateRequired;
-(void)updateTableData:(BOOL)forceUpdate;
-(IBAction)back;

@end
