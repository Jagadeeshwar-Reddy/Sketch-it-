//
//  MJRImage.h
//  Paint it!
//
//  Created by Giriprasad Reddy on 05/05/13.
//  Copyright (c) 2013 Let's Build. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MJRImage : NSObject

@property (nonatomic, assign) NSUInteger image_id;
@property (nonatomic, retain) NSString *image_name;
@property (nonatomic, retain) NSString *image_comment;
@property (nonatomic, retain) NSString *image_directory_path;
@property (nonatomic, retain) NSString *date_of_creation;
@property (nonatomic, retain) NSString *date_of_modification;

@property (nonatomic, retain) NSData *image_data;
+ (id) objectWithDictionary:(NSDictionary*)dictionary;

@end
