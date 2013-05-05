//
//  NSData+Helper.m
//  Paint it!
//
//  Created by Giriprasad Reddy on 05/05/13.
//  Copyright (c) 2013 Let's Build. All rights reserved.
//

#import "NSData+Helper.h"

@implementation NSData (Helper)

+ (NSData*)loadFileWithName:(NSString*)fullPath searchPathDirectory:(NSSearchPathDirectory)dir{
    //NSString *fullPath = [[NSData thumbcachepath:dir] stringByAppendingPathComponent:fileName];
	NSData *file_data=[NSData dataWithContentsOfFile:fullPath];
	return file_data;
}

- (NSData*)loadfile:(NSString*)fileName searchPathDirectory:(NSSearchPathDirectory)dir{
	NSString *fullPath = [[NSData thumbcachepath:dir] stringByAppendingPathComponent:fileName];
	NSData *file_data=[NSData dataWithContentsOfFile:fullPath];
	return file_data;
}

- (NSString *)putTofile:(NSString*)fileName searchPathDirectory:(NSSearchPathDirectory)dir{

	NSString *fullPath = [[NSData thumbcachepath:dir] stringByAppendingPathComponent:fileName];
	BOOL result = [self writeToFile:fullPath atomically:YES];
    if (!result) {
        MJRDbugLog(@"********* FILE WRITE FAILED********");
    }
	return fullPath;
}

+(NSString*)thumbcachepath:(NSSearchPathDirectory)dir{
    NSString *theCachesPath = nil; // Application caches path string
    NSArray *cachesPaths = NSSearchPathForDirectoriesInDomains(dir, NSUserDomainMask, YES);
    theCachesPath = [cachesPaths objectAtIndex:0]; // Keep a copy for later abusage
    
    NSFileManager *fileManager = [NSFileManager defaultManager]; // File manager instance
    
    theCachesPath=[theCachesPath stringByAppendingPathComponent:@"App_Thumbs"];
	if(![fileManager fileExistsAtPath:theCachesPath])
        [fileManager createDirectoryAtPath:theCachesPath withIntermediateDirectories:NO attributes:nil error:NULL];
    
    return theCachesPath;
}
@end
