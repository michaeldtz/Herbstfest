//
//  ArrayGrouper.h
//  Herbstfest
//
//  Created by Michael Dietz on 02.08.11.
//  Copyright 2011 MD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArrayGrouper : NSObject{
   
    NSArray* array;
    NSMutableDictionary* groupDic;
    NSMutableDictionary* groupCountDic;
    NSMutableArray* groupNameArray;
    
}

- (id)initWithArray:(NSArray*)array;

-(int)countGroups;
-(int)countELementsInGroup:(NSInteger)groupCount;
-(NSString*)getTitleForGroup:(NSInteger)indexPath;
-(NSDictionary*)getElementForIndex:(NSIndexPath*)indexPath;

@end
