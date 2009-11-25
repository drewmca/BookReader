//
//  BookmarkManager.m
//  BookReader
//
//  Created by Drew McAuliffe on 9/15/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "BookmarkManager.h"
#import "Bookmark.h"

@implementation BookmarkManager
@synthesize ctx;
-(BOOL) doesBookmarkExistForBook:(NSNumber *) bookNumber forPage:(NSNumber *) pageNumber{
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"Bookmark" 
											  inManagedObjectContext:self.ctx];
	NSPredicate *predicate = [NSPredicate predicateWithFormat:
		@"(bookNumber == %@) AND (pageNumber == %@)", bookNumber, pageNumber];

	NSFetchRequest *request = [[[NSFetchRequest alloc] init] autorelease];
	[request setEntity:entity];
	[request setPredicate:predicate];

	NSError *error = nil;
	NSArray *result = [self.ctx executeFetchRequest:request error:&error];
	if (result == nil ){
		NSLog(@"Error checking on bookmark:%@, %@", error, [error userInfo]);
		return NO;
	}
	else {
		return [result count] > 0;
	}
	
}
-(void) addBookmarkForBook:(NSNumber *) bookNumber forPage:(NSNumber *) pageNumber{
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"Bookmark" 
											  inManagedObjectContext:self.ctx];
	Bookmark *bookmark = [NSEntityDescription insertNewObjectForEntityForName:[entity name] 
											 inManagedObjectContext:self.ctx];
	bookmark.bookNumber = bookNumber;
	bookmark.pageNumber = pageNumber;
	
	NSError *error = nil;
	if (! [self.ctx save:&error]){
		NSLog(@"Error saving bookmark:%@, %@", error, [error userInfo]);
	}
}
-(void) deleteBookmark:(Bookmark *) bookmark{
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"Bookmark" 
											  inManagedObjectContext:self.ctx];
	[self.ctx deleteObject:bookmark];
	NSError *error = nil;
	if (! [self.ctx save:&error]){
		NSLog(@"Error deleting bookmark:%@, %@", error, [error userInfo]);
	}
}


@end
