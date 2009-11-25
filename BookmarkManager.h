//
//  BookmarkManager.h
//  BookReader
//
//  Created by Drew McAuliffe on 9/15/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

@class Bookmark;

@interface BookmarkManager : NSObject {
	NSManagedObjectContext *ctx;
}
@property (nonatomic, retain) NSManagedObjectContext *ctx;
-(BOOL) doesBookmarkExistForBook:(NSNumber *) bookNumber forPage:(NSNumber *) pageNumber;
-(void) addBookmarkForBook:(NSNumber *) bookNumber forPage:(NSNumber *) pageNumber;
-(void) deleteBookmark:(Bookmark *) bookmark;
@end
