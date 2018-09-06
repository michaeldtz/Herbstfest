//
//  Feed.h
//  Herbstfest2
//
//  Created by Michael Dietz on 21.08.13.
//  Copyright (c) 2013 Michael Dietz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Feed : NSManagedObject

@property (nonatomic, retain) NSString * feedid;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSString * username;
@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) NSString * imageURL;
@property (nonatomic, retain) NSData * imageData;
@property (nonatomic, retain) NSNumber * imgWidth;
@property (nonatomic, retain) NSNumber * imgHeight;

@end
