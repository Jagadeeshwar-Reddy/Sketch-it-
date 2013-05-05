//
//  MJRImageGalleryVC.h
//  Paint it!
//
//  Created by Giriprasad Reddy on 05/05/13.
//  Copyright (c) 2013 Let's Build. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KLScrollSelect.h"
#import "FGalleryViewController.h"

@interface MJRImageGalleryVC : UIViewController <KLScrollSelectDataSource, KLScrollSelectDelegate, FGalleryViewControllerDelegate>

@end
