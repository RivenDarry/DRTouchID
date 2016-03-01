//
//  DRTouchIDContext.m
//  DRTouchID
//
//  Created by Darry on 16/3/1.
//  Copyright © 2016年 Darry. All rights reserved.
//

#import "DRTouchIDContext.h"

@implementation DRTouchIDContext

#pragma mark - Block方法

- (void)startDREvaluatePolicyWithSubtitle:(NSString *)subtitle fallbackTitle:(NSString *)fallbackTitle reply:(void (^)(BOOL success, NSError * _Nullable error))reply
{
    //1.创建指纹验证对象
    DRTouchIDContext *context = [[DRTouchIDContext alloc]init];
    NSError *error = nil;
    //2.验证是否支持指纹
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        //3.开始验证
        context.localizedFallbackTitle = fallbackTitle;
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:subtitle reply:^(BOOL success, NSError * _Nullable error) {
            if (success) reply(true, nil);
            else reply(false,error);
        }];
    }else
        reply(false,error);
}

#pragma mark - 链式玩法，有待订正完善

+ (void)creatDRTouchIDContext:(void(^)(DRTouchIDContext *))block
{
    block([[DRTouchIDContext alloc]init]);
}

- (BOOL (^)(NSString *, NSString * _Nullable, NSError *__autoreleasing *))beginDRTouch
{
     BOOL __block final_success = false;
    return ^BOOL (NSString *subtitle, NSString *fallbackTitle, NSError *__autoreleasing *error){
        if ([self canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:error]) {
            self.localizedFallbackTitle = fallbackTitle;
            [self evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:subtitle reply:^(BOOL success, NSError * _Nullable error) {
                if (success)
                    final_success = true;
                else
                    final_success = false;
            }];
         
        }else
            final_success = false;
        return final_success;
    };
}

@end
