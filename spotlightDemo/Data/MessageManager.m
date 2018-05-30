//
//  MessageManager.m
//  spotlightDemo
//
//  Created by Zeus on 2018/5/29.
//  Copyright © 2018年 Zeus. All rights reserved.
//

#import "MessageManager.h"
#import "MMessage.h"
#import <CoreSpotlight/CoreSpotlight.h>
#import <UIKit/UIKit.h>

@implementation MessageManager

+ (void)saveDataToPlist {
    
    /*************************************网络请求的数据start*******************************/
    MMessage *message1 = [[MMessage alloc] initWithTitle:@"孟美岐是谁的大哥" content:@"孟美岐是宙斯的大哥" messageId:@"1" icon:@"mmq1"];
    MMessage *message2 = [[MMessage alloc] initWithTitle:@"孟美岐是谁的大哥" content:@"孟美岐是宙斯的大哥孟美岐是宙斯的大哥孟美岐是宙斯的大哥孟美岐是宙斯的大哥孟美岐是宙斯的大哥孟美岐是宙斯的大哥孟美岐是宙斯的大哥孟美岐是宙斯的大哥孟美岐是宙斯的大哥孟美岐是宙斯的大哥孟美岐是宙斯的大哥孟美岐是宙斯的大哥孟美岐是宙斯的大哥孟美岐是宙斯的大哥孟美岐是宙斯的大哥" messageId:@"2" icon:@"mmq2"];
    MMessage *message3 = [[MMessage alloc] initWithTitle:@"谁会C位出道" content:@"必须是集才华和美好于一身，集智慧和实力于一体的山支大佬" messageId:@"3" icon:@"mmq3"];
    MMessage *message4 = [[MMessage alloc] initWithTitle:@"宇宙少女的跳舞机器" content:@"毛毛球是宇少内舞蹈担当俗称跳舞机器" messageId:@"4" icon:@"mmq4"];
    MMessage *message5 = [[MMessage alloc] initWithTitle:@"山支的101曲目" content:@"1.goodbyeBaby  2.撑腰  3.忐忑  4.我就是这种女孩" messageId:@"5" icon:@"mmq5"];
     MMessage *message6 = [[MMessage alloc] initWithTitle:@"预测101前三排名" content:@"山支必须第一，宣仪第二，超越妹子第三好了" messageId:@"6" icon:@"mmq6"];
    /*************************************网络请求的数据end**********************************/
    
    //存入本地
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [path objectAtIndex:0];
    NSString *plistPath = [documentsPath stringByAppendingPathComponent:@"spotlightMsg.plist"];
    NSArray *messageArr = [NSArray arrayWithObjects:message1,message2,message3,message4,message5,message6, nil];
    [NSKeyedArchiver archiveRootObject:messageArr toFile:plistPath];
}

+ (void)getDataToSpotlightCompletion:(void (^)(NSArray *))completionBlock {
    
    //这个方法模拟在网络请求，然后将数据存入本地，在别的类中可以通过从本地取出数据存入coreSpotlight。当然在网络请求到数据后可以直接存入coreSpotlight不需要先存本地，具体操作根据具体场景选择
    [self saveDataToPlist];
    
    //从本地获取数据
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [pathArray objectAtIndex:0];
    NSString *plistPath = [documentsPath stringByAppendingPathComponent:@"spotlightMsg.plist"];
    NSArray *messageArr = [NSKeyedUnarchiver unarchiveObjectWithFile:plistPath];
    
    //把数据都转换为CSSearchableItem类型
    NSMutableArray *searchableItems = [NSMutableArray array];
    for (MMessage *message in messageArr) {
        
        CSSearchableItemAttributeSet *attributeSet = [[CSSearchableItemAttributeSet alloc] initWithItemContentType:@"image"];
        attributeSet.title = message.title;
        attributeSet.keywords = @[message.title,@"创造101",@"孟美岐"];
        attributeSet.contentDescription = message.content;
//        attributeSet.thumbnailData = UIImageJPEGRepresentation([UIImage imageNamed:message.icon],0.5);
        attributeSet.thumbnailData = UIImagePNGRepresentation([UIImage imageNamed:message.icon]);
        
        CSSearchableItem *item = [[CSSearchableItem alloc] initWithUniqueIdentifier:message.messageId domainIdentifier:@"zeus" attributeSet:attributeSet];
        // 过期的日期,默认过期的日期是一个月
        // item.expirationDate = ;
        [searchableItems addObject:item];
    }
    
    //将数据保存到corespotlight
    [[CSSearchableIndex defaultSearchableIndex] indexSearchableItems:searchableItems completionHandler:^(NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"save error");
        }else {
            NSLog(@"save success");
            //为了使视图刷新所以将数据传出去进行刷新
            completionBlock(messageArr);
        }
        
    }];
}

@end
