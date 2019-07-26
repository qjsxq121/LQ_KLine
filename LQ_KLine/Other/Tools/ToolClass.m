//
//  ToolClass.m
//  BFGP
//
//  Created by lq on 2017/9/25.
//  Copyright © 2017年 bfgp. All rights reserved.
//

#import "ToolClass.h"
#import "LQDateFormatter.h"
#import <CommonCrypto/CommonDigest.h>

@implementation ToolClass

/**
 工具类:根据字符串和富文本属性来生成rect
 
 @param string 字符串
 @param attribute 富文本属性
 @return 返回生成的rect
 */
+ (CGRect)rectOfNSString:(NSString *)string attribute:(NSDictionary *)attribute
{
    CGRect rect = [string boundingRectWithSize:CGSizeMake(MAXFLOAT, 0)
                                       options:NSStringDrawingTruncatesLastVisibleLine |NSStringDrawingUsesLineFragmentOrigin |
                   NSStringDrawingUsesFontLeading
                                    attributes:attribute
                                       context:nil];
    return rect;
}



#pragma mark -- 得到当前的时间
/**
 得到当前的时间  10:10:10

 @return 时间字符串
 */
+ (NSString *)GetNowTime {
   return [ToolClass stringFromNSDate:[NSDate date] dateFormat:@"HH:mm:ss"];
}
#pragma mark -- 日期转换成时间戳
+ (NSString *)TimeStrFromDateStr:(NSString *)dateStr dateFormat:(NSString *)dateFormat {
    [[LQDateFormatter shareDateFormatter]  setDateFormat:dateFormat];
    NSDate *date =  [[LQDateFormatter shareDateFormatter] dateFromString:dateStr];
    NSTimeInterval a = [date timeIntervalSince1970]*1000; // *1000 是精确到毫秒，不乘就是精确到秒
    return [NSString stringWithFormat:@"%.0f", a]; //转为字符型
}
/**
 根据给定的日期格式，把日期转换成字符串

 @param date 日期
 @param dateFormat 日期格式
 @return 字符串
 */
+ (NSString *)stringFromNSDate:(NSDate *)date dateFormat:(NSString *)dateFormat
{
    [[LQDateFormatter shareDateFormatter] setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    [[LQDateFormatter shareDateFormatter]  setDateFormat:dateFormat];
    [[LQDateFormatter shareDateFormatter] setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT+0800"]];
    return [[LQDateFormatter shareDateFormatter] stringFromDate:date];
}

#pragma mark -- 根据给定的时间戳和想要的时间格式 返回时间字符串
+ (NSString *)stringWithTimestamp:(NSString *)timestamp dateFormat:(NSString *)dateFormat {
   
    //    时间戳 -> NSDate *
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp.longLongValue];
    
    return [self stringFromNSDate:date dateFormat:dateFormat];
}

#pragma mark -- 根据传入的日期字符串 和要返回的格式 转换成特定的日期字符串
+ (NSString *)stringFromNSDateStr:(NSString *)dateStr originalDateFormat:(NSString *)originalDateFormat resultDateFormat:(NSString *)dateFormat {
   
    /*
     NSDateFormatter 作用
     1.将NSString * -> NSDate *  dateFromString
     将NSDate * -> NSString *
     */
   
    // 设置日期的格式（为了转换成功）
    [[LQDateFormatter shareDateFormatter]  setDateFormat:originalDateFormat];
     NSDate *date =  [[LQDateFormatter shareDateFormatter] dateFromString:dateStr];
    [[LQDateFormatter shareDateFormatter]  setDateFormat:dateFormat];
    return [[LQDateFormatter shareDateFormatter] stringFromDate:date];
    
}

#pragma mark --   根据传入的日期字符串 和格式 获取星期几
+ (NSString *)weekStrWithDateStr:(NSString *)dateStr dateFormat:(NSString *)dateFormat{
    
    [[LQDateFormatter shareDateFormatter]  setDateFormat:dateFormat];
    NSDate *date =  [[LQDateFormatter shareDateFormatter] dateFromString:dateStr];
    NSInteger week = [[NSCalendar currentCalendar] component:NSCalendarUnitWeekday fromDate:date];
    switch (week) {
        case 1:
              return @"星期天";
            break;
        case 2:
              return @"星期一";
            break;
        case 3:
              return @"星期二";
            break;
        case 4:
              return @"星期三";
            break;
        case 5:
              return @"星期四";
            break;
        case 6:
              return @"星期五";
            break;
        case 7:
              return @"星期六";
            break;
        default:
            return nil;
            break;
    }
}
+ (CGFloat)heightWithWidth:(CGFloat)maxWidth text:(NSString *)text font:(UIFont *)font lineSpaceing:(CGFloat)lineSpaceing {
  
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpaceing];//调整行间距
    
    CGSize textMaxSize = CGSizeMake(maxWidth, MAXFLOAT);
    
    CGSize textSize = [text boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName :font,NSParagraphStyleAttributeName:paragraphStyle} context:nil].size;
    return textSize.height;
}

+ (CGSize)sizeWithObj:(id)obj width:(CGFloat)width {
    CGSize tempSize = CGSizeMake(width, INT16_MAX);
    tempSize.height =INT16_MAX;
    CGSize objSize = [obj sizeThatFits:tempSize];
    return objSize;
}
#pragma mark -- 计算宽度
+ (CGFloat)widthWithHeight:(CGFloat)maxHeight text:(NSString *)text withFont:(UIFont *)font {
    
    CGSize textMaxSize = CGSizeMake(MAXFLOAT, maxHeight);
    CGSize textSize = [text boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : font} context:nil].size;
    return textSize.width;
}

//电话号码验证
+ (BOOL)checkTel:(NSString *)mobileNumbel

{
    /**
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189,181(增加)
     */
  //  NSString * MOBIL = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[0678])\\d{8}$";
    
//    NSString * CM = @"(^1(3[4-9]|4[7]|5[0-27-9]|7[8]|8[2-478])\\d{8}$)|(^1705\\d{7}$)";
//
//    NSString * CU = @"(^1(3[0-2]|4[5]|5[56]|7[6]|8[56])\\d{8}$)|(^1709\\d{7}$)";
//
//    NSString * CT =  @"(^1(33|53|77|8[019])\\d{8}$)|(^1700\\d{7}$)";
    
    
    
   // NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBIL];
//    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
//    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
//    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
//    if (([regextestmobile evaluateWithObject:mobileNumbel]
//         || [regextestcm evaluateWithObject:mobileNumbel]
//         || [regextestct evaluateWithObject:mobileNumbel]
//         || [regextestcu evaluateWithObject:mobileNumbel])) {
//        return YES;
//    }
//    if ([regextestmobile evaluateWithObject:mobileNumbel]) {
//        return YES;
//    }
   
    if (mobileNumbel.length == 11) {
        return YES;
    }
    return NO;
    
}


/**
 *  1, 按图片最大边成比例缩放图片
 *
 *  @param image   图片
 *  @param maxSize 图片的较长那一边目标缩到的(宽度／高度)
 *
 *  @return        等比缩放后的图片
 */
+ (UIImage *)scaleImage:(UIImage *)image maxSize:(CGFloat)maxSize {
    NSData *data = UIImageJPEGRepresentation(image, 1.0);
    if(data.length < 200 * 1024){//0.25M-0.5M(当图片小于此范围不压缩)
        return image;
    }
    CGFloat imageWidth = image.size.width;
    CGFloat imageHeight = image.size.height;
    CGFloat targetWidth = imageWidth;
    CGFloat targetHeight = imageHeight;
    CGFloat imageMaxSize = MAX(imageWidth, imageHeight);
    if (imageMaxSize > maxSize) {
        CGFloat scale = 0;
        if (imageWidth >= imageHeight) {// 宽长
            scale = maxSize / imageWidth;
            targetWidth = maxSize;
            targetHeight = imageHeight * scale;
        } else { // 高长
            scale = maxSize / imageHeight;
            targetHeight = maxSize;
            targetWidth = imageWidth * scale;
        }
        UIGraphicsBeginImageContext(CGSizeMake(targetWidth, targetHeight));
        [image drawInRect:CGRectMake(0, 0, targetWidth, targetHeight)];
        UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return scaledImage;
    }
    return image;
}

#pragma mark -- 判断输入的金钱是否有效
+ (BOOL)validateMoney:(NSString *)money
{
    //    ^\d+(\.\d{1,2})$
    //0*[1-9]\d+\.(\d?[1-9]|[1-9]{1,2}0*)
    
    // @"0*[1-9]\\d+\\.(\\d?[1-9]|[1-9]|[1-9]\\d?)";
    NSString *phoneRegex = @"(\\+|\\-)?(([0]|(0[.]\\d{0,7}))|([1-9]\\d{0,20}(([.]\\d{0,8})?)))?";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:money];
}


#pragma mark -- 验证后两位为有效数
+ (BOOL)verMoney:(NSString *)money {
    NSString *phoneRegex = @"0*[1-9]\\d+\\.(\\d?[1-9]|[1-9]|[1-9]\\d?)";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:money];
}

#pragma mark -- 老虎股票
// 处理钱
+ (NSString *)disposeMoneyNumber:(NSString *)money {
    
    if ([money floatValue] <= 10000) {
        return [NSString stringWithFormat:@"%0.2f",[money doubleValue]];
    } else {
        return [NSString stringWithFormat:@"%.2f万",[money floatValue] / 10000];
    }
}


// 处理名义本金
+ (NSString *)disMingyiMoney:(NSString *)mingyi {
    return [NSString stringWithFormat:@"%ld万",[mingyi integerValue] / 10000];
}













#pragma mark -- 截屏
+ (UIImage *)captureImageWithView:(UIView *)view rect:(CGRect)rect {
   
    // 1 截图
    UIGraphicsBeginImageContext(CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT));
    CGContextRef contenxRef = UIGraphicsGetCurrentContext();
    
    [view.layer renderInContext:contenxRef];
    
    // 全屏的图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
  //  BSLog(@"%@",NSStringFromCGRect(view.bounds));

    // 2 剪裁图片
    CGImageRef sourceImageRef = [image CGImage];
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, rect);

    
    
    // 3 实现高斯模糊
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *inputImage= [CIImage imageWithCGImage:[UIImage imageWithCGImage:newImageRef].CGImage];
    //设置filter
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [filter setValue:inputImage forKey:kCIInputImageKey];
    [filter setValue:@8.0f forKey: @"inputRadius"];
   // [filter setValue:@(0.5) forKey:@"outputRadius"];
    //模糊图片
    CIImage *result=[filter valueForKey:kCIOutputImageKey];
    CGImageRef outImage=[context createCGImage:result fromRect:[inputImage extent]];
    UIImage *blurImage=[UIImage imageWithCGImage:outImage];
    CGImageRelease(outImage);
    return blurImage;
    
  
    
    //return [UIImage imageWithCGImage:newImageRef];
    
    
    
}


#pragma mark -- json转字典
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}


// 字典转json
+(NSString *)convertToJsonData:(NSDictionary *)dict

{
    
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonString;
    
    if (!jsonData) {
        
        NSLog(@"%@",error);
        
    }else{
        
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    }
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    NSRange range = {0,jsonString.length};
    
    //去掉字符串中的空格
    
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    
    NSRange range2 = {0,mutStr.length};
    
    //去掉字符串中的换行符
    
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    
    return mutStr;
    
}



#pragma mark -- 生成二维码
+(UIImage *)createQRImageWtih:(NSString *)string {
    
    CGFloat size = 100;
    // 二维码滤镜
    CIFilter *fileter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    // 恢复滤镜的默认值
    [fileter setDefaults];
    
    // 将字符串转换成NSData
    
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    
    // 通过KVO设置滤镜inputmessage
    [fileter setValue:data forKey:@"inputMessage"];
    
    // 获得滤镜输出的图像
    CIImage *outputImage = [fileter outputImage];
    
    CGRect extent = CGRectIntegral(outputImage.extent);
    CGFloat scale = MIN(size / CGRectGetWidth(extent), size / CGRectGetHeight(extent));
    
    // 创建bitmap
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    
    CIContext *context = [CIContext contextWithOptions:nil];
    
    CGImageRef bitmapImage = [context createCGImage:outputImage fromRect:extent];
    
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 保存bitmap 到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    
    return [UIImage imageWithCGImage:scaledImage];
}


#pragma mark -- SHA256加密
+ (NSString *)sha256EncryptWith:(NSString *)string {
    const char *s = [string cStringUsingEncoding:NSASCIIStringEncoding];
    NSData *keyData = [NSData dataWithBytes:s length:strlen(s)];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH] = {0};
    CC_SHA256(keyData.bytes, (CC_LONG)keyData.length, digest);
    NSData *out = [NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    NSString *hash = [out description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
    return hash;
}


#pragma mark -- base64 解码图片
+ (UIImage *)imageWithBase64Str:(NSString *)base64Str {
    
    if (base64Str.length == 0) {
        return nil;
    }
    NSData *decodedImgData = [[NSData alloc] initWithBase64EncodedString:base64Str options:NSDataBase64DecodingIgnoreUnknownCharacters];
    
    return [UIImage imageWithData:decodedImgData];
}


// 验证邮箱
+ (BOOL)validateEmail:(NSString *)email {
    NSString *emailRegex =@"[A-Z0-9a-z0._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:email];
}

#pragma mark -- 验证密码
+ (BOOL)validatePassword:(NSString *)password {
    NSString *pattern = @"^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{8,16}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    return [pred evaluateWithObject:password];
  
}

@end
