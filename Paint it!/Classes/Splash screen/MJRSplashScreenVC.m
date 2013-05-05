//
//  MJRSplashScreenVC.m
//  Paint it!
//
//  Created by Giriprasad Reddy on 27/03/13.
//  Copyright (c) 2013 Let's Build. All rights reserved.
//

#import "MJRSplashScreenVC.h"
#import "MJRPaintBoardVC.h"
#import "MJRMainMenuVC.h"

@interface MJRSplashScreenVC ()

@end

@implementation MJRSplashScreenVC

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
    /*CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.view.bounds;
    UIColor *startColour = [UIColor colorWithHue:.580555 saturation:0.31 brightness:0.90 alpha:1.0];
    UIColor *endColour = [UIColor colorWithHue:.58333 saturation:0.50 brightness:0.62 alpha:1.0];
    gradient.colors = [NSArray arrayWithObjects:(id)[startColour CGColor], (id)[endColour CGColor], nil];
    [self.view.layer insertSublayer:gradient atIndex:0];*/
    
    // Do any additional setup after loading the view from its nib.
    /*double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        MJRPaintBoardVC *paint_board=[[MJRPaintBoardVC alloc] initWithNibName:@"MJRPaintBoardVC" bundle:[NSBundle mainBundle]];
        UINavigationController *nvgc=[[UINavigationController alloc] initWithRootViewController:paint_board];
        
        [self presentViewController:nvgc animated:YES completion:^{
            
        }];
    });*/
    
    
    _main_title.alpha=0.0;
    _author_label.alpha=0.0;
    _copyright_label.alpha=0.0;
    
    
    //demonstrate shadow
    _main_title.shadowColor = [UIColor colorWithHue:.580555 saturation:0.31 brightness:0.90 alpha:1.0];
    _main_title.shadowOffset = CGSizeMake(1.0f, 1.0f);
    _main_title.shadowBlur = 1.0f;
    _main_title.gradientStartColor = [UIColor colorWithHue:.580555 saturation:0.31 brightness:0.90 alpha:1.0];
    _main_title.gradientEndColor = [UIColor colorWithWhite:1.0 alpha:1.0];
    _main_title.innerShadowBlur = 2.0f;
    _main_title.innerShadowColor = [UIColor colorWithHue:.58333 saturation:0.50 brightness:0.62 alpha:1.0];
    _main_title.innerShadowOffset = CGSizeMake(1.0f, 1.0f);

    
    /*_author_label.shadowColor = [UIColor colorWithHue:.580555 saturation:0.31 brightness:0.90 alpha:1.0];
    _author_label.shadowOffset = CGSizeMake(1.0f, 1.0f);
    _author_label.shadowBlur = 1.0f;
    _author_label.innerShadowBlur = 2.0f;
    _author_label.innerShadowColor = [UIColor colorWithHue:.58333 saturation:0.50 brightness:0.62 alpha:1.0];
    _author_label.innerShadowOffset = CGSizeMake(1.0f, 1.0f);
    
    
    _copyright_label.shadowColor = [UIColor colorWithHue:.580555 saturation:0.31 brightness:0.90 alpha:1.0];
    _copyright_label.shadowOffset = CGSizeMake(1.0f, 1.0f);
    _copyright_label.shadowBlur = 1.0f;    
    _copyright_label.innerShadowBlur = 2.0f;
    _copyright_label.innerShadowColor = [UIColor colorWithHue:.58333 saturation:0.50 brightness:0.62 alpha:1.0];
    _copyright_label.innerShadowOffset = CGSizeMake(1.0f, 1.0f);
*/
    /*
    //demonstrate inner shadow
    label2.shadowColor = [UIColor colorWithWhite:1.0f alpha:0.8f];
    label2.shadowOffset = CGSizeMake(1.0f, 1.0f);
    label2.shadowBlur = 1.0f;
    label2.innerShadowBlur = 2.0f;
    label2.innerShadowColor = [UIColor colorWithWhite:0.0f alpha:0.8f];
    label2.innerShadowOffset = CGSizeMake(1.0f, 1.0f);
    
    //demonstrate gradient fill
    label3.gradientStartColor = [UIColor redColor];
    label3.gradientEndColor = [UIColor blackColor];
    
    //demonstrate multi-part gradient
    label4.gradientStartPoint = CGPointMake(0.0f, 0.0f);
    label4.gradientEndPoint = CGPointMake(1.0f, 1.0f);
    label4.gradientColors = @[[UIColor redColor],
                              [UIColor yellowColor],
                              [UIColor greenColor],
                              [UIColor cyanColor],
                              [UIColor blueColor],
                              [UIColor purpleColor],
                              [UIColor redColor]];
    
    //everything
    label5.shadowColor = [UIColor blackColor];
    label5.shadowOffset = CGSizeZero;
    label5.shadowBlur = 20.0f;
    label5.innerShadowBlur = 2.0f;
    label5.innerShadowColor = [UIColor yellowColor];
    label5.innerShadowOffset = CGSizeMake(1.0f, 1.0f);
    label5.gradientStartColor = [UIColor redColor];
    label5.gradientEndColor = [UIColor yellowColor];
    label5.gradientStartPoint = CGPointMake(0.0f, 0.5f);
    label5.gradientEndPoint = CGPointMake(1.0f, 0.5f);
    label5.oversampling = 2;
     */
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [UIView animateWithDuration:1.0 animations:^{
        _main_title.alpha=1.0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1.0 animations:^{
            _author_label.alpha=1.0;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:1.0 animations:^{
                _copyright_label.alpha=1.0;
            } completion:^(BOOL finished) {
                [self performSelector:@selector(movetohomescreen) withObject:nil afterDelay:2.0];
            }];
        }];
    }];
}

-(void)movetohomescreen{
    // Step 1: Create your controllers.
    MJRPaintBoardVC *paint_board=[[MJRPaintBoardVC alloc] initWithNibName:@"MJRPaintBoardVC" bundle:[NSBundle mainBundle]];
    UINavigationController *frontViewController = [[UINavigationController alloc] initWithRootViewController:paint_board];
    MJRMainMenuVC *leftViewController = [[MJRMainMenuVC alloc] initWithNibName:@"MJRMainMenuVC" bundle:[NSBundle mainBundle]];
    leftViewController.paintboard_navigController=frontViewController;
    // Step 2: Configure an options dictionary for the PKRevealController if necessary - in most cases the default behaviour should suffice. See PKRevealController.h for more option keys.
    
     NSDictionary *options = @{
     //PKRevealControllerAllowsOverdrawKey : [NSNumber numberWithBool:YES],
     //PKRevealControllerDisablesFrontViewInteractionKey : [NSNumber numberWithBool:YES],
     PKRevealControllerRecognizesPanningOnFrontViewKey : [NSNumber numberWithBool:NO]
     };

    MJRAppDelegate *app_delegate = (MJRAppDelegate *)[UIApplication sharedApplication].delegate;

    // Step 3: Instantiate your PKRevealController.
    app_delegate.revealController = [PKRevealController revealControllerWithFrontViewController:frontViewController
                                                                     leftViewController:leftViewController
                                                                    rightViewController:nil
                                                                                options:options];
    
    // Step 4: Set it as your root view controller.
    app_delegate.window.rootViewController = app_delegate.revealController;
}


- (UIImage *)radialGradientImage:(CGSize)size start:(float)start end:(float)end centre:(CGPoint)centre radius:(float)radius {
    // Render a radial background
    // http://developer.apple.com/library/ios/#documentation/GraphicsImaging/Conceptual/drawingwithquartz2d/dq_shadings/dq_shadings.html
    
    // Initialise
    UIGraphicsBeginImageContextWithOptions(size, YES, 1);
    
    // Create the gradient's colours
    size_t num_locations = 2;
    CGFloat locations[2] = { 0.0, 1.0 };
    CGFloat components[8] = { start,start,start, 1.0,  // Start color
        end,end,end, 1.0 }; // End color
    
    CGColorSpaceRef myColorspace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef myGradient = CGGradientCreateWithColorComponents (myColorspace, components, locations, num_locations);
    
    // Normalise the 0-1 ranged inputs to the width of the image
    CGPoint myCentrePoint = CGPointMake(centre.x * size.width, centre.y * size.height);
    float myRadius = MIN(size.width, size.height) * radius;
    
    // Draw it!
    CGContextDrawRadialGradient (UIGraphicsGetCurrentContext(), myGradient, myCentrePoint,
                                 0, myCentrePoint, myRadius,
                                 kCGGradientDrawsAfterEndLocation);
    
    // Grab it as an autoreleased image
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    // Clean up
    CGColorSpaceRelease(myColorspace); // Necessary?
    CGGradientRelease(myGradient); // Necessary?
    UIGraphicsEndImageContext(); // Clean up
    return image;
}

/*- (UIImage *)vignetteImageOfSize:(CGSize)size withImage:(UIImage *)image {
    UIGraphicsBeginImageContextWithOptions(size, YES, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextFillRect(context, CGRectMake(0.0, 0.0, size.width, size.height));
    
    CIImage *coreImage = [CIImage imageWithCGImage:image.CGImage];
    CGPoint origin = [coreImage extent].origin;
    CGAffineTransform translation =
    CGAffineTransformMakeTranslation(-origin.x, -origin.y);
    coreImage = [coreImage imageByApplyingTransform:translation];
    
    CIFilter *vignette = [CIFilter filterWithName:@"CIVignette"];
    [vignette setValue:@1.5 forKey:@"inputRadius"];
    [vignette setValue:@1.5 forKey:@"inputIntensity"];
    [vignette setValue:coreImage forKey:@"inputImage"];
    
    UIImage *vignetteImage = [UIImage imageWithCIImage:vignette.outputImage];
    
    CGRect imageFrame = CGRectMake(0.0, 0.0, size.width, size.height);
    [image drawInRect:imageFrame];
    UIImage *renderedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return renderedImage;
}*/




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
