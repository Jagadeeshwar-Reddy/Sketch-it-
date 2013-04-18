//
//  MJRViewController.h
//  Paint it!
//
//  Created by Jagadeeshwar Reddy on 27/03/13.
//  Copyright (c) 2013 Let's Build. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AwesomeMenu.h"

@interface MJRPaintBoardVC : UIViewController <AwesomeMenuDelegate>
@property (strong, nonatomic) IBOutlet UIView *settings_view;

- (IBAction)openpaintSettings:(id)sender;

@end
