//
//  BaseConfig.h
//  LQ_KLine
//
//  Created by lq on 2019/6/16.
//  Copyright © 2019年 2SE. All rights reserved.
//

#ifndef BaseConfig_h
#define BaseConfig_h


#define UIColorWithHex(_hex_)   [UIColor colorWithHexString:((__bridge NSString *)CFSTR(#_hex_))]

#define SEColorAlpha(r, g, b, a)  [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

// 红色
#define SERedColor [UIColor colorWithRed:242/255.0 green:68/255.0 blue:89/255.0 alpha:1.0]

// 绿色
#define SEGreenColor  [UIColor colorWithRed:89/255.0 green:199/255.0 blue:110/255.0 alpha:1.0]
#define SEColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define SEColorAlpha(r, g, b, a)  [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define PriceFontWithSize(fontSize)  [UIFont fontWithName:@"PingFangSC-Semibold" size:(fontSize)]

#define SEGrayColor(v,a)  SEColorAlpha((v),(v),(v),(a))
#define SelectedColor  UIColorHex(#3483EB)
#define CyanBackgroundColor UIColorHex(#F0F6FF)
#define WhiteBackGroundColor UIColorHex(#FFFFFF)


#define GaryTextColor  UIColorHex(#999999)
#define LineColor   UIColorHex(#EBEBEB)
#define LightLineColor  UIColorHex(#E0E0E0)
#define BlackTextColor   UIColorHex(#333333)
#define GaryBackGroundColor  UIColorHex(#F5F5F5)

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define TextFontWithSize(fontSize)  [UIFont fontWithName:@"PingFangSC-Regular" size:(fontSize)]



/** 导航栏 + 状态栏 高度 */
#define NavigationBarHeight (SCREEN_HEIGHT == 812.0 ? 88 : 64)

#endif /* BaseConfig_h */
