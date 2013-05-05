//
//  MJRImageGalleryVC.m
//  Paint it!
//
//  Created by Giriprasad Reddy on 05/05/13.
//  Copyright (c) 2013 Let's Build. All rights reserved.
//

#import "MJRImageGalleryVC.h"
#import "NSData+Helper.h"
#import "MJRImage.h"

@interface MJRImageGalleryVC ()
@property (nonatomic, strong) NSMutableArray* leftColumnData;
@property (nonatomic, strong) NSMutableArray* rightColumnData;


@property (nonatomic, strong) NSMutableArray *localimages;
@property (nonatomic, strong) NSMutableArray *localCaptions;
@end

@implementation MJRImageGalleryVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIImage *revealImagePortrait = [UIImage imageNamed:@"reveal_menu_icon_portrait"];
    UIImage *revealImageLandscape = [UIImage imageNamed:@"reveal_menu_icon_landscape"];
    if (self.navigationController.revealController.type & PKRevealControllerTypeLeft)
    {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:revealImagePortrait landscapeImagePhone:revealImageLandscape style:UIBarButtonItemStylePlain target:self action:@selector(showLeftView:)];
    }

    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"expda-launch-linen.png"]]];
    
    /*
    //Configure buttons
    [self.tweetButton setBackgroundImage:[self.tweetButton.currentBackgroundImage stretchableImageWithLeftCapWidth:9
                                                                                                      topCapHeight:45]forState: UIControlStateNormal];
    [self.facebookButton setBackgroundImage:[self.facebookButton.currentBackgroundImage stretchableImageWithLeftCapWidth:9
                                                                                                            topCapHeight:45]forState: UIControlStateNormal];
    [self.titleLabel setFont:[UIFont fontWithName:@"Geometr415 Md BT" size:25]];*/
    
    
    self.leftColumnData=[NSMutableArray arrayWithCapacity:1];
    self.rightColumnData=[NSMutableArray arrayWithCapacity:1];
    self.localimages=[NSMutableArray arrayWithCapacity:1];
    self.localCaptions=[NSMutableArray arrayWithCapacity:1];
    
    [[[AppDatabase instance] imagesFromDatabase] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        MJRImage *img=(MJRImage *)obj;
        if (idx%2==0) {
            [self.leftColumnData addObject:obj];
        }
        else if (idx % 2 == 1){
            [self.rightColumnData addObject:obj];
        }
        
        [self.localimages addObject:img.image_directory_path];
        [self.localCaptions addObject:img.image_comment];
    }];
    
    
    MJRDbugLog(@"left=%d **** right=%d",self.leftColumnData.count,self.rightColumnData.count);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -
#pragma mark KLScrollview datasource
- (CGFloat)scrollRateForColumnAtIndex: (NSInteger) index {
    
    return 15 + index * 15;
}
-(NSInteger) numberOfColumnsInScrollSelect:(KLScrollSelect *)scrollSelect {
    return 2;
}
-(NSInteger) scrollSelect:(KLScrollSelect *)scrollSelect numberOfRowsInColumnAtIndex:(NSInteger)index {
    if (index == 0) {
        //Left column
        return self.leftColumnData.count;
    }
    //Right Column
    else return self.rightColumnData.count;
}
- (UITableViewCell*) scrollSelect:(KLScrollSelect*) scrollSelect cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    KLScrollingColumn* column = [[scrollSelect columns] objectAtIndex: indexPath.column];
    
    [column registerClass:[KLImageCell class] forCellReuseIdentifier:@"KLImageCell" ];
    KLImageCell* cell = [column dequeueReusableCellWithIdentifier:@"KLImageCell" forIndexPath:indexPath];
    
    [cell setSelectionStyle: UITableViewCellSelectionStyleNone];
    
    MJRImage* imgForCell = indexPath.column == 0? [self.leftColumnData objectAtIndex:indexPath.row] : [self.rightColumnData objectAtIndex:indexPath.row];
    //MJRDbugLog(@"path = %@",imgForCell.image_directory_path);
    
    dispatch_async(dispatch_get_main_queue(), ^{
        NSData *image_data=[NSData dataWithContentsOfFile:imgForCell.image_directory_path];
        
        [cell.image setImage:[UIImage imageWithData:image_data]];

    });
    
    //[cell.label setText:@"Fly to"];
    //[cell.subLabel setText: imgForCell.image_name];
    return cell;
}
- (void)scrollSelect:(KLScrollSelect *)tableView didSelectCellAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Selected cell at index %d, %d, %d", indexPath.column, indexPath.section, indexPath.row);
    
    FGalleryViewController *localGallery = [[FGalleryViewController alloc] initWithPhotoSource:self];
    //self.navigationController.navigationBar
    localGallery.startingIndex=indexPath.row;
    [self.navigationController pushViewController:localGallery animated:YES];
    
}
- (CGFloat) scrollSelect: (KLScrollSelect*) scrollSelect heightForColumnAtIndex: (NSInteger) index {
    return 150;
}


#pragma mark -
#pragma mark Actions
- (void)showLeftView:(id)sender
{
    if (self.navigationController.revealController.focusedController == self.navigationController.revealController.leftViewController)
    {
        [self.navigationController.revealController showViewController:self.navigationController.revealController.frontViewController];
    }
    else
    {
        [self.navigationController.revealController showViewController:self.navigationController.revealController.leftViewController];
    }
}





#pragma mark - FGalleryViewControllerDelegate Methods


- (int)numberOfPhotosForPhotoGallery:(FGalleryViewController *)gallery
{
    int num;

    num = [self.localimages count];

    return num;
}


- (FGalleryPhotoSourceType)photoGallery:(FGalleryViewController *)gallery sourceTypeForPhotoAtIndex:(NSUInteger)index
{
    return FGalleryPhotoSourceTypeLocal;
}


- (NSString*)photoGallery:(FGalleryViewController *)gallery captionForPhotoAtIndex:(NSUInteger)index
{
    NSString *caption;
    caption = [self.localCaptions objectAtIndex:index];
	return caption;
}


- (NSString*)photoGallery:(FGalleryViewController*)gallery filePathForPhotoSize:(FGalleryPhotoSize)size atIndex:(NSUInteger)index {
    return [self.localimages objectAtIndex:index];
}

- (NSString*)photoGallery:(FGalleryViewController *)gallery urlForPhotoSize:(FGalleryPhotoSize)size atIndex:(NSUInteger)index {
    return nil;//[networkImages objectAtIndex:index];
}

- (void)handleTrashButtonTouch:(id)sender {
    // here we could remove images from our local array storage and tell the gallery to remove that image
    // ex:
    //[localGallery removeImageAtIndex:[localGallery currentIndex]];
}


- (void)handleEditCaptionButtonTouch:(id)sender {
    // here we could implement some code to change the caption for a stored image
}

@end
/*- (IBAction)didSelectTweetButton:(id)sender {
 SLComposeViewController* shareViewController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
 [shareViewController addURL:[NSURL URLWithString:@"https://github.com/KieranLafferty/KLScrollSelect"]];
 [shareViewController setInitialText:@"I'm planning on using this UI control in my next iOS app!"];
 
 
 if ([SLComposeViewController isAvailableForServiceType:shareViewController.serviceType]) {
 [self presentViewController:shareViewController
 animated:YES
 completion: nil];
 }
 }
 
 - (IBAction)didSelectFacebookButton:(id)sender {
 SLComposeViewController* shareViewController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
 [shareViewController addURL:[NSURL URLWithString:@"https://github.com/KieranLafferty/KLScrollSelect"]];
 [shareViewController setInitialText:@"I'm planning on using this UI control in my next iOS app!"];
 
 
 if ([SLComposeViewController isAvailableForServiceType:shareViewController.serviceType]) {
 [self presentViewController:shareViewController
 animated:YES
 completion: nil];
 }
 
 }
 */