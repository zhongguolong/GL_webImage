//
//  GL_webImageManager.m
//  仿SD_webImage
//
//  Created by 钟国龙 on 2017/4/5.
//  Copyright © 2017年 guolong. All rights reserved.
//

#import "GL_webImageManager.h"
#import "NSString+GLExtension.h"
#import "GLDownLoadOperation.h"

@interface GL_webImageManager ()

@property (nonatomic, strong)NSMutableDictionary *cacheOp;
@property (nonatomic, strong)NSMutableDictionary *cacheImage;
@property (nonatomic, strong)NSOperationQueue *queue;

@end

@implementation GL_webImageManager

+ (instancetype)manager
{
    static GL_webImageManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[GL_webImageManager alloc] init];
    });
    return manager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _cacheOp = [NSMutableDictionary dictionary];
        _cacheImage = [NSMutableDictionary dictionary];
        _queue = [NSOperationQueue new];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clearMemory) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
    }
    return self;
}

#pragma mark - 下载管理
- (void)downloadImageWithURLString:(NSString *)urlString finishBlock:(void(^)(UIImage *image))finishBlock
{
    //从缓存池中寻找
    UIImage *cacheImage = [self.cacheImage objectForKey:urlString];
    
    if (cacheImage != nil)
    {
        if (finishBlock) {
            finishBlock(cacheImage);
        }
        return;
    }
    
    //从沙盒中寻找
    NSString *diskPath = [urlString appendCachePath];
    UIImage *diskImage = [UIImage imageWithContentsOfFile:diskPath];
    
    
    if (diskImage != nil)
    {
        if (finishBlock) {
            finishBlock(diskImage);
        }
        //沙盒图片添加到缓存池中
        [self.cacheImage setObject:diskImage forKey:urlString];
        return;
    }
    
    //操作缓存池，是否已有下载操作
    NSBlockOperation *opCahce = [self.cacheOp objectForKey:urlString];
    if (opCahce != nil)
    {
        return;
    }
    
    //下载操作，自定义Operation
    GLDownLoadOperation *op = [GLDownLoadOperation downloadImageWithUrl:urlString];
    
    //注意循环引用
    __weak GLDownLoadOperation *weakOp = op;
    
    [op setCompletionBlock:^{
        
        UIImage *image = weakOp.downloadImage;
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            if (image)
            {
                if (finishBlock)
                {
                    finishBlock(image);
                }
                
                //缓存
                [self.cacheImage setObject:image forKey:urlString];
                //操作移除
                [self.cacheOp removeObjectForKey:urlString];
                
            }
        }];
        
    }];
    
    [self.queue addOperation:op];
    
    [self.cacheOp setObject:op forKey:urlString];
    
}

#pragma mark - 取消下载
- (void)cancelWithUrlString:(NSString *)urlString
{
    GLDownLoadOperation *op = [self.cacheOp objectForKey:urlString];
    if (op != nil)
    {
        [op cancel];
    }
}

#pragma mark - 清除内存
- (void)clearMemory
{
    [self.cacheImage removeAllObjects];
    [self.cacheOp removeAllObjects];
    [self.queue cancelAllOperations];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
