//
//  NSData+Helper.h
//  Paint it!
//
//  Created by Giriprasad Reddy on 05/05/13.
//  Copyright (c) 2013 Let's Build. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (Helper)

- (NSData*)loadfile:(NSString*)fileName searchPathDirectory:(NSSearchPathDirectory)dir;
- (NSString *)putTofile:(NSString*)fileName searchPathDirectory:(NSSearchPathDirectory)dir;

+ (NSData*)loadFileWithName:(NSString*)fullPath searchPathDirectory:(NSSearchPathDirectory)dir;

+ (NSString*)thumbcachepath:(NSSearchPathDirectory)dir;
@end
