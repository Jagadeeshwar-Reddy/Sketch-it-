//
//  PreconfiguredData.h
//  homePad Pro v1.0
//
//  Created by in4biz Sàrl / Switzerland on 19/11/12.
//
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"
#import "FMDatabasePool.h"
#import "FMDatabaseQueue.h"

@interface AppDatabase : NSObject

+(AppDatabase *)instance;
-(void)addImageToDatabase:(UIImage *)img imageName:(NSString*)image_name comment:(NSString*)comment_str;
-(void)removeImageWithId:(NSInteger)image_id;
-(NSMutableArray *)imagesFromDatabase;

@end
