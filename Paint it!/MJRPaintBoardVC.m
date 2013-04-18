//
//  MJRViewController.m
//  Paint it!
//
//  Created by Jagadeeshwar Reddy on 27/03/13.
//  Copyright (c) 2013 Let's Build. All rights reserved.
//

#import "MJRPaintBoardVC.h"


#define UIViewAutoresizingFlexibleAll (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight |    UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin)


@interface MJRPaintBoardVC (){
    BOOL isCurlStarted;
}
@end

@implementation MJRPaintBoardVC

#pragma mark  -Init
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:67/255.0 green:130/255.0 blue:167/255.0 alpha:1.0];
    
    _settings_view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"pattern_bg"]];
    
    
    UIImage *revealImagePortrait = [UIImage imageNamed:@"reveal_menu_icon_portrait"];
    UIImage *revealImageLandscape = [UIImage imageNamed:@"reveal_menu_icon_landscape"];
    if (self.navigationController.revealController.type & PKRevealControllerTypeLeft)
    {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:revealImagePortrait landscapeImagePhone:revealImageLandscape style:UIBarButtonItemStylePlain target:self action:@selector(showLeftView:)];
    }

    
    UIImage *storyMenuItemImage = [UIImage imageNamed:@"bg-menuitem.png"];
    UIImage *storyMenuItemImagePressed = [UIImage imageNamed:@"bg-menuitem-highlighted.png"];
    
    UIImage *starImage = [UIImage imageNamed:@"icon-star.png"];
    
    AwesomeMenuItem *starMenuItem1 = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage
                                                           highlightedImage:storyMenuItemImagePressed
                                                               ContentImage:starImage
                                                    highlightedContentImage:nil];
    AwesomeMenuItem *starMenuItem2 = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage
                                                           highlightedImage:storyMenuItemImagePressed
                                                               ContentImage:starImage
                                                    highlightedContentImage:nil];
    AwesomeMenuItem *starMenuItem3 = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage
                                                           highlightedImage:storyMenuItemImagePressed
                                                               ContentImage:starImage
                                                    highlightedContentImage:nil];
    AwesomeMenuItem *starMenuItem4 = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage
                                                           highlightedImage:storyMenuItemImagePressed
                                                               ContentImage:starImage
                                                    highlightedContentImage:nil];
    AwesomeMenuItem *starMenuItem5 = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage
                                                           highlightedImage:storyMenuItemImagePressed
                                                               ContentImage:starImage
                                                    highlightedContentImage:nil];
    NSArray *menus = [NSArray arrayWithObjects:starMenuItem1, starMenuItem2, starMenuItem3, starMenuItem4, starMenuItem5, nil];
    
    CGRect menuItem_position=self.view.frame;
    menuItem_position.origin.y-=60;
    AwesomeMenu *menu = [[AwesomeMenu alloc] initWithFrame:menuItem_position menus:menus];

    menu.menuWholeAngle = M_PI/1.5;
	// customize menu
	/*
     menu.rotateAngle = M_PI/3;
     
     menu.timeOffset = 0.2f;
     menu.farRadius = 180.0f;
     menu.endRadius = 100.0f;
     menu.nearRadius = 50.0f;
     */
    
    menu.startPoint = CGPointMake(35.0, 440.0);
	
    menu.delegate = self;
    
    [self.view addSubview:menu];
}
#pragma mark - Autorotation

/*
 * iOS 6 new rotation handling as if you were to nest this controller within a UINavigationController,
 * the UINavigationController would _NOT_ relay rotation requests to his children on its own!
 */

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}

#pragma mark - Actions

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


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -
/* ⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇ */
/* ⬇⬇⬇⬇⬇⬇ GET RESPONSE OF MENU ⬇⬇⬇⬇⬇⬇ */
/* ⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇⬇ */

- (void)AwesomeMenu:(AwesomeMenu *)menu didSelectIndex:(NSInteger)idx
{
    NSLog(@"Select the index : %d",idx);
}
- (void)AwesomeMenuDidFinishAnimationClose:(AwesomeMenu *)menu {
    NSLog(@"Menu was closed!");
}
- (void)AwesomeMenuDidFinishAnimationOpen:(AwesomeMenu *)menu {
    NSLog(@"Menu is open!");
}

- (IBAction)openpaintSettings:(id)sender {

    if (isCurlStarted == NO) {
        [UIView animateWithDuration:1.0 animations:^{
            CATransition *animation = [CATransition animation];
            [animation setDelegate:self];
            [animation setDuration:0.7];
            [animation setTimingFunction:[CAMediaTimingFunction functionWithName:@"default"]];
            animation.type = @"pageCurl";
            animation.fillMode = kCAFillModeForwards;
            animation.endProgress = 0.97;
            [animation setRemovedOnCompletion:NO];
            [self.view.layer addAnimation:animation forKey:@"pageCurlAnimation"];
            [self.view addSubview:_settings_view];
            
        }];
        isCurlStarted = YES;
    }else{
        [self closePaintSettings:nil];
    }
    
}

- (IBAction)closePaintSettings:(id)sender {
    [UIView animateWithDuration:1.0
                     animations:^{
                         CATransition *animation = [CATransition animation];
                         [animation setDelegate:self];
                         [animation setDuration:0.7];
                         [animation setTimingFunction:[CAMediaTimingFunction functionWithName:@"default"]];
                         animation.type = @"pageUnCurl";
                         animation.fillMode = kCAFillModeForwards;
                         animation.startProgress = 0.15;
                         [animation setRemovedOnCompletion:NO];
                         [self.view.layer addAnimation:animation forKey:@"pageUnCurlAnimation"];
                         [_settings_view removeFromSuperview];
                     }];
    isCurlStarted = NO;
}

@end
