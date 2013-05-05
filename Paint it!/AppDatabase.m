//
//  PreconfiguredData.m
//  homePad Pro v1.0
//
//  Created by in4biz Sàrl / Switzerland on 19/11/12.
//
//

#import "AppDatabase.h"
#import "Constants.h"
#import "MJRImage.h"
#import "NSData+Helper.h"

@interface AppDatabase(){
    
@private
    NSString *userlanguage;
    NSString *userCountry;
}
@property(nonatomic,retain) NSString *userlanguage;
@property(nonatomic,retain) NSString *userCountry;

-(NSString *)getDBPath;
-(void)copyDefaultConfigTextsDatabaseIfNeeded;


@end

#define FMDBQuickCheck(SomeBool) { if (!(SomeBool)) { MJRDbugLog(@"Failure on line %d", __LINE__); abort(); } }

@implementation AppDatabase
@synthesize userCountry;
@synthesize userlanguage;



//initialize is called automatically before the class gets any other message, per from
//+ (void)initialize
//{
//    static BOOL initialized = NO;
//    if(!initialized)
//    {
//        initialized = YES;
//        pre_configuredDataManager = [[PreconfiguredData alloc] init];
//    }
//}
//
//+ (PreconfiguredData *)instance
//{
//	return (pre_configuredDataManager);
//}
+ (AppDatabase *)instance {
    static AppDatabase *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[AppDatabase alloc] init];
    });
    
    return _sharedClient;
}

- (id)init
{
    if(self=[super init]){
        [self copyDefaultConfigTextsDatabaseIfNeeded];
    }
	return self;
}
- (NSString *)getDBPath
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
	NSString *documentsDir = [paths objectAtIndex:0];
    NSString *dbPath=[documentsDir stringByAppendingPathComponent:@"PaintAppDatabase.sqlite"];
    
    //MJRDbugLog(@"%@",dbPath);
    
	return dbPath;
}
-(void)copyDefaultConfigTextsDatabaseIfNeeded {
	//Using NSFileManager we can perform many file system operations.
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSError *error=nil;
	NSString *dbPath = [KDocumentsDirectory stringByAppendingPathComponent:@"PaintAppDatabase.sqlite"];
	BOOL success = [fileManager fileExistsAtPath:dbPath];
	//MJRDbugLog(@"%@",dbPath);
    
	if(!success) {
		NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"PaintAppDatabase.sqlite"];
		success = [fileManager copyItemAtPath:defaultDBPath toPath:dbPath error:&error];
		dbPath=nil;
		if (!success)
			NSAssert1(0, @"Failed to create writable database file with message '%@'.", [error description]);
	}
    dbPath=nil;
}


-(FMDatabase *)openDatabaseConnection{

    NSString *dbPath = [self getDBPath];
    //[KDocumentsDirectory stringByAppendingPathComponent:@"PaintAppDatabase.sqlite"];

    [self copyDefaultConfigTextsDatabaseIfNeeded];
    FMDatabase *newDb = [FMDatabase databaseWithPath:dbPath];
    [newDb setShouldCacheStatements:NO];
    [newDb setLogsErrors:YES];
    //MJRDbugLog(@"Is SQLite compiled with it's thread safe options turned on? %@!", [FMDatabase isSQLiteThreadSafe] ? @"Yes" : @"No");
    
    if (![newDb open]) {
        MJRDbugLog(@"Could not open application database");
        
        return nil;
    }
    
    return newDb;
}
/*
#pragma mark -
#pragma mark Private methods
-(NSNumber*)idForUserlanguage:(FMDatabase *)db
{
    return [self idForlanguage:self.userlanguage country:self.userCountry dbconn:db];
}
-(NSNumber*)idForlanguage:(NSString*)lang country:(NSString*)country dbconn:(FMDatabase *)db
{
    
    NSNumber *lang_id=[NSNumber numberWithInt:0];
    
    FMResultSet *rs = [db executeQuery:@"SELECT lang_ref_id FROM Country WHERE country = ? and supported_lang = ?", country,lang];
    
    while ([rs next]) {
        lang_id=[NSNumber numberWithInt:[rs intForColumn:@"lang_ref_id"]];
    }
    // close the result set.
    // it'll also close when it's dealloc'd, but we're closing the database before
    [rs close];
    
    FMDBQuickCheck(![db hasOpenResultSets]);
    
    return lang_id;
}


#pragma mark -
#pragma mark dboperations

-(NSMutableArray *)valuesForkey:(NSString*)table
{

    FMDatabase *db = [self openDatabaseConnection];
    
    FMResultSet *rs = [db executeQueryWithFormat:[NSString stringWithFormat:@"SELECT value FROM %@ WHERE lang_ref_id = %d",table, [[self idForUserlanguage:db] intValue]]];
    
    NSMutableArray *values=[NSMutableArray arrayWithCapacity:1];
    while ([rs next]) {
        
        NSString *objname = [rs stringForColumn:@"value"];
        [values addObject:objname];
        
        //hPDebugLog(@"objname: %@ ",objname);
    }
    // close the result set.
    [rs close];
    
    FMDBQuickCheck(![db hasOpenResultSets]);
    
    [db close];
    
    return values;
}
-(NSMutableArray*)configuredRoomTypes{
    FMDatabase *db = [self openDatabaseConnection];

    BOOL isExternalListAvailable=NO;
    FMResultSet *rs = [db executeQueryWithFormat:[NSString stringWithFormat:@"SELECT COUNT() FROM RoomsList WHERE external_id !='' AND lang_ref_id=%d",[[self idForUserlanguage:db] intValue]]];
    
    while ([rs next]) {
        isExternalListAvailable = ([rs intForColumnIndex:0]>0?YES:NO);
    }
    [rs close];
    FMDBQuickCheck(![db hasOpenResultSets]);
    [db close];
    
    if (isExternalListAvailable)
    {
        FMDatabase *db = [self openDatabaseConnection];
        
        FMResultSet *rs = [db executeQueryWithFormat:[NSString stringWithFormat:@"SELECT external_title FROM %@ WHERE lang_ref_id = %d AND external_id !=''",k_ri_tablename, [[self idForUserlanguage:db] intValue]]];
        
        NSMutableArray *values=[NSMutableArray arrayWithCapacity:1];
        while ([rs next]) {
            
            NSString *objname = [rs stringForColumn:@"external_title"];
            [values addObject:objname];
            
            //hPDebugLog(@"objname: %@ ",objname);
        }
        // close the result set.
        [rs close];
        
        FMDBQuickCheck(![db hasOpenResultSets]);
        
        [db close];
        
        return values;
    }
    else
    {
        return [self valuesForkey:k_ri_tablename];
    }
    return nil;
}
-(NSString*)uniqueidForRoom:(NSString*)roomtype{
    FMDatabase *db = [self openDatabaseConnection];
    NSString *q=[NSString stringWithFormat:@"SELECT obj_ref_code FROM %@ WHERE external_id != '' AND external_title = \"%@\" AND lang_ref_id = %d",k_ri_tablename, roomtype, [[self idForUserlanguage:db] intValue]];
    
    FMResultSet *rs = [db executeQueryWithFormat:q];
    
    NSString *uniqueid=@"";
    while ([rs next]) {
        uniqueid = [rs stringForColumnIndex:0];
        //hPDebugLog(@"uniqueid: %@ ",uniqueid);
    }
    // close the result set.
    [rs close];
    
    FMDBQuickCheck(![db hasOpenResultSets]);
    
    [db close];
    
    if (!uniqueid || [uniqueid length]==0) {
        return [self uniqueidForValue:roomtype ofLanguage:userlanguage forCountry:userCountry fromtable:k_ri_tablename];
    }
    return uniqueid;
}
-(NSNumber*)externalidForRoom:(NSString*)roomtype refCode:(NSString*)obj_ref_code{
    FMDatabase *db = [self openDatabaseConnection];
    NSString *q=[NSString stringWithFormat:@"SELECT external_id FROM %@ WHERE external_title = \"%@\" AND obj_ref_code=\"%@\" AND lang_ref_id = %d",k_ri_tablename, roomtype, obj_ref_code, [[self idForUserlanguage:db] intValue]];
    
    //SELECT external_id FROM RoomsList WHERE external_title="Entrée" AND obj_ref_code="ri-3"
    FMResultSet *rs = [db executeQueryWithFormat:q];
    
    int ext_id=-1;
    while ([rs next]) {
        ext_id = [rs intForColumn:@"external_id"];
    }
    // close the result set.
    [rs close];
    
    FMDBQuickCheck(![db hasOpenResultSets]);
    
    [db close];
    return [NSNumber numberWithInt:ext_id];
}
-(NSString*)roomTypeWithUniqueid:(NSString*)objref externalId:(int)ext_id
{
    FMDatabase *db = [self openDatabaseConnection];
    NSString *q=[NSString stringWithFormat:@"SELECT external_title FROM %@ WHERE external_id = %d AND obj_ref_code=\"%@\" AND lang_ref_id = %d",k_ri_tablename, ext_id, objref, [[self idForUserlanguage:db] intValue]];
    
    FMResultSet *rs = [db executeQueryWithFormat:q];
    
    NSString *roomtype=@"";
    while ([rs next]) {
        roomtype = [rs stringForColumnIndex:0];
        //hPDebugLog(@"uniqueid: %@ ",uniqueid);
    }
    // close the result set.
    [rs close];
    
    FMDBQuickCheck(![db hasOpenResultSets]);
    
    [db close];
    
    if (!roomtype || [roomtype length]==0) {
        return [self valueForuniqueid:objref fromtable:k_ri_tablename];
    }
    return roomtype;
}


#pragma mark -
-(NSString*)uniqueidForValue:(NSString*)value fromtable:(NSString*)table{
    
    if ([table isEqualToString:k_ri_tablename]) return [self uniqueidForRoom:value];
    
    return [self uniqueidForValue:value ofLanguage:userlanguage forCountry:userCountry fromtable:table];
}
-(NSString*)uniqueidForValue:(NSString*)value
                  ofLanguage:(NSString*)lang
                  forCountry:(NSString*)country
                   fromtable:(NSString*)table
{
    FMDatabase *db = [self openDatabaseConnection];
    NSString *q=[NSString stringWithFormat:@"SELECT obj_ref_code FROM %@ WHERE value = \"%@\" AND lang_ref_id = %d",table, value, [[self idForlanguage:lang country:country dbconn:db] intValue]];
    
    
    FMResultSet *rs = [db executeQueryWithFormat:q];

    NSString *uniqueid=@"";
    while ([rs next]) {
        uniqueid = [rs stringForColumn:@"obj_ref_code"];
        //hPDebugLog(@"uniqueid: %@ ",uniqueid);
    }
    // close the result set.
    [rs close];
    
    FMDBQuickCheck(![db hasOpenResultSets]);
    
    [db close];
    
    return uniqueid;
}


#pragma mark -
-(NSString*)valueForuniqueid:(NSString*)unqid fromtable:(NSString*)table{
    return [self valueForuniqueid:unqid ofLanguage:self.userlanguage forCountry:self.userCountry fromtable:table];
}
-(NSString*)valueForuniqueid:(NSString*)unqid ofLanguage:(NSString*)lang
                  forCountry:(NSString*)country
                   fromtable:(NSString*)table{
    FMDatabase *db = [self openDatabaseConnection];
    NSString *q= [NSString stringWithFormat:@"SELECT value FROM %@ WHERE obj_ref_code = \"%@\" AND lang_ref_id = %d",table, unqid, [[self idForlanguage:lang country:country dbconn:db] intValue]];
    
    FMResultSet *rs = [db executeQueryWithFormat:q];
    
    NSString *uniqueid=@"";
    while ([rs next]) {
        uniqueid = [rs stringForColumn:@"value"];
        //hPDebugLog(@"objname: %@ ",objname);
    }
    // close the result set.
    [rs close];
    
    FMDBQuickCheck(![db hasOpenResultSets]);
    
    [db close];
    
    return uniqueid;
}

*/

-(void)addImageToDatabase:(UIImage *)img imageName:(NSString*)image_name comment:(NSString*)comment_str{
    
    FMDatabase *db = [self openDatabaseConnection];
    [db beginTransaction];
    
    NSDate *date_now = [NSDate date];
    
    [db executeUpdate:@"INSERT INTO Images (image_name,image,comment,creation_date,modified_date) VALUES (?, ?, ?, ?, ?)" ,image_name,
     UIImagePNGRepresentation(img),
     comment_str,
     [NSDateFormatter stringFromDate:date_now withFormat:@"yyyy-MM-dd HH:mm:ss"],
     [NSDateFormatter stringFromDate:date_now withFormat:@"yyyy-MM-dd HH:mm:ss"]];
    [db commit];
    
    [db close];
}
-(void)removeImageWithId:(NSInteger)image_id{
    FMDatabase *db = [self openDatabaseConnection];
    
    [db beginTransaction];    
    //[db executeUpdate:[NSString stringWithFormat:@"DELETE FROM Images WHERE id != ''",k_ri_tablename]];
    [db executeUpdate:@"DELETE FROM Images WHERE id = ?",image_id];
    [db commit];
    
    [db close];
}





-(NSMutableArray *)imagesFromDatabase{
    NSMutableArray *images=[[NSMutableArray alloc] initWithCapacity:1];
    
    FMDatabase *db = [self openDatabaseConnection];
    
    FMResultSet *rs = [db executeQuery:@"SELECT * FROM Images"];
    
    while ([rs next]) {
        
        NSUInteger image_id= [rs intForColumn:@"id"];
        NSString *image_name = [rs stringForColumn:@"image_name"];
        NSData *image_data = [rs dataForColumn:@"image"];
        NSString *image_comment = [rs stringForColumn:@"comment"];
        NSString *creation_date = [rs stringForColumn:@"creation_date"];
        NSString *modified_date = [rs stringForColumn:@"modified_date"];
        
        NSString *storage_file_name=@"";
        if(image_data){
            storage_file_name=[NSString stringWithFormat:@"image_%d.png",image_id];
            storage_file_name=[image_data putTofile:storage_file_name
                                searchPathDirectory:NSCachesDirectory];
        }
        
        MJRImage *img = [MJRImage objectWithDictionary:@{@"image_id": [NSNumber numberWithInt:image_id],@"image_name" : image_name, @"image_data" : image_data, @"image_directory_path" : storage_file_name, @"comment" : image_comment, @"creation_date" : creation_date, @"modified_date" : modified_date}];
        
        [images addObject:img];
        
    }
    // close the result set.
    [rs close];
    
    FMDBQuickCheck(![db hasOpenResultSets]);
    
    [db close];
    
    return images;
}
@end