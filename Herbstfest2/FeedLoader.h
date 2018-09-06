//
//  InstagramAccess.h
//  Herbstfest2
//
//  Created by Michael Dietz on 25.07.13.
//  Copyright (c) 2013 Michael Dietz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Connection.h"

@interface FeedLoader : NSObject <ConnectionFeedback>{
    
    void (^_completionBlock)(void);

    
}

-(void)loadInstagramFeedAndStoreToCoreData:(void (^)(void))completionBlock;
-(void)deleteAllFeeds;

@end
