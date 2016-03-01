//
//  DRTouchIDContext.h
//  DRTouchID
//
//  Created by Darry on 16/3/1.
//  Copyright © 2016年 Darry. All rights reserved.
//

#import <LocalAuthentication/LocalAuthentication.h>

@interface DRTouchIDContext : LAContext

/* Block方法 **/
- (void)startDREvaluatePolicyWithSubtitle:(NSString *)subtitle fallbackTitle:(NSString *)fallbackTitle reply:(void(^)(BOOL success, NSError * __nullable error))reply;

/* 链式玩法，有待订正完善 **/
+ (void)creatDRTouchIDContext:(void(^)(DRTouchIDContext *))block;
- (BOOL (^)(NSString *, NSString * _Nullable, NSError *__autoreleasing *))beginDRTouch;

@end
