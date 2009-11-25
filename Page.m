//
//  Page.m
//  BookReader
//
//  Created by Drew McAuliffe on 9/12/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Page.h"

#import "Book.h"
@implementation Page
@synthesize photoSource = book, index, size, filename, pageNumber; //thumbURL, smallURL, URL

-(void) dealloc{
//	TT_RELEASE_SAFELY(thumbURL);
//	TT_RELEASE_SAFELY(smallURL);
//	TT_RELEASE_SAFELY(URL);
	TT_RELEASE_SAFELY(filename);
//	TT_RELEASE_SAFELY(book);
	[super dealloc];
}

-(NSString *) caption{
	return nil;//[NSString stringWithFormat:@"Page %d", self.pageNumber];
}

-(id<TTPhotoSource>) photoSource{return book;}

- (NSString*)URLForVersion:(TTPhotoVersion)version {
	NSString *path = [NSString stringWithFormat:@"bundle://books/%@/%@", book.basePath, self.filename];
	return path;
	/*
	if (version == TTPhotoVersionLarge) {
		return self.URL;
	} else if (version == TTPhotoVersionMedium) {
		return self.URL;
	} else if (version == TTPhotoVersionSmall) {
		return self.smallURL;
	} else if (version == TTPhotoVersionThumbnail) {
		return self.thumbURL;
	} else {
		return nil;
	}
	*/
}
-(id) initWithFilename:(NSString *) withFilename forBook:(Book *) forBook
			  withSize:(CGSize) withSize withPageNumber:(NSInteger) withPageNumber{
	if (self = [super init]) {
		self.filename = withFilename;
		book = forBook;
		self.size = withSize;
		self.pageNumber = withPageNumber;
	}
	return self;
}




@end
