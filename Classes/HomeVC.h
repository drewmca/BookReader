//
//  RootViewController.h
//  BookReader
//
//  Created by Drew McAuliffe on 9/10/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//
#import <Three20/Three20.h>

#import "BookCache.h"
@interface HomeVC : TTTableViewController {//<NSFetchedResultsControllerDelegate> {
//	NSFetchedResultsController *fetchedResultsController;
//	NSManagedObjectContext *managedObjectContext;
}
-(BookCache *) bookCache;
-(void) goToBook:(Book *)book;
//@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
//@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@end
