//
//  GLDownLoadOperation.h
//  仿SD_webImage
//
//  Created by 钟国龙 on 2017/4/5.
//  Copyright © 2017年 guolong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface GLDownLoadOperation : NSOperation

@property (nonatomic, strong)UIImage *downloadImage;

+ (instancetype)downloadImageWithUrl:(NSString *)urlString;

@end
