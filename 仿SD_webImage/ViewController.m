//
//  ViewController.m
//  仿SD_webImage
//
//  Created by 钟国龙 on 2017/4/5.
//  Copyright © 2017年 guolong. All rights reserved.
//

#import "ViewController.h"

#import "GLTableViewCell.h"
#import "AFNetworking.h"
#import "GLCellModel.h"
#import "UIImageView+GLExtension.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)NSArray<GLCellModel *> *modelList;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self loadData];
}

- (void)loadData
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:@"https://raw.githubusercontent.com/qiruihua/image/master/app.json" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSMutableArray *arrM = [NSMutableArray array];
        
        [responseObject enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            GLCellModel *model = [GLCellModel cellModelWithDict:obj];
            [arrM addObject:model];
            
        }];
        
        self.modelList = arrM.copy;
        [self.tableView reloadData];
        
    } failure:nil];
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.modelList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GLTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    GLCellModel *model = self.modelList[indexPath.row];
    
    cell.nameLabel.text = model.name;
    cell.downLabel.text = model.download;
    
    //设置占位图，防止卡顿
    UIImage *holderImage = [UIImage imageNamed:@"user_default"];
    cell.iconView.image = holderImage;
    
    [cell.iconView gl_setImageWithUrlString:model.icon];
    
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

@end
