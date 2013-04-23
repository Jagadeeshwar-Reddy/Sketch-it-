//
//  MJRViewController.h
//  Paint it!
//
//  Created by Jagadeeshwar Reddy on 27/03/13.
//  Copyright (c) 2013 Let's Build. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AwesomeMenu.h"
#import "NEOColorPickerViewController.h"

@interface MJRPaintBoardVC : UIViewController <AwesomeMenuDelegate,NEOColorPickerViewControllerDelegate>






#pragma mark -
#pragma mark Paint settings view
@property (strong, nonatomic) IBOutlet UIView *settings_view;
@property (weak, nonatomic) IBOutlet UIView *selected_bg_color_indicator;
@property (weak, nonatomic) IBOutlet UIView *selected_brush_color_indicator;
@property (weak, nonatomic) IBOutlet UISlider *brush_width_slider;
@property (weak, nonatomic) IBOutlet UILabel *configured_slider_value;
- (IBAction)pickColor:(id)sender;

- (IBAction)brushWidthChanged:(UISlider *)sender;

- (IBAction)openpaintSettings:(id)sender;


@end
