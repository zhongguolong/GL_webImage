//
//  NSString+GLExtension.m
//  仿SD_webImage
//
//  Created by 钟国龙 on 2017/4/5.
//  Copyright © 2017年 guolong. All rights reserved.
//

#import "NSString+GLExtension.h"

@implementation NSString (GLExtension)
- (NSString *)appendCachePath
{
    NSString *cache = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
    NSString *name = [self lastPathComponent];
    NSString *filePath = [cache stringByAppendingPathComponent:name];
    
    return filePath;
}
@end
