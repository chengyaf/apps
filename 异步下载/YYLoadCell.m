//
//  YYLoadCell.m
//  异步下载
//
//  Created by mac on 16/8/1.
//  Copyright © 2016年 d. All rights reserved.
//

#import "YYLoadCell.h"


@interface YYLoadCell ()


@end

@implementation YYLoadCell

-(void)setModel:(YYLoadModel *)model{
    _model = model;
    self.downLoad.text = model.download;
    self.name.text = model.name;
    self.iconView.image = model.image;
    }
-(void)layoutSubviews{
    [super layoutSubviews];
    
}

@end
