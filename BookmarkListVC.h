//
//  BookmarkListVC.h
//  BookReader
//
//  Created by Drew McAuliffe on 9/15/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
@class BookmarkManager;
@class BookCache;
@interface BookmarkListVC : UITableViewController 
<NSFetchedResultsControllerDelegate> {
	NSFetchedResultsController *frc;

}
@property (nonatomic, retain) NSFetchedResultsController *frc;
-(BookmarkManager *) bookmarkManager;
-(BookCache *) bookCache;
@end
