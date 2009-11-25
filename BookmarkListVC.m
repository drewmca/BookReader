//
//  BookmarkListVC.m
//  BookReader
//
//  Created by Drew McAuliffe on 9/15/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "BookmarkListVC.h"

#import "Bookmark.h"
#import "BookmarkManager.h"
#import "BookReaderAppDelegate.h"
#import "BookViewerVC.h"
#import "BookCache.h"
#import "Book.h"
@implementation BookmarkListVC
@synthesize frc;

- (void)dealloc {
    [super dealloc];
}



#pragma mark UIViewController
- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}
-(void) viewWillDisappear:(BOOL)animated{
	[super viewWillDisappear:animated];
	NSLog(@"Popping back to %@", self.parentViewController);
}
- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}
- (void) viewDidLoad {
	[super viewDidLoad];
	
	// turn on edit button
	self.tableView.allowsSelectionDuringEditing = YES;
	self.navigationItem.rightBarButtonItem = self.editButtonItem;
	self.title = @"Bookmarks";
	
	// fetch results
	NSError *error = nil;
	if (![self.frc performFetch:&error]){
		NSLog(@"Error fetching results on first load:%@,%@", [error localizedDescription], 
			  [error userInfo]);
	}
	
}

-(BookmarkManager *) bookmarkManager{
	return ((BookReaderAppDelegate *)[[UIApplication sharedApplication] delegate]).bookmarkManager;
}
-(BookCache *) bookCache{
	return ((BookReaderAppDelegate *)[[UIApplication sharedApplication] delegate]).bookCache;
}

#pragma mark NSFetchedResultsController
- (NSFetchedResultsController *)frc {
	if (frc != nil) {
		return frc;
	}
	NSManagedObjectContext *managedObjectContext = 
	((BookReaderAppDelegate *)[[UIApplication sharedApplication] delegate]).managedObjectContext;
	
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = 
	[NSEntityDescription entityForName:@"Bookmark"
				inManagedObjectContext:managedObjectContext];
	[fetchRequest setEntity:entity];
	
	NSSortDescriptor *bookNumberSort = [[NSSortDescriptor alloc] 
										initWithKey:@"bookNumber" ascending:YES];
	NSSortDescriptor *pageNumberSort = [[NSSortDescriptor alloc] 
										initWithKey:@"pageNumber" ascending:YES];
	[fetchRequest setSortDescriptors:[NSArray arrayWithObjects:
									  bookNumberSort, pageNumberSort, nil]];
	
	NSFetchedResultsController *aFetchedResultsController = 
	[[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest 
										managedObjectContext:managedObjectContext
										  sectionNameKeyPath:nil
												   cacheName:@"Root"];
	aFetchedResultsController.delegate = self; 
	self.frc = aFetchedResultsController;
	
	[aFetchedResultsController release];
	[fetchRequest release];
	[bookNumberSort release];
	[pageNumberSort release];
	
	return frc;
}    

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
	[self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller 
   didChangeObject:(id)anObject 
       atIndexPath:(NSIndexPath *)indexPath 
     forChangeType:(NSFetchedResultsChangeType)type 
      newIndexPath:(NSIndexPath *)newIndexPath {
	
	switch (type){
		case NSFetchedResultsChangeUpdate:
			//[self configureCell:[self.tableView cellForRowAtIndexPath:indexPath]
			//		  withScene:anObject];
			break;
		case NSFetchedResultsChangeMove:
			//[self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0]
			//			  withRowAnimation:UITableViewRowAnimationFade];
			break;
		case NSFetchedResultsChangeInsert:
			//[self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
			//					  withRowAnimation:UITableViewRowAnimationRight];
			break;			
		case NSFetchedResultsChangeDelete:
			[self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
								  withRowAnimation:UITableViewRowAnimationFade];
			break;
	}
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
	[self.tableView endUpdates];
}

#pragma mark UITableViewDelegate, UITableViewDataSource
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section { 
	//TODO: determine why this weirdness is happening; after 3.2 upgrade, it's throwing an array index exception
	// for index 0, with 0 items. Shouldn't this just return a nil?
	if ([[frc sections] count] > 0){
		id <NSFetchedResultsSectionInfo> sectionInfo = [[frc sections] objectAtIndex:section];
		return [sectionInfo name];
	}
	return nil;
}
/*
 - (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
 return [frc sectionIndexTitles];
 }
 */
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    return [frc sectionForSectionIndexTitle:title atIndex:index];
}

-(NSInteger) tableView:(UITableView *) tableView numberOfRowsInSection:(NSInteger) section{
	NSArray *sections = [self.frc sections];
    NSUInteger count = 0;
    if ([sections count]) {
        id <NSFetchedResultsSectionInfo> sectionInfo = [sections objectAtIndex:section];
        count = [sectionInfo numberOfObjects];
    }
    return count;	
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *) tableView{
	NSInteger count = [[self.frc sections] count];
	//if (count == 0) count = 1;
	return count;
}

-(void) configureCell:(UITableViewCell *) cell withBookmark:(Bookmark *) bookmark{
	Book *book = [[self bookCache] bookForBookNumber:[bookmark.bookNumber intValue]];
	cell.textLabel.text = book.title;
	cell.detailTextLabel.text = [NSString stringWithFormat:@"Page #%d", [bookmark.pageNumber intValue]];
}
-(UITableViewCell *) tableView:(UITableView *) tableView cellForRowAtIndexPath:(NSIndexPath *) indexPath{
	static NSString *cellId = @"Bookmark";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
	if (cell == nil){
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
									   reuseIdentifier:cellId] autorelease];
		cell.showsReorderControl = NO;
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}
	Bookmark *bookmark = [self.frc objectAtIndexPath:indexPath];
	[self configureCell:cell withBookmark:bookmark];
	return cell;
}


-(void) tableView:(UITableView *) tableView didSelectRowAtIndexPath:(NSIndexPath *) indexPath{
	Bookmark *bookmark = [self.frc objectAtIndexPath:indexPath];
	Book *book = [[self bookCache] bookForBookNumber:[bookmark.bookNumber intValue]];
	
	NSMutableDictionary *query = [NSMutableDictionary dictionaryWithObjectsAndKeys:
								  book, @"book", bookmark.pageNumber, @"pageNumber", nil];
	
	[[TTNavigator navigator] openURL:@"tt://home/book" query:query animated:YES];
}	

- (void)tableView:(UITableView *)tableView 
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle 
forRowAtIndexPath:(NSIndexPath *)indexPath {
	
	if (editingStyle == UITableViewCellEditingStyleDelete) {
		Bookmark *bookmark = [self.frc objectAtIndexPath:indexPath];
		[[self bookmarkManager] deleteBookmark:bookmark];
	}   
}



@end

