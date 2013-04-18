//
//  MJRSplashScreenVC.h
//  Paint it!
//
//  Created by Giriprasad Reddy on 27/03/13.
//  Copyright (c) 2013 Let's Build. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FXLabel.h"

@interface MJRSplashScreenVC : UIViewController
@property (weak, nonatomic) IBOutlet FXLabel *main_title;
@property (weak, nonatomic) IBOutlet FXLabel *author_label;
@property (weak, nonatomic) IBOutlet FXLabel *copyright_label;

@end
