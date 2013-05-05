//
//  MJRMainMenuVC.h
//  Paint it!
//
//  Created by Giriprasad Reddy on 17/04/13.
//  Copyright (c) 2013 Let's Build. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRPaintBoardVC.h"

@interface MJRMainMenuVC : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *menu_tableview;

@property (weak, nonatomic) IBOutlet UIButton *pickFrom_camera_btn;

@property (weak, nonatomic) IBOutlet UIButton *pickFrom_Library_btn;
@property (strong, nonatomic) UINavigationController *paintboard_navigController;
@end
