//
//  HUserModel.m
//  HTest_Plist
//
//  Created by 胡晓阳 on 15/6/25.
//  Copyright (c) 2015年 HXY. All rights reserved.
//

#import "HUserModel.h"

@implementation HUserModel

-(id)initWithDictionary:(NSDictionary *)dictionary
{
    self.name = [dictionary objectForKey:@"name"];
    self.score = [dictionary objectForKey:@"score"];
    
    return self;
    
}

@end
