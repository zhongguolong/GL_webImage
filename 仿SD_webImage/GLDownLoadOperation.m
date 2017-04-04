//
//  GLDownLoadOperation.m
//  仿SD_webImage
//
//  Created by 钟国龙 on 2017/4/5.
//  Copyright © 2017年 guolong. All rights reserved.
//

#import "GLDownLoadOperation.h"
#import "NSString+GLExtension.h"

@interface GLDownLoadOperation ()
@property (nonatomic, copy)NSString *urlString;
@end

@implementation GLDownLoadOperation
+ (instancetype)downloadImageWithUrl:(NSString *)urlString
{
    GLDownLoadOperation *op = [[GLDownLoadOperation alloc] init];
    op.urlString = urlString;
    return op;
}

//重写main方法，进行下载操作
- (void)main
{
    //下载前取消
    if (self.isCancelled)
    {
        return;
    }
    NSURL *url = [NSURL URLWithString:self.urlString];
    NSData *data = [[NSData alloc] initWithContentsOfURL:url];
    //下载后取消
    if (self.isCancelled)
    {
        return;
    }
    UIImage *image = [UIImage imageWithData:data];
    
    //主线程刷新
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        self.downloadImage = image;
    }];
    
    //写入沙盒
    if (data != nil)
    {
        [data writeToFile:[self.urlString appendCachePath] atomically:YES];
    }
    
}

@end
