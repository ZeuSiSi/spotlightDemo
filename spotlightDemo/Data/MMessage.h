//
//  MMessage.h
//  spotlightDemo
//
//  Created by Zeus on 2018/5/29.
//  Copyright © 2018年 Zeus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MMessage : NSObject<NSCoding>

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, copy) NSString *messageId;

@property (nonatomic, copy) NSString *icon;

- (instancetype)initWithTitle:(NSString *)title content:(NSString *)content messageId:(NSString *)messageId icon:(NSString *)icon;

@end
