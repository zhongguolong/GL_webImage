//
//  GLCellModel.h
//  仿SD_webImage
//
//  Created by 钟国龙 on 2017/4/5.
//  Copyright © 2017年 guolong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GLCellModel : NSObject

@property (nonatomic, copy)NSString *download;
@property (nonatomic, copy)NSString *icon;
@property (nonatomic, copy)NSString *name;

+ (instancetype)cellModelWithDict:(NSDictionary *)dict;

@end
