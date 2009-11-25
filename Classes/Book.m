//
//  Book.m
//  BookReader
//
//  Created by Drew McAuliffe on 9/10/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Book.h"
#import "Page.h"

@implementation Book
@synthesize series;
@synthesize issue;
@synthesize	title;
@synthesize basePath;
@synthesize pages;
@synthesize bookNumber;

-(void) dealloc{
	[series release];
	[issue release];
	[title release];
	[basePath release];
	[pages release];
	
	[super dealloc];
}

-(id) initWithBasePath:(NSString *) thePath withSeries:(NSString *) theSeries 
			 withIssue:(NSString *) theIssue withTitle:(NSString *) theTitle withBookNumber:(NSInteger) number{
	if (self = [super init]){
		self.basePath = thePath;
		self.series = theSeries;
		self.issue = theIssue;
		self.title = theTitle;
		self.bookNumber = number;
	}
	return self;
}

# pragma mark TTPhotoSource
-(NSString *) title{
	return title;
}
-(NSMutableArray *) delegates{return nil;}
-(BOOL) isLoading{return NO;}
-(BOOL) isLoaded{return YES;}
-(BOOL) isOutdated{return NO;}
-(NSInteger) numberOfPhotos{
	return [self.pages count];
}
-(NSInteger) maxPhotoIndex{
	return [self.pages count] - 1;
}
-(id<TTPhoto>) photoAtIndex:(NSInteger)index{
	Page *page = (Page *) [self.pages objectAtIndex:index];
	return page;
	/*
	NSString *path = @"bundle://cover.jpg";//[[NSBundle mainBundle] pathForResource:@"cover" ofType:@"jpg"];
//	NSURL *url = [NSURL fileURLWithPath:path];
	NSString *urlString = path;
	
	Page *page = [[[Page alloc] initWithURL:urlString smallURL:urlString
		size:CGSizeMake(320, 480) 
		pageNumber:index] autorelease];
	return page;
	*/
}
@end
