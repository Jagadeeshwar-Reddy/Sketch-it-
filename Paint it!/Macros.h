//
//  Macros.h
//  Paint it!
//
//  Created by Giriprasad Reddy on 21/04/13.
//  Copyright (c) 2013 Let's Build. All rights reserved.
//

#ifndef Paint_it__Macros_h
#define Paint_it__Macros_h


#define kDefaultBrushWidth 4.0f
#define kDefaultEraserWidth 10.0f
#define kDefaultBrushColor [UIColor orangeColor]
#define kDefaultBackgroundColor [UIColor whiteColor]








#define isRetina() \
([[UIScreen mainScreen] respondsToSelector:@selector(scale)] && [[UIScreen mainScreen] scale] == 2)

#define DISPLAY_SCALE_FACTOR ([[UIScreen mainScreen] scale] >= 1.5 ? 2 :1)

#define KDocumentsDirectory [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES) objectAtIndex:0]


/*
 Debug logging Helpers
 */
#ifdef DEBUG
#define MJRDbugLog(...) NSLog(@"%@", [NSString stringWithFormat:__VA_ARGS__])
#else
#define MJRDbugLog(...) do { } while (0)
#endif
#define ALog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);


//UIColor utilites
#define RGB(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
//RGB color macro
#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//RGB color macro with alpha
#define UIColorFromRGBWithAlpha(rgbValue,a) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]

#endif
