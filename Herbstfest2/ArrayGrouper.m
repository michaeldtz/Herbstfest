//
//  ArrayGrouper.m
//  Herbstfest
//
//  Created by Michael Dietz on 02.08.11.
//  Copyright 2011 MD. All rights reserved.
//

#import "ArrayGrouper.h"

@implementation ArrayGrouper

- (id)initWithArray:(NSArray*)aArray
{
    self = [super init];
    if (self) {
        array = aArray;
    }
    
    return self;
}

-(NSDictionary*)getGroupCountDictionary{
    
    if(groupCountDic == nil){
        groupCountDic = [[NSMutableDictionary alloc] init];
        for (NSDictionary* dic in array) {
            NSString* groupName = [dic objectForKey:@"Group"];
            NSNumber* groupCnt = [groupCountDic objectForKey:groupName];
            if(groupCnt == nil)
                groupCnt = [[NSNumber alloc] initWithInt:1];
            else 
                groupCnt = [NSNumber numberWithInt: [groupCnt intValue] + 1];
            [groupCountDic setObject:groupCnt forKey:groupName];
        }
    }
    
    return groupCountDic;
}

-(NSDictionary*)getGroupDictionary{
    
    if(groupDic == nil){
        groupDic = [[NSMutableDictionary alloc] init];
        for (NSDictionary* group in array) {
            NSString* groupName = [group objectForKey:@"Group"];
            NSMutableArray* groupArr = [groupDic objectForKey:groupName];
            if(groupArr == nil)
                groupArr = [[NSMutableArray alloc] init];
            [groupArr addObject:group];
            [groupDic setObject:groupArr forKey:groupName];
        }
    }
    return groupDic;
}



-(NSArray*)getGroupNameArray{
    if(groupNameArray == nil){
        groupNameArray = [[NSMutableArray alloc] init];
        for (NSDictionary* group in array) {
            
            NSString* groupName = [group objectForKey:@"Group"];
            BOOL existing = NO;
            for(NSString* existingName in groupNameArray){
                if([existingName isEqualToString:groupName])
                    existing = YES;
            }
            
            if(!existing)
                [groupNameArray addObject:groupName];
        }
    }
    return groupNameArray;
}


-(int)countGroups{
    return (int)[[self getGroupCountDictionary] count];
}

-(NSString*)getTitleForGroup:(NSInteger)section{
    return [[self getGroupNameArray] objectAtIndex:section];
}

-(int)countELementsInGroup:(NSInteger)groupCount{
    NSArray* groupNames = [self getGroupNameArray];
    NSString* groupName = [groupNames objectAtIndex:groupCount];
    NSNumber* count = [[self getGroupCountDictionary] objectForKey:groupName];
    return [count intValue];
}

-(NSDictionary*)getElementForIndex:(NSIndexPath*)indexPath{
    NSArray* groupNames = [self getGroupNameArray];
    NSString* groupName = [groupNames objectAtIndex:indexPath.section];
    NSArray* elements = [[self getGroupDictionary] objectForKey:groupName];
    return [elements objectAtIndex:indexPath.row];
}

@end
