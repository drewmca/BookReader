//
//  BookViewerVC.m
//  BookReader
//
//  Created by Drew McAuliffe on 9/12/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "BookViewerVC.h"
#import "Book.h"
#import "Bookmark.h"
#import "BookmarkManager.h"
#import "BookReaderAppDelegate.h"

@implementation BookViewerVC
@synthesize book;
- (void)dealloc {
	TT_RELEASE_SAFELY(book);
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (id)initWithNavigatorURL:(NSURL*)URL query:(NSDictionary*)query {
	if (self = [super init]){
		Book *newBook = (Book *) [query objectForKey:@"book"];
		self.book = newBook;
		self.photoSource = self.book;
		// handle page
		if ([query objectForKey:@"pageNumber"]){
			NSNumber *pageNumber = [query objectForKey:@"pageNumber"];
			[self moveToPhotoAtIndex:([pageNumber intValue] - 1) withDelay:0.5];
		}
	}
	return self;
}

-(void) loadView{
	[super loadView];
	
	// tweak toolbar
	UIBarItem *space = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:
		UIBarButtonSystemItemFlexibleSpace target:nil action:nil] autorelease];
	UIBarItem *addBookmark = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:
		UIBarButtonSystemItemBookmarks target:self action:@selector(addBookmark)] autorelease];
	_toolbar.items = [NSArray arrayWithObjects: _previousButton, space, addBookmark, space, _nextButton, nil];
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

#pragma mark TTPhotoViewController
- (void) updateChrome{
	if (_photoSource.numberOfPhotos < 2) {
		self.title = _photoSource.title;
	} else {
		self.title = [NSString stringWithFormat:
					  TTLocalizedString(@"%d of %d", @"Current page in photo browser (1 of 10)"),
					  _centerPhotoIndex+1, _photoSource.numberOfPhotos];
	}
	
	// Always add nav item for viewing bookmarks
	UIBarButtonItem *showBookmarks = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self action:@selector(showBookmarks)];
	self.navigationItem.rightBarButtonItem = showBookmarks;
	[showBookmarks release];
}

- (void)viewDidUnload {
}
#pragma mark BookViewerVC
-(void) addBookmark{
	UIActionSheet *confirm = [[UIActionSheet alloc]
							  initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Bookmark Page" otherButtonTitles:nil];
	[confirm showInView:self.view];
	[confirm release];
}
-(void) actionSheet:(UIActionSheet *) actionSheet didDismissWithButtonIndex:(NSInteger) buttonIndex{
	if (!buttonIndex == [actionSheet cancelButtonIndex]){
		NSLog(@"Adding bookmark for book %d, page %d", self.book.bookNumber, 
			  self.centerPhotoIndex);
		NSNumber *bookNumber = [NSNumber numberWithInt:self.book.bookNumber];
		NSNumber *pageNumber = [NSNumber numberWithInt:(self.centerPhotoIndex + 1)];
		if (! [[self bookmarkManager] doesBookmarkExistForBook:bookNumber forPage:pageNumber]){
			[[self bookmarkManager] addBookmarkForBook:bookNumber forPage:pageNumber];
		}
		else {
			NSLog(@"Bookmark already exists for book %d, page %d", [bookNumber intValue], [pageNumber intValue]);
		}

	}
}


- (void) showBookmarks{
	NSLog(@"Showing bookmarks!");
	TTOpenURL(@"tt://home/bookmarks");
}

-(BookmarkManager *) bookmarkManager{
	BookReaderAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	return delegate.bookmarkManager;
}
-(BOOL) shouldLoadMore{return NO;}

@end
