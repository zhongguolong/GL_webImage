//
//  UIImageView+GLExtension.m
//  仿SD_webImage
//
//  Created by 钟国龙 on 2017/4/5.
//  Copyright © 2017年 guolong. All rights reserved.
//

#import "UIImageView+GLExtension.h"
#import "GL_webImageManager.h"
#import <objc/runtime.h>

const void *key = "key";

@implementation UIImageView (GLExtension)

- (void)gl_setImageWithUrlString:(NSString *)urlString
{
    if (![urlString isEqualToString:self.lastUrlString] && self.lastUrlString != nil)
    {
        //取消当前线程的下载操作
        [[GL_webImageManager manager] cancelWithUrlString:urlString];
    }
    
    self.lastUrlString = urlString;
    self.image = nil;
    
    [[GL_webImageManager manager] downloadImageWithURLString:urlString finishBlock:^(UIImage *image) {
        self.image = image;
        self.lastUrlString = nil;
    }];
}

//运行时关联对象
- (void)setLastUrlString:(NSString *)lastUrlString
{
    objc_setAssociatedObject(self, key, lastUrlString, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)lastUrlString
{
    return objc_getAssociatedObject(self, key);
}

@end
