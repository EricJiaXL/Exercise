//
//  ViewController.m
//  仿SDWebImage
//
//  Created by 贾晓磊 on 17/4/21.
//  Copyright © 2017年 贾晓磊. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
#import "appModel.h"
#import "DownloadManager.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@end

@implementation ViewController {
    //全局队列
    NSOperationQueue *_queue;
    //数据源数组
    NSArray *_appModelList;
    //操作缓存池
    NSMutableDictionary *_OPCache;
    //上一次的下载地址
    NSString *_lastURLString;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //实例化队列
    _queue = [[NSOperationQueue alloc] init];
    
    //实例化操作缓存池
    _OPCache = [[NSMutableDictionary alloc] init];
    
    [self loadJasonData];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    //获取随机数
    int random = arc4random_uniform((uint32_t)_appModelList.count);
    
    //获取模型
    appModel *model = _appModelList[random];
    
    //如果上次操作有记录,取消任务
    if (![model.icon isEqualToString:_lastURLString] && _lastURLString != nil) {
        //单例取出上一次的下载操作
        [[DownloadManager sharedManager] cancelWithLastURLString:_lastURLString];
        
    }
    
    //记录上次操作
    _lastURLString = model.icon;
   
    //单例接管下载操作
    [[DownloadManager sharedManager] downloadWithURLString:model.icon finishedBlock:^(UIImage *image) {
        self.iconImageView.image = image;

    }];
    
//    //实例化自定义操作
//    DownloadOperation *op = [DownloadOperation downloadWithURLString:model.icon finishedBlock:^(UIImage *image) {
//        NSLog(@"%@  %@",image,[NSThread currentThread]);
//        
//        self.iconImageView.image = image;
//        
//        [_OPCache removeObjectForKey:model.icon];
//        
//    }];
//    
//    //把操作添加到操作缓存池
//    [_OPCache setObject:op forKey:model.icon];
//    [_queue addOperation:op];

    
}
- (void)loadJasonData {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString *urlString = @"https://raw.githubusercontent.com/EricJiaXL/ServerFile/master/apps.json";
    
    [manager GET:urlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSArray * responseObject) {
        
        //        NSLog(@"%@",responseObject);
        NSMutableArray *tempArray = [NSMutableArray arrayWithCapacity:responseObject.count];
        
        [responseObject enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            appModel *model = [appModel appModelWithDictionary:obj];
            [tempArray addObject:model];
        }];
        
        _appModelList = tempArray.copy;
        
       
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)demo {
//    //实例化队列
//    _queue = [[NSOperationQueue alloc] init];
//    
//    //实例化自定义操作
//    DownloadOperation *op = [[DownloadOperation alloc] init];
//    
//    
//    //向自定义内部传入操作地址
//    op.URLString = @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1492945630344&di=d9a8ed322088854e8b7522a260dfd681&imgtype=0&src=http%3A%2F%2Fpic6.huitu.com%2Fres%2F20130116%2F84481_20130116142820494200_1.jpg";
//    
//    //传入代码块到自定义操作对象
//    [op setFinishedBlock:^(UIImage *image) {
//        NSLog(@"%@  %@",image,[NSThread currentThread]);
//    }];
//    
//    //把自定义操作添加到队列
//    [_queue addOperation:op];
//    
//    //指定自定义操作,执行任务
//
//}

@end
