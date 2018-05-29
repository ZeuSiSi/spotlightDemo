//
//  MMessage.m
//  spotlightDemo
//
//  Created by Zeus on 2018/5/29.
//  Copyright © 2018年 Zeus. All rights reserved.
//

#import "MMessage.h"

@implementation MMessage

- (instancetype)initWithTitle:(NSString *)title content:(NSString *)content messageId:(NSString *)messageId icon:(NSString *)icon{

    if (self = [super init]) {
        self.title = title;
        self.content = content;
        self.messageId = messageId;
        self.icon = icon;
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.content forKey:@"content"];
    [aCoder encodeObject:self.messageId forKey:@"messageId"];
    [aCoder encodeObject:self.icon forKey:@"icon"];
}

// 存储部分数据
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        self.title = [aDecoder decodeObjectForKey:@"title"];
        self.content = [aDecoder decodeObjectForKey:@"content"];
        self.messageId = [aDecoder decodeObjectForKey:@"messageId"];
        self.icon = [aDecoder decodeObjectForKey:@"icon"];
    }
    return self;
}

@end
