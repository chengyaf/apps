//
//  YYLoadModel.m
//  异步下载
//
//  Created by mac on 16/7/31.
//  Copyright © 2016年 d. All rights reserved.
//

#import "YYLoadModel.h"

@implementation YYLoadModel

+(instancetype)loadWithDict:(NSDictionary *)dict{
    YYLoadModel *model = [[YYLoadModel alloc]init];
    [model setValuesForKeysWithDictionary:dict];
    
    return model;
}
@end
