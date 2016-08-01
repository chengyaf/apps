//
//  YYLoadCell.h
//  异步下载
//
//  Created by mac on 16/8/1.
//  Copyright © 2016年 d. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYLoadModel.h"

@interface YYLoadCell : UITableViewCell
@property (nonatomic,strong)YYLoadModel *model;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *downLoad;
@end
