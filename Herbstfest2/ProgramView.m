//
//  ProgramView.m
//  Herbstfest
//
//  Created by Michael Dietz on 01.08.11.
//  Copyright 2011 MD. All rights reserved.
//

#import "ProgramView.h"
#import "DescriptionView.h"
#import "WebFileView.h"

@implementation ProgramView

@synthesize listElements, table;

#pragma mark - View lifecycleq

static BOOL forceUpdateStatic;

+(void)updateRequired{
    forceUpdateStatic = YES;
}

- (void)viewDidLoad {

}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationItem.title = @"Herbstfest Programm";
    //[[[ContentUpdateLoader alloc] init] checkForContentUpdate:self];
    [self updateTableData:NO];
}


-(void)viewDidDisappear:(BOOL)animated{
    self.navigationItem.title = @"Zurück";
}


-(void)updateTableData:(BOOL)forceUpdate{
    if(forceUpdate || forceUpdateStatic || listElements == nil){
        
        forceUpdateStatic = NO;
        
        NSArray*  paths        = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString* path         = [paths objectAtIndex:0];
        NSString* fullPath     = [[path stringByAppendingPathComponent:@"program.plist"] copy];
        
        if(![[NSFileManager defaultManager] fileExistsAtPath:fullPath]){
            NSString* path1    = [[NSBundle mainBundle] bundlePath];
            fullPath           = [[path1 stringByAppendingPathComponent:@"program.plist"] copy];
        }
        
        listElements = [[NSArray arrayWithContentsOfFile:fullPath] objectAtIndex:0];
        arrayGrouper = [[ArrayGrouper alloc] initWithArray:listElements];
    }
    
    arrayGrouper = [[ArrayGrouper alloc] initWithArray:listElements];
    [self.table reloadData];
}

#pragma mark - Table view data source


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [arrayGrouper countGroups];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrayGrouper countELementsInGroup:section];
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NSString* groupHeader = [arrayGrouper getTitleForGroup:section];
    
    UIView* header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    UILabel* lbl = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, 300, 30)];
    lbl.text = groupHeader;
    lbl.backgroundColor = [UIColor clearColor];
    lbl.textColor = [UIColor whiteColor];
    [lbl setFont:[UIFont fontWithName:@"Helvetica-Light" size:18]];
    header.backgroundColor = [UIColor darkGrayColor];
    
    [header addSubview:lbl];
    return header;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    NSDictionary* element = [arrayGrouper getElementForIndex:indexPath];
    cell.textLabel.text = [element objectForKey:@"Title"];
    [cell.textLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:16]];
    cell.detailTextLabel.text = [element objectForKey:@"Subtitle"];
    [cell.detailTextLabel setFont:[UIFont fontWithName:@"Helvetica-Light" size:16]];
    cell.imageView.image = [UIImage imageNamed:@"leaf_klein.png"];
    
    NSNumber* type = [element objectForKey:@"Type"];
    if([type intValue] >= 1){
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}


#pragma mark COntent Update

-(void)newMapDataArrived{ 
    [self updateTableData:YES];
}

-(void)noNewMapDataArrived{
    //Nothing to do
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary* element = [arrayGrouper getElementForIndex:indexPath];
    
    NSNumber* type = [element objectForKey:@"Type"];
    if([type intValue] == 1){
        ProgramView* nextView = [[ProgramView alloc] initWithNibName:@"ProgramView" bundle:nil];
        nextView.listElements = [element objectForKey:@"Subobjects"];
        [self.navigationController pushViewController:nextView animated:YES];
    } else if([type intValue] == 2){
        DescriptionView* nextView = [[DescriptionView alloc] initWithNibName:@"DescriptionView" bundle:nil];
        nextView.description = [element objectForKey:@"Description"];
        [self.navigationController pushViewController:nextView animated:YES];
    } else if([type intValue] == 3){
        WebFileView* nextView = [[WebFileView alloc] initWithNibName:@"WebFileView" bundle:nil];
        nextView.pdfName = [element objectForKey:@"Filename"];
        [self.navigationController pushViewController:nextView animated:YES];
    } else if([type intValue] == 4){
        NSString* urlStr = [element objectForKey:@"URL"];
        NSURL* url = [[NSURL alloc] initWithString:urlStr];
        if([[UIApplication sharedApplication] canOpenURL:url])
            [[UIApplication sharedApplication] openURL:url];
        else 
            NSLog(@"URL not valid: %@", urlStr);
    }

}

-(IBAction)back{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
}

@end
