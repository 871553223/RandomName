//
//  ViewController.m
//  RandomName
//
//  Created by 曹敬贺 on 16/8/1.
//  Copyright © 2016年 北京无限点乐科技有限公司. All rights reserved.
//

#import "ViewController.h"
#import "DJRandomMethodName.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    for (int i = 0; i < 3000; i++) {
        NSString * className = [DJRandomMethodName randomClassName];
        NSString * methodName = [DJRandomMethodName randomMethodName];
        NSLog(@"%@ - %@",className,methodName);
    }
}


@end
