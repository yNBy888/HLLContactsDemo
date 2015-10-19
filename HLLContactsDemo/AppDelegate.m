//
//  AppDelegate.m
//  HLLContactsDemo
//
//  Created by apple on 15/10/19.
//  Copyright © 2015年 HLL. All rights reserved.
//

#import "AppDelegate.h"


@implementation UIColor (Common)

+ (UIColor *)colorWithHexString:(NSString *)stringToConvert {
    NSScanner *scanner = [NSScanner scannerWithString:stringToConvert];
    unsigned hexNum;
    if (![scanner scanHexInt:&hexNum]) return nil;
    return [UIColor colorWithRGBHex:hexNum];
}


+ (UIColor *)colorWithRGBHex:(UInt32)hex {
    int r = (hex >> 16) & 0xFF;
    int g = (hex >> 8) & 0xFF;
    int b = (hex) & 0xFF;
    
    return [UIColor colorWithRed:r / 255.0f
                           green:g / 255.0f
                            blue:b / 255.0f
                           alpha:1.0f];
}
@end


@implementation UIImage (Commom)

+(UIImage *)imageWithColor:(UIColor *)aColor{
    return [UIImage imageWithColor:aColor withFrame:CGRectMake(0, 0, 1, 1)];
}

+(UIImage *)imageWithColor:(UIColor *)aColor withFrame:(CGRect)aFrame{
    UIGraphicsBeginImageContext(aFrame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [aColor CGColor]);
    CGContextFillRect(context, aFrame);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}
@end
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self configureNavigatioinBar];
    return YES;
}
- (void) configureNavigatioinBar{

    UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
    [navigationBarAppearance setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString: @"0x006633"]] forBarMetrics:UIBarMetricsDefault];
    
    [navigationBarAppearance setTintColor:[UIColor whiteColor]];//返回按钮的箭头颜色
    NSDictionary *textAttributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:18],
                                     NSForegroundColorAttributeName: [UIColor whiteColor]};
    [navigationBarAppearance setTitleTextAttributes:textAttributes];
}
@end
