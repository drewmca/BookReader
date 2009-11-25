//
//  BookViewerVC.h
//  BookReader
//
//  Created by Drew McAuliffe on 9/12/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Three20/Three20.h>
@class Book;
@class BookmarkManager;

@interface BookViewerVC : TTPhotoViewController <UIActionSheetDelegate> {
	Book *book;
}
@property (nonatomic, retain) Book *book;
-(BookmarkManager *) bookmarkManager;
@end
