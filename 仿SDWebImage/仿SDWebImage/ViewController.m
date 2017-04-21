//
//  ViewController.m
//  仿SDWebImage
//
//  Created by 贾晓磊 on 17/4/21.
//  Copyright © 2017年 贾晓磊. All rights reserved.
//

#import "ViewController.h"
#import "DownloadOperation.h"
@interface ViewController ()

@end

@implementation ViewController {
    //全局队列
    NSOperationQueue *_queue;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //实例化队列
    _queue = [[NSOperationQueue alloc] init];
    
    DownloadOperation *op = [[DownloadOperation alloc] init];
    
    [_queue addOperation:op];
    
    //指定自定义操作,执行任务
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
