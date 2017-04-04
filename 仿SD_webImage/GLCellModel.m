//
//  GLCellModel.m
//  仿SD_webImage
//
//  Created by 钟国龙 on 2017/4/5.
//  Copyright © 2017年 guolong. All rights reserved.
//

#import "GLCellModel.h"

@implementation GLCellModel

+ (instancetype)cellModelWithDict:(NSDictionary *)dict
{
    GLCellModel *model = [[GLCellModel alloc] init];
    
    [model setValuesForKeysWithDictionary:dict];
    
    return model;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{}

@end
