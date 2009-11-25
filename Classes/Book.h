//
//  Book.h
//  BookReader
//
//  Created by Drew McAuliffe on 9/10/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Three20/Three20.h>

@interface Book : NSObject <TTPhotoSource> {
	NSInteger bookNumber;
	NSString *series;
	NSString *issue;
	NSString *title;
	NSString *basePath;
	NSMutableArray *pages;
}
@property (nonatomic, retain) NSString *series;
@property (nonatomic) NSInteger bookNumber;
@property (nonatomic, retain) NSString *issue;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, retain) NSString *basePath;
@property (nonatomic, retain) NSMutableArray *pages;

-(id) initWithBasePath:(NSString *) path withSeries:(NSString *) series 
			 withIssue:(NSString *) issue withTitle:(NSString *) title withBookNumber:(NSInteger) number;

@end
