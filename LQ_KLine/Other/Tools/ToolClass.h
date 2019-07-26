//
//  ToolClass.h
//  BFGP
//
//  Created by lq on 2017/9/25.
//  Copyright © 2017年 bfgp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ToolClass : NSObject

+ (CGRect)rectOfNSString:(NSString *)string attribute:(NSDictionary *)attribute;
/**
 得到当前的时间  10:10:10
 
 @return 时间字符串
 */
+ (NSString *)GetNowTime;

/**
 根据给定的日期格式，把日期转换成字符串
 
 @param date 日期
 @param dateFormat 日期格式
 @return 字符串
 */
+ (NSString *)stringFromNSDate:(NSDate *)date dateFormat:(NSString *)dateFormat;

/**
 根据给定的时间戳和想要的时间格式 返回时间字符串
 
 @param timestamp 时间戳
 @param dateFormat 格式
 @return 时间字符串
 */
+ (NSString *)stringWithTimestamp:(NSString *)timestamp dateFormat:(NSString *)dateFormat;


/**
 日期转换成时间戳
 
 @param dateStr 日期
 @param dateFormat 日期格式
 @return 时间戳字符串
 */
+ (NSString *)TimeStrFromDateStr:(NSString *)dateStr dateFormat:(NSString *)dateFormat;

/**
 根据传入的日期字符串 和要返回的格式 转换成特定的日期字符串

 @param dateStr 日期字符串
 @param originalDateFormat 原始的日期格式
 @param dateFormat 想要的日期格式
 @return 要返回的字符串
 */
+ (NSString *)stringFromNSDateStr:(NSString *)dateStr originalDateFormat:(NSString *)originalDateFormat resultDateFormat:(NSString *)dateFormat;


/**
  根据传入的日期字符串 和格式 获取星期几

 @param dateStr 日期字符串
 @param dateFormat 日期格式
 @return 星期 
 */

+ (NSString *)weekStrWithDateStr:(NSString *)dateStr dateFormat:(NSString *)dateFormat;



/**
 计算控件的size

 @param obj 控件
 @param width 宽度
 @return size 
 */
+ (CGSize)sizeWithObj:(id)obj width:(CGFloat)width;
/**
 根据传入的内容、字号、宽度等计算高度
 
 @param maxWidth 最大宽度
 @param text 内容
 @param lineSpaceing 行间距
 @return 返回高度
 */
+ (CGFloat)heightWithWidth:(CGFloat)maxWidth text:(NSString *)text font:(UIFont *)font lineSpaceing:(CGFloat)lineSpaceing;



/**
 计算宽度
 
 @param maxHeight 高度
 @param text 内容

 @return 返回宽度
 */
+ (CGFloat)widthWithHeight:(CGFloat)maxHeight text:(NSString *)text withFont:(UIFont *)font;
/**
 电话校验

 @param mobileNumbel 电话
 @return 结果
 */
+ (BOOL)checkTel:(NSString *)mobileNumbel;

/**
 *  1, 按图片最大边成比例缩放图片
 *
 *  @param image   图片
 *  @param maxSize 图片的较长那一边目标缩到的(宽度／高度)
 *
 *  @return        等比缩放后的图片
 */
+ (UIImage *)scaleImage:(UIImage *)image maxSize:(CGFloat)maxSize;

#pragma mark -- 处理后台给的万

/**
 后台返回的钱

 @param money 钱
 @return 返回值
 */
+ (NSString *)disposeMoneyNumber:(NSString *)money;


+ (BOOL)validateMoney:(NSString *)money;


+ (BOOL)verMoney:(NSString *)money;

/**
 万元转换

 @param mingyi 金额
 @return 返回值
 */
+ (NSString *)disMingyiMoney:(NSString *)mingyi;








/**
 截屏

 @param view 目标view
 @param rect 位置
 @return 图片
 */
+ (UIImage *)captureImageWithView:(UIView *)view rect:(CGRect)rect;



/**
 json转字典

 @param jsonString 字符串
 @return 字典
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;



/**
 字典转json

 @param dict 字典
 @return json
 */
+(NSString *)convertToJsonData:(NSDictionary *)dict;


/**
 根据字符串生成二维码

 @param string 字符串
 @return 二维码图片
 */
+(UIImage *)createQRImageWtih:(NSString *)string;


/**
 哈希256加密

 @param string 要加密的字符串
 @return 结果
 */
+ (NSString *)sha256EncryptWith:(NSString *)string;


/**
 base64解码图片

 @param base64Str base64Str
 @return 图片
 */
+ (UIImage *)imageWithBase64Str:(NSString *)base64Str;



/**
 验证邮箱

 @param email 邮箱
 @return 结果 
 */
+ (BOOL)validateEmail:(NSString *)email;


/**
 验证密码

 @param password 密码
 @return 结果
 */
+ (BOOL)validatePassword:(NSString *)password;
@end
