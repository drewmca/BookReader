//
//  main.m
//  BookReader
//
//  Created by Drew McAuliffe on 9/10/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

int main(int argc, char *argv[]) {
    
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    int retVal = UIApplicationMain(argc, argv, nil, @"BookReaderAppDelegate");
    [pool release];
    return retVal;
}
