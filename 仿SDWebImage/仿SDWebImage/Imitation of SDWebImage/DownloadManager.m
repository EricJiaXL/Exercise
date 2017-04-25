//
//  DownloadManager.m
//  仿SDWebImage
//
//  Created by 贾晓磊 on 17/4/25.
//  Copyright © 2017年 贾晓磊. All rights reserved.
//

#import "DownloadManager.h"

@implementation DownloadManager {
    //全局队列
    NSOperationQueue *_queue;
    //操作缓存池
    NSMutableDictionary *_OPCache;
}

+ (instancetype)sharedManager {
    
    static id instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    
    return instance;
}

- (instancetype)init {
    if (self = [super init]) {
        _queue = [[NSOperationQueue alloc] init];
        _OPCache = [[NSMutableDictionary alloc] init];
    }
    return self;
}
//单例下载图片主方法
- (void)downloadWithURLString:(NSString *)urlString finishedBlock:(void(^)(UIImage *image))finishedBlock {
    //判断操作缓存池里面有没有要下载的操作,如果有就直接返回,不再建立重复的下载操作
    if ([_OPCache objectForKey:urlString] != nil) {
        return;
    }
            void(^MfinishedBlock)(UIImage *image) = ^(UIImage *image){
                if (finishedBlock
                    != nil) {
                    finishedBlock(image);
                }

                [_OPCache removeObjectForKey:urlString];
            };
    
    //创建操作的同时传入图片地址和下载完成的回掉
    DownloadOperation *op = [DownloadOperation downloadWithURLString:urlString finishedBlock:MfinishedBlock];
        //把操作添加到操作缓存池
        [_OPCache setObject:op forKey:urlString];
        [_queue addOperation:op];


}

//单例管理取消操作方法
- (void)cancelWithLastURLString:(NSString *)lastURLString {
   
    DownloadOperation *lastOP = [_OPCache objectForKey:lastURLString];
    
    if (lastOP != nil) {
        [lastOP cancel];
        [_OPCache removeObjectForKey:lastURLString];
    }
    
}
@end
