//
//  DrawingBoard.m
//  Paint it!
//
//  Created by Giriprasad Reddy on 21/04/13.
//  Copyright (c) 2013 Let's Build. All rights reserved.
//

#import "DrawingBoard.h"
#import "UIImage+Resize.h"
#import "UIImage+ProportionalFill.h"

@interface DrawingBoard()
{
    
    CGMutablePathRef mPath;
    
    CGPoint pts[5]; // we now need to keep track of the four points of a Bezier segment and the first control point of the next segment
    uint ctr;
}
@property(nonatomic, retain) UIImage *current_image;
@property(nonatomic, strong) UIBezierPath *path;

-(void)initialSetup;

@end

@implementation DrawingBoard
@synthesize current_image;



- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        [self initialSetup];
    }
    return self;
    
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialSetup];
    }
    return self;
}

-(void)initialSetup{
    [self setMultipleTouchEnabled:NO];
    _path = [UIBezierPath bezierPath];
    [_path setLineWidth:kDefaultBrushWidth];
    mPath = CGPathCreateMutable();
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    if (_backgroundImage) {
        _backgroundImage = [_backgroundImage resizedImageToFitInSize:rect.size scaleIfSmaller:YES];
        [_backgroundImage drawAtPoint:rect.origin];
    }
    self.current_image = [self.current_image resizedImageToFitInSize:rect.size scaleIfSmaller:YES];
    [self.current_image drawAtPoint:rect.origin];
    
    [[UIColor colorWithCGColor:_lineColor] setStroke];
    [_path stroke];
    
    [super drawRect:rect];
}

-(void)setBackgroundImage:(UIImage *)backgroundImage{
    _backgroundImage=backgroundImage;
    [self setNeedsDisplay];
}
- (void)setBoardImage:(UIImage *)img{
    self.current_image=img;
    [self setNeedsDisplay];
}
-(UIImage*)imageFromBoardCurrentState{
    return self.current_image;
}

#pragma mark -
#pragma mark UITouch delegete
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSArray *t = [[event allTouches] allObjects];
	if ([t count] > 0) {
        CGPoint cur_point;
        cur_point.x = [[t objectAtIndex:0] locationInView:self].x;
        cur_point.y = [[t objectAtIndex:0] locationInView:self].y;
        if(_renderPathMode == kToolEraser){
            [self clipImage:cur_point];
        }
        else{
            CGPathMoveToPoint(mPath, nil, cur_point.x, cur_point.y);
        }
        pts[0] = cur_point;
	}
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    NSArray *t = [[event allTouches] allObjects];
	if ([t count] > 0) {
		CGPoint cur_point;
		cur_point.x = [[t objectAtIndex:0] locationInView:self].x;
		cur_point.y = [[t objectAtIndex:0] locationInView:self].y;
		if(_renderPathMode == kToolEraser){
            [self clipImage:cur_point];
            return;
        }
        ctr++;
        pts[ctr] = cur_point;
        if (ctr == 4)
        {
            pts[3] = CGPointMake((pts[2].x + pts[4].x)/2.0, (pts[2].y + pts[4].y)/2.0); // move the endpoint to the middle of the line joining the second control point of the first Bezier segment and the first control point of the second Bezier segment
            
            [self updateDrawingBoard:cur_point];
            
            pts[0] = pts[3];
            pts[1] = pts[4];
            ctr = 1;
        }
        
	}
}
- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	[self touchesMoved:touches withEvent:event];
    ctr = 0;
}
-(void)updateDrawingBoard:(CGPoint)currentPoint
{
    UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, 0.0);
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    [self.current_image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    CGContextSetLineCap(currentContext, kCGLineCapRound);
    CGContextSetLineWidth(currentContext, _lineWidth);
    
    CGColorRef color = _lineColor;
    CGFloat red = 0;
    CGFloat green = 0;
    CGFloat blue = 0;
    CGFloat alpha = 1.0;
    if (color != nil)
    {
        const CGFloat *components = CGColorGetComponents(color);
        red = components[0];
        green = components[1];
        blue = components[2];
        alpha = components[3];
        //        CGFloat alpha = components[3];
    }
    
    CGContextSetStrokeColorWithColor(currentContext, _lineColor);
    //CGContextSetRGBStrokeColor(currentContext, red, green, green, alpha);
    CGContextBeginPath(currentContext);
    CGContextMoveToPoint(currentContext, pts[0].x, pts[0].y);
    
    CGContextAddCurveToPoint(currentContext, pts[1].x, pts[1].y, pts[2].x, pts[2].y, pts[3].x, pts[3].y);
    CGContextStrokePath(currentContext);
    
    self.current_image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    [self setNeedsDisplay];
}

- (void)clipImage:(CGPoint)currentPoint {
    
    UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [[self current_image] drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, kDefaultEraserWidth);
    CGContextSetBlendMode(context, kCGBlendModeClear);
    CGContextSetStrokeColorWithColor(context, [[UIColor clearColor] CGColor]);
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, pts[0].x, pts[0].y);
    //CGContextAddLineToPoint(context, currentPoint.x, currentPoint.y);
    CGContextAddEllipseInRect(context, CGRectMake(currentPoint.x, currentPoint.y, 20, 20));
    CGContextStrokePath(context);
    CGContextFlush(context);
    self.current_image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    [self setNeedsDisplay];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self touchesEnded:touches withEvent:event];
}

- (void)drawBitmap
{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, YES, DISPLAY_SCALE_FACTOR);
    
    // first time; paint background white
    if (!self.current_image)
    {
        UIBezierPath *rectpath = [UIBezierPath bezierPathWithRect:self.bounds];
        [[UIColor whiteColor] setFill];
        [rectpath fill];
    }

    [self.current_image drawAtPoint:CGPointZero];
    
    [[UIColor colorWithCGColor:_lineColor] setStroke];
    [_path stroke];
    
    self.current_image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
}

@end


