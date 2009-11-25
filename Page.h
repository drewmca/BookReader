//
//  Page.h
//  BookReader
//
//  Created by Drew McAuliffe on 9/12/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Three20/Three20.h>
@class Book;
@interface Page : NSObject <TTPhoto> {
// For TTPhoto
	NSInteger index;
	CGSize size;
// For Page
	Book *book;
	NSString *filename;
//	NSString *thumbURL;
//	NSString *smallURL;
//	NSString *URL;
	NSInteger pageNumber;
}
@property (nonatomic, assign) id<TTPhotoSource> photoSource;
@property (nonatomic) NSInteger index;
@property (nonatomic) CGSize size;
//@property (nonatomic, retain) NSString *thumbURL;
//@property (nonatomic, retain) NSString *smallURL;
//@property (nonatomic, retain) NSString *URL;
@property (nonatomic, retain) NSString *filename;
@property (nonatomic) NSInteger pageNumber;
//@property (nonatomic, assign) Book *book;

-(id) initWithFilename:(NSString *) filename forBook:(Book *) forBook
	 withSize:(CGSize) withSize withPageNumber:(NSInteger) withPageNumber;

@end
