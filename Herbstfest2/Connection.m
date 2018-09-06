//
//  SXURLLoader.m
//  StaxIPhone
//
//  Created by Michael Dietz on 16.12.09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Connection.h"

#define VERBOSE 0

@implementation Connection

#pragma mark Synchronous Call Get

-(NSData*) callURLSync:(NSString*)url{
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];  
	[request setURL:[NSURL URLWithString:url]];  
    [request setHTTPMethod:@"GET"];  
	
#if VERBOSE >= 1
	NSLog(@"Loading URL %@",url);
#endif
    
	NSURLResponse *response = [[NSURLResponse alloc] init];
	NSError *error = nil;
	NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
	
	if(error == nil){
		return responseData; 
	} else {
		NSLog(@"Connection failed! Error - %@", [error localizedDescription]);		 	
	}
	return nil;		
}


#pragma mark Asynchronous Call GET

-(void)callURLAsync:(NSString*)url :(id)_delegate{
	
	delegate = _delegate;
	
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];  
	[request setURL:[NSURL URLWithString:url]];  
	[request setHTTPMethod:@"GET"];  
	
#if VERBOSE >= 1
	NSLog(@"Loading URL %@",url);
#endif
    
	NSURLConnection *connection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
	if (connection) {
		receivedData=[NSMutableData data];
	} else {
		[delegate dataLoadingError:@"Error during connection initialization"];
	}
}


-(void)twitterCallPost:(NSString*)url :(NSString*)content :(NSString*)authHeader :(id)_delegate{
	
	delegate = _delegate;
	
    //Prepare Data
    NSData* postData = [content dataUsingEncoding:NSUTF8StringEncoding];
    NSString* requestDataLengthString = [[NSString alloc] initWithFormat:@"%lu", (unsigned long)[postData length]];
	
    NSLog(@"%@,%@", content, authHeader);
    
    //Create Request
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
	[request setURL:[NSURL URLWithString:url]];
	[request setHTTPMethod:@"POST"];
    [request setHTTPBody:postData];
    [request setValue:authHeader forHTTPHeaderField:@"Authorization"];
    [request setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [request setValue:requestDataLengthString forHTTPHeaderField:@"Content-length"];
    
	
#if VERBOSE >= 1
	NSLog(@"Loading URL %@",url);
#endif
    
	NSURLConnection *connection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
	if (connection) {
		receivedData=[NSMutableData data];
	} else {
		[delegate dataLoadingError:@"Error during connection initialization"];
	}
}

#pragma mark ConnectionDelegateMethods

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	[receivedData appendData:data];
}


#pragma mark Finalizing Delegate Methods

- (void)connection:(NSURLConnection *)connection
  didFailWithError:(NSError *)error
{
	NSString* errorText = [[NSString alloc] initWithFormat:@"Connection failed - %@",
						   [error localizedDescription]];
	
	[delegate dataLoadingError:errorText];
	

    connection = nil;
    receivedData = nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	NSString* data = [[NSString alloc] initWithData:receivedData encoding:NSASCIIStringEncoding];
	[delegate dataLoadingSuccessful:data];
	
    connection = nil;
	receivedData = nil;
}



@end
