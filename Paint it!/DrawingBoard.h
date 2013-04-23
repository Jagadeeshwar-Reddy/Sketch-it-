//
//  DrawingBoard.h
//  Paint it!
//
//  Created by Giriprasad Reddy on 21/04/13.
//  Copyright (c) 2013 Let's Build. All rights reserved.
//


#import <UIKit/UIKit.h>

typedef enum DrawingTools {
    kToolEraser     = 1,
    kToolPen        = 2,
    kToolHighliter  = 3,
    kToolClearAll   = 4,
    kToolUndo       = 5,
    kToolRedo       = 6
} DrawingTools;

@protocol DrawingBoardDelegate <NSObject>

@optional


@end

@interface DrawingBoard : UIView{
    
}

/*!
 @property lineColor
 @abstract Color for stroke line.
 */
@property (nonatomic, setter = setLineColor:) CGColorRef lineColor;
/*!
 @property lineWidth
 @abstract route segment line width.
 */
@property (nonatomic) CGFloat lineWidth;

/*!
 @property backgroundImage
 @abstract background image is a content under the paint layer. It could be anything. If you provide no background image the background color is clear color.
 */
@property (nonatomic, retain) UIImage *backgroundImage;

@property (nonatomic, assign) DrawingTools renderPathMode;

- (void)setBoardImage:(UIImage *)img;
- (UIImage *)imageFromBoardCurrentState;

@end
