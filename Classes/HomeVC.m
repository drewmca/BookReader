//
//  RootViewController.m
//  BookReader
//
//  Created by Drew McAuliffe on 9/10/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "HomeVC.h"
#import "Book.h"
#import "BookCache.h"
#import "BookViewerVC.h"
#import "BookmarkListVC.h"
#import "BookReaderAppDelegate.h"
@implementation HomeVC
//@synthesize fetchedResultsController, managedObjectContext;

- (void)dealloc {
	//	[fetchedResultsController release];
	//	[managedObjectContext release];
    [super dealloc];
}
-(BookCache *) bookCache{
	return ((BookReaderAppDelegate *)[[UIApplication sharedApplication] delegate]).bookCache;
}

#pragma mark -
#pragma mark View lifecycle


- (id)init{
	if (self = [super init]) {
		[super viewDidLoad];
		self.title = @"Home";
		self.tableViewStyle = UITableViewStyleGrouped;
			
		CGRect titleRect = CGRectMake(0,0,300,40);
		UILabel *header = [[UILabel alloc] initWithFrame:titleRect];
		header.text = @"Any view can be placed here as the header";
		header.textColor = [UIColor blueColor];
		header.backgroundColor = self.tableView.backgroundColor;
		header.opaque = YES;
		header.textAlignment = UITextAlignmentCenter;
		header.font = [UIFont boldSystemFontOfSize:10];
		self.tableView.tableHeaderView = header;
		
		UILabel *footer = [[UILabel alloc] initWithFrame:titleRect];
		footer.text = @"Any view can be placed here as the footer";
		footer.textColor = [UIColor blueColor];
		footer.backgroundColor = self.tableView.backgroundColor;
		footer.opaque = YES;
		footer.textAlignment = UITextAlignmentCenter;
		footer.font = [UIFont boldSystemFontOfSize:10];
		self.tableView.tableFooterView = footer;

		
		NSMutableArray *books = [[[NSMutableArray alloc] init] autorelease];
		for (Book *book in [self bookCache].books){
			NSString *path =[NSString stringWithFormat:@"bundle://books/%@/cover.jpg", book.basePath];
			TTTableSubtitleItem *item = [TTTableSubtitleItem
				itemWithText:[NSString stringWithFormat:@"%@ #%@", book.series, book.issue] 
				subtitle:book.title 
				imageURL:path
				defaultImage:nil
				URL:@"tt://home/book"
				accessoryURL:nil];
			NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObject:book forKey:@"book"];
			item.query = dict;
			[books addObject:item];
		}
		self.dataSource = [TTListDataSource dataSourceWithItems:books];
		
		
		//[self.tableView reloadData];
		[header release];
		[footer release];
		

		UIBarButtonItem *showBookmarks = [[UIBarButtonItem alloc] 
					initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self action:@selector(showBookmarks)];
		self.navigationItem.rightBarButtonItem = showBookmarks;
		[showBookmarks release];
	}
	return self;
}
-(void) showBookmarks{
	/*
	BookmarkListVC *bookmarkList = [[BookmarkListVC alloc] initWithStyle:UITableViewStyleGrouped];
	[self.navigationController pushViewController:bookmarkList animated:YES];
	[bookmarkList release];
	 */
	TTOpenURL(@"tt://home/bookmarks");
	
}
/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}
*/

- (void)viewDidUnload {
	// Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
	// For example: self.myOutlet = nil;
}

/*
 // Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations.
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
 */



#pragma mark -
#pragma mark Table view methods
/*
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [[self bookCache].books count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
	// Configure the cell.
	Book *book = (Book *) [[self bookCache].books objectAtIndex:indexPath.row];
	cell.textLabel.text = [NSString stringWithFormat:@"%@ #%@", book.series, book.issue];
	cell.detailTextLabel.text = book.title;
	NSString *path = [[NSBundle mainBundle] pathForResource:@"cover" ofType:@"jpg"];
	UIImage *img = [UIImage imageWithContentsOfFile:path];
	cell.imageView.image = img;

    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	NSLog(@"Index is section %d, row %d", indexPath.section, indexPath.row);
	Book *book = (Book *) [[self bookCache].books objectAtIndex:indexPath.row];
	NSLog(@"Selected book '%@'", book.title);
	[self goToBook:book];
}

-(void) goToBook:(Book *) book{
	BookViewerVC *bookViewer = [[BookViewerVC alloc] initWithPhotoSource:book];
	bookViewer.book = book;
	[self.navigationController pushViewController:bookViewer animated:YES];
	[bookViewer release];	
}



- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // The table view should not be re-orderable.
    return NO;
}


#pragma mark -
#pragma mark Fetched results controller

*/

#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
	// Relinquish ownership of any cached data, images, etc that aren't in use.
}


@end

