//
//  MJRImage.m
//  Paint it!
//
//  Created by Giriprasad Reddy on 05/05/13.
//  Copyright (c) 2013 Let's Build. All rights reserved.
//

#import "MJRImage.h"

@implementation MJRImage
@synthesize image_id;
@synthesize image_name;
@synthesize image_comment;
@synthesize image_directory_path;
@synthesize date_of_creation;
@synthesize date_of_modification;
@synthesize image_data;

+ (id) objectWithDictionary:(NSDictionary*)dictionary
{
    id obj = [[MJRImage alloc] initWithDictionary:dictionary];
    return obj;
}
- (id) initWithDictionary:(NSDictionary*)dictionary
{
    self=[super init];
    if(self)
    {        
        self.image_id=[[dictionary objectForKey:@"image_id"] intValue];
        self.image_name=[dictionary objectForKey:@"image_name"];
        self.image_directory_path=[dictionary objectForKey:@"image_directory_path"];
        self.image_data=[dictionary objectForKey:@"image_data"];
        self.image_comment=[dictionary objectForKey:@"comment"];
        self.date_of_creation=[dictionary objectForKey:@"creation_date"];
        self.date_of_modification=[dictionary objectForKey:@"modified_date"];
        
    }
    return self;
}
@end
