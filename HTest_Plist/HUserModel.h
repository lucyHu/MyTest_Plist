//
//  HUserModel.h
//  HTest_Plist
//
//  Created by 胡晓阳 on 15/6/25.
//  Copyright (c) 2015年 HXY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HUserModel : NSObject
@property (nonatomic, strong) NSString *name;//姓名
@property (nonatomic, strong) NSString *score;//分数

-(id)initWithDictionary:(NSDictionary *)dictionary;
@end
