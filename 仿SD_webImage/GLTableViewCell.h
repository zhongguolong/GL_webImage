//
//  GLTableViewCell.h
//  仿SD_webImage
//
//  Created by 钟国龙 on 2017/4/5.
//  Copyright © 2017年 guolong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GLTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *downLabel;

@end
