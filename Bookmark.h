//
//  Bookmark.h
//  BookReader
//
//  Created by Drew McAuliffe on 9/15/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>


@interface Bookmark :  NSManagedObject  
{
}

@property (nonatomic, retain) NSNumber * bookNumber;
@property (nonatomic, retain) NSNumber * pageNumber;

@end



