//
//  MJRViewController.m
//  Paint it!
//
//  Created by Jagadeeshwar Reddy on 27/03/13.
//  Copyright (c) 2013 Let's Build. All rights reserved.
//

#import "MJRPaintBoardVC.h"
#import "DrawingBoard.h"


#define UIViewAutoresizingFlexibleAll (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight |    UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin)

typedef enum ColorPicker {
    ColorPickerForBrush = 0 ,
    ColorPickerForBackground
}ColorPickerMode;

@interface MJRPaintBoardVC (){
    BOOL isCurlStarted;
    ColorPickerMode clrpkr_mode;
        
    CGFloat curr_brush_width;
}

@property (nonatomic, strong) UIColor *curr_bg_color;
@property (nonatomic, strong) UIColor *curr_brush_color;

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

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemOrganize target:self action:@selector(saveCurrentImage:)];
    
    [self configureAwesomeMenuButton];
    
    _selected_bg_color_indicator.backgroundColor=kDefaultBackgroundColor;
    [self setupShadow:_selected_bg_color_indicator.layer];
    
    _selected_brush_color_indicator.backgroundColor=kDefaultBrushColor;
    [self setupShadow:_selected_brush_color_indicator.layer];
    
    curr_brush_width=kDefaultBrushWidth;
    
    [(DrawingBoard *)self.view setBackgroundColor:[UIColor whiteColor]];
    [(DrawingBoard *)self.view setLineColor:kDefaultBrushColor.CGColor];
    [(DrawingBoard *)self.view setLineWidth:curr_brush_width];
    [(DrawingBoard *)self.view setRenderPathMode:kToolPen];
}

#pragma mark - Helpers
-(void)configureAwesomeMenuButton{
    
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
    
    menu.startPoint = CGPointMake(30.0, 445.0);
	
    menu.delegate = self;
    
    [self.view addSubview:menu];
    
    [menu setAutoresizingMask:UIViewAutoresizingFlexibleTopMargin];
    
}
- (void) setupShadow:(CALayer *)layer {
    layer.cornerRadius = 6.0;
    layer.shadowColor = [UIColor blackColor].CGColor;
    layer.shadowOpacity = 0.8;
    layer.shadowOffset = CGSizeMake(0, 2);
    CGRect rect = layer.frame;
    rect.origin = CGPointZero;
    layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:layer.cornerRadius].CGPath;
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

-(void)saveCurrentImage:(id)sender{
    UIImage *current_image = [(DrawingBoard *)self.view imageFromBoardCurrentState];
    
    if (!current_image) return;
    
    
    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.labelText = @"Saving...";
    
    [hud showAnimated:YES whileExecutingBlock:^{
        float progress = 0.0f;
        
        [[AppDatabase instance] addImageToDatabase:[(DrawingBoard *)self.view imageFromBoardCurrentState]imageName:@"my..img" comment:@"Hello this is my first paint!, have a look at it........."];
        
        while (progress < 1.0f)
        {
            progress += 0.01f;
            hud.progress = progress;
            usleep(20000);
            
            if (progress>=0.98) {
                //hud.mode = MBProgressHUDModeCustomView;
                
                //hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
                //hud.labelText = @"Saved!";
                
                //[hud hide:YES afterDelay:2];
            }
        }

    } completionBlock:^{

    }];
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
    
    switch (idx) {
        case 0:
            [(DrawingBoard *)self.view setRenderPathMode:kToolPen];
            MJRDbugLog(@"Selected tool : pen");
            break;
        case 1:
            [(DrawingBoard *)self.view setRenderPathMode:kToolEraser];
            MJRDbugLog(@"Selected tool : Eraser");
            break;
        case 2:
            [(DrawingBoard *)self.view setBoardImage:nil];
            MJRDbugLog(@"Selected tool : Clear board");
            break;
        default:
            MJRDbugLog(@"Select the index : %d",idx);
            break;
    }
}
- (void)AwesomeMenuDidFinishAnimationClose:(AwesomeMenu *)menu {
    NSLog(@"Menu was closed!");
}
- (void)AwesomeMenuDidFinishAnimationOpen:(AwesomeMenu *)menu {
    NSLog(@"Menu is open!");
}


#pragma mark IBAction methods

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


#pragma mark -
#pragma mark Paint settings view

- (IBAction)pickColor:(id)sender {
    clrpkr_mode=([sender tag]==1 ? ColorPickerForBrush : ColorPickerForBackground);
    NEOColorPickerViewController *controller = [[NEOColorPickerViewController alloc] init];
    controller.delegate = self;
    controller.selectedColor = ([sender tag]==1 ? self.curr_brush_color : self.curr_bg_color);
    controller.title = @"Pick your choice";
	UINavigationController* navVC = [[UINavigationController alloc] initWithRootViewController:controller];
    
    [self presentViewController:navVC animated:YES completion:nil];
}

- (IBAction)brushWidthChanged:(UISlider *)sender {
    curr_brush_width=sender.value;
    _configured_slider_value.text=[NSString stringWithFormat:@"%.1f",curr_brush_width];
    [(DrawingBoard *)self.view setLineWidth:curr_brush_width];
}
#pragma mark ColorPickerDelegate
- (void) colorPickerViewController:(NEOColorPickerBaseViewController *)controller didSelectColor:(UIColor *)color {
    // Configure to selected color.
    if (clrpkr_mode==ColorPickerForBackground) {
        self.curr_bg_color = color;
        _selected_bg_color_indicator.backgroundColor = color;
        self.view.backgroundColor = color;
    }
    else if (clrpkr_mode == ColorPickerForBrush){
        self.curr_brush_color = color;
        _selected_brush_color_indicator.backgroundColor = color;
        
        [(DrawingBoard *)self.view setLineColor:color.CGColor];

    }
    
    [controller dismissViewControllerAnimated:YES completion:nil];
}
- (void) colorPickerViewControllerDidCancel:(NEOColorPickerBaseViewController *)controller{
    [controller dismissViewControllerAnimated:YES completion:nil];
}
@end
