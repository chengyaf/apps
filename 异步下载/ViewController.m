//
//  ViewController.m
//  异步下载
//
//  Created by mac on 16/7/30.
//  Copyright © 2016年 d. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
#import "YYLoadModel.h"
#import "SDWebImageManager.h"
#import "UIImageView+WebCache.h"
#import "YYLoadCell.h"
#import "NSString+path.h"

@interface ViewController ()
@property (nonatomic,strong)NSMutableArray *arrdict;
@property (nonatomic,strong)NSOperationQueue *queue;
@property (nonatomic,strong)NSMutableDictionary *imageChehes;
@property (nonatomic,strong)NSMutableDictionary *queuedict;




@end

@implementation ViewController
-(NSMutableDictionary *)queuedict{
    if (_queuedict == nil) {
        _queuedict = [NSMutableDictionary dictionary];
    }
    return  _queuedict;
}
-(NSMutableDictionary *)imageChehes{
    if (_imageChehes == nil) {
        _imageChehes = [NSMutableDictionary dictionary];
    }
    return _imageChehes;
    
}
-(NSMutableArray *)arrdict{
    if (_arrdict == nil) {
        _arrdict = [NSMutableArray array];
    }
    return _arrdict;
}
-(NSOperationQueue *)queue{
    if (_queue == nil) {
        _queue = [[NSOperationQueue alloc]init];
    }
    return _queue;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *urlString =@"https://raw.githubusercontent.com/chengyaf/apps/master/apps.json";
//    NSURL *url = [NSURL URLWithString:@"https://raw.githubusercontent.com/chengyaf/apps/master/apps.json"];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:urlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSMutableArray *arrary = [NSMutableArray array];
        for (NSDictionary *dict in responseObject) {
            YYLoadModel *model = [YYLoadModel loadWithDict:dict];
            [arrary addObject:model];
        }
        self.arrdict = arrary;
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@-----",error);
    }];
    
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.arrdict.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YYLoadCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    YYLoadModel *model = self.arrdict[indexPath.row];
    
    cell.model = model;

//    UIImage *image3 = self.imageChehes[model.icon];
    UIImage *image3 = self.imageChehes[model.icon];
    if (image3 !=nil) {
        cell.iconView.image = image3;
        return cell;
    }
    
    NSString *cashespath = [model.icon appendCachePath];
    UIImage *image = [UIImage imageWithContentsOfFile:cashespath];
    if (image!=nil) {
        cell.iconView.image = image;
        [self.imageChehes setValue:image forKey:model.icon];
        return cell;
    }
    cell.model = model;
//    [cell.imageView  sd_setImageWithURL:[NSURL URLWithString:model.icon]];
    cell.iconView.image = nil;
    if (self.queuedict[model.icon] !=nil) {
        return cell;
    }
   
    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
        if (indexPath.row>=9) {
            [NSThread sleepForTimeInterval:3];

        }
        NSURL *url = [NSURL URLWithString:model.icon];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *image1 = [UIImage imageWithData:data];
        
        NSString *cachesPath =  [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
        NSString *nameString = [model.icon lastPathComponent];
        NSString *path = [cachesPath stringByAppendingPathComponent:nameString];
        [data writeToFile:path atomically:YES];
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            //            self.iconView.image = iconView;
//            model.image = image1;
            if (image1 !=nil) {
                [self.imageChehes setValue:image1 forKey:model.icon];
                
            }
            [self.queuedict removeObjectForKey:model.icon];
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            //            NSLog(@"%@",NSStringFromCGSize(iconView.size));
        }];
        
    }];
    
    [self.queue addOperation:op];

    [self.queuedict setObject:op forKey:model.icon];
   
    
    
//    [self.queue addOperation:op];
    return cell;
}

-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    [self.imageChehes removeAllObjects];
    
    [self.queue cancelAllOperations];
    
}
@end
