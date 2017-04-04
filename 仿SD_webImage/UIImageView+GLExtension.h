//
//  UIImageView+GLExtension.h
//  仿SD_webImage
//
//  Created by 钟国龙 on 2017/4/5.
//  Copyright © 2017年 guolong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (GLExtension)

@property (nonatomic, copy)NSString *lastUrlString;

- (void)gl_setImageWithUrlString:(NSString *)urlString;

@end
