//
//  MessageManager.h
//  spotlightDemo
//
//  Created by Zeus on 2018/5/29.
//  Copyright © 2018年 Zeus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageManager : NSObject

+ (void)getDataToSpotlightCompletion:(void(^)(NSArray *dataArr))completionBlock;

@end
