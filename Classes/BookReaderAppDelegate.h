//
//  BookReaderAppDelegate.h
//  BookReader
//
//  Created by Drew McAuliffe on 9/10/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//
#import <Three20/Three20.h>
@class BookmarkManager;
@class BookCache;
@interface BookReaderAppDelegate : NSObject <UIApplicationDelegate> {
    
    NSManagedObjectModel *managedObjectModel;
    NSManagedObjectContext *managedObjectContext;	    
    NSPersistentStoreCoordinator *persistentStoreCoordinator;

    UIWindow *window;
    UINavigationController *navigationController;
	
	BookmarkManager *bookmarkManager;
	BookCache *bookCache;
}

@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@property (nonatomic, retain) BookmarkManager *bookmarkManager;
@property (nonatomic, retain) BookCache *bookCache;
- (NSString *)applicationDocumentsDirectory;

@end

