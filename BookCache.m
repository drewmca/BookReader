//
//  BookCache.m
//  BookReader
//
//  Created by Drew McAuliffe on 9/10/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "BookCache.h"
#import "Book.h"
#import "Page.h"

@implementation BookCache
NSString *const BOOKS_PATH = @"books";

@synthesize books;

-(void) load{
/*
	NSMutableArray *booksTemp = [[NSMutableArray alloc] initWithCapacity:1];
	Book *b1 = [[Book alloc] 
		initWithBasePath:@"00-book1" withSeries:@"SeriesX" 
		withIssue:@"2" withTitle:@"Masters of the Baterverse" withBookNumber:1];
	Page *p1 = [[Page alloc] 
		initWithFilename:@"page-01.jpg" forBook:b1 withSize:CGSizeMake(320, 480) withPageNumber:1];
	Page *p2 = [[Page alloc]
		initWithFilename:@"page-02.jpg" forBook:b1 withSize:CGSizeMake(320, 480) withPageNumber:2];
	NSMutableArray *pages = [NSMutableArray	arrayWithObjects:p1, p2, nil];
	b1.pages = pages;
	[p1 release];
	[p2 release];
	
	[booksTemp addObject:b1];
	[b1 release];
	
	// convert
	self.books = [NSArray arrayWithArray:booksTemp];
	[booksTemp release];
*/
	self.books = [self booksFromDir];
}

-(NSMutableArray *) booksFromDir{
	NSMutableArray *result = [[[NSMutableArray alloc] init] autorelease];
	NSFileManager *fm = [NSFileManager defaultManager];
	NSBundle *bundle = [NSBundle mainBundle];
	NSString *booksPath = [[bundle bundlePath] stringByAppendingPathComponent:BOOKS_PATH];
	for (NSString *dir in [fm directoryContentsAtPath:booksPath]){
		Book *book = [self bookFromDir:dir];
		[result addObject:book];
	}
	return result;
}
-(Book *) bookFromDir:(NSString *) dir{
	NSBundle *bundle = [NSBundle mainBundle];
	NSString *bookBundlePath = [BOOKS_PATH stringByAppendingPathComponent:dir];
	NSString *descriptorFullPath = [bundle pathForResource:@"book" ofType:@"plist" inDirectory:bookBundlePath];
	NSDictionary *bookInfo = [NSDictionary dictionaryWithContentsOfFile:descriptorFullPath];
	Book *book = [[[Book alloc] initWithBasePath:dir
		withSeries:[bookInfo objectForKey:@"series"]
		withIssue:[bookInfo objectForKey:@"issue"]
		withTitle:[bookInfo objectForKey:@"title"]
		withBookNumber:[[bookInfo valueForKey:@"bookNumber"] intValue]] autorelease];
	// get pages
	NSMutableArray *pages = [[NSMutableArray alloc] init];
	NSString *bookFullPath = [[bundle bundlePath] stringByAppendingPathComponent:bookBundlePath];
	NSInteger pageNumber = 1;
	for (NSString *filename in [[NSFileManager defaultManager] directoryContentsAtPath:bookFullPath]){
		if ([filename hasPrefix:@"page-"]){
			Page *page = [[Page alloc] initWithFilename:filename forBook:book 
				withSize:CGSizeMake(320, 480) withPageNumber:pageNumber++];
			[pages addObject:page];
			[page release];
		}
	}
	book.pages = pages;
	[pages release];
	return book;
}

-(Book *) bookForBookNumber:(NSInteger)bookNumber{
	for (Book *book in self.books){
		if (book.bookNumber == bookNumber)
			return book;
	}
	return nil;
}

@end
