//
//  MJRAppDelegate.h
//  Paint it!
//
//  Created by Jagadeeshwar Reddy on 27/03/13.
//  Copyright (c) 2013 Let's Build. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PKRevealController.h"

@class MJRSplashScreenVC;
@class PKRevealController;

@interface MJRAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) MJRSplashScreenVC *splashScreen;



@property (nonatomic, strong, readwrite) PKRevealController *revealController;
@end
