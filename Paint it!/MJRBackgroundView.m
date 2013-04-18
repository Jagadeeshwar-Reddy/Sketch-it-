//
//  MJRBackgroundView.m
//  Paint it!
//
//  Created by Giriprasad Reddy on 17/04/13.
//  Copyright (c) 2013 Let's Build. All rights reserved.
//

#import "MJRBackgroundView.h"

@implementation MJRBackgroundView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/



/*- (void)drawRect:(CGRect)rect
{
    CGPoint c = self.center ;
    // Drawing code
    CGContextRef cx = UIGraphicsGetCurrentContext();
    
    CGContextSaveGState(cx);
    CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
    
    CGFloat comps[] = {1.0,1.0,0.0,1.0,0.0,1.0,0.0,1.0};
    CGFloat locs[] = {0,1};
    CGGradientRef g = CGGradientCreateWithColorComponents(space, comps, locs, 2);
    
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, c.x, c.y);
    CGPathAddLineToPoint(path, NULL, c.x, c.y-100);
    CGPathAddArcToPoint(path, NULL, c.x+100, c.y-100, c.x+100, c.y, 100);
    CGPathAddLineToPoint(path, NULL, c.x, c.y);
    
    CGContextAddPath(cx, path);
    CGContextClip(cx);
    
    CGContextDrawRadialGradient(cx, g, c, 1.0f, c, 320.0f, 0);
    
    CGContextRestoreGState(cx);
 
}*/
- (void)drawRect:(CGRect)rect
{
    //blue   0.7, 0.85, 0.93, 1.0
    //67,130,167
    CGFloat colors [] = {
        1.0, 1.0, 1.0, 1.0,
        0.26, 0.50, 0.643, 1.0 //30,144,25 //0.11, 0.56, 0.098, 1.0
    };
    CGColorSpaceRef baseSpace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColorComponents(baseSpace, colors, NULL, 2);
    CGColorSpaceRelease(baseSpace), baseSpace = NULL;
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGContextAddRect(context, rect);
    CGContextClip(context);
    CGContextDrawRadialGradient(context, gradient, self.center, 0.0f, self.center, self.frame.size.width, kCGGradientDrawsBeforeStartLocation);
    CGGradientRelease(gradient), gradient = NULL;
    CGContextRestoreGState(context);
}


@end
