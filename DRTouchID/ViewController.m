//
//  ViewController.m
//  DRTouchID
//
//  Created by Darry on 16/3/1.
//  Copyright © 2016年 Darry. All rights reserved.
//

#import "ViewController.h"
#import "DRTouchIDContext.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)startEvalute:(id)sender {
    
#if 1
    //block玩法
    [[[DRTouchIDContext alloc]init]startDREvaluatePolicyWithSubtitle:@"子标题" fallbackTitle:@"错误fallback标题" reply:^(BOOL success, NSError * _Nullable error) {
        if (success) {
            NSLog(@"BINGO!");
        }else {
            NSLog(@"ERROR:%@", error);
        }
    }];
#else
    //链式玩法，有待订正完善
    [DRTouchIDContext creatDRTouchIDContext:^(DRTouchIDContext *drContext) {
        NSError *error = nil;
        BOOL success  =  drContext.beginDRTouch(@"这里填写子标题", @"这里填写fallback按钮标题", &error);
        if (success) {
            NSLog(@"BINGO!");
        }else {
            NSLog(@"ERROR:%@", error);
        }
    }];
#endif
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
