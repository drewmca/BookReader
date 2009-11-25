//
//  BookCache.h
//  BookReader
//
//  Created by Drew McAuliffe on 9/10/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Book;
@interface BookCache : NSObject {
	NSArray *books;
}
extern NSString *const BOOKS_PATH;

@property(nonatomic, retain) NSArray *books;
-(void) load;
-(Book *) bookForBookNumber:(NSInteger) bookNumber;
@end
