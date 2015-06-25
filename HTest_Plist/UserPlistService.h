//
//  UserPlistService.h
//  HTest_Plist
//
//  Created by 胡晓阳 on 15/6/25.
//  Copyright (c) 2015年 HXY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserPlistService : NSObject

+(UserPlistService *)share;

/**
 *  获取所有数据
 *
 *  @param success 成功
 *  @param error   失败
 */
-(void)fetchAllUserPlistSuccess:(void(^)(id successObj))success error:(void(^)(void))error;

/**
 *  添加一条记录
 *
 *  @param name    姓名
 *  @param score   成绩
 *  @param success 成功
 *  @param error   失败
 */
-(void)insertWithName:(NSString *)name score:(NSString *)score scucess:(void(^)(id successObj))success error:(void(^)(void))error;

/**
 *  删除一条记录
 *
 *  @param name    姓名
 *  @param score   成绩
 *  @param success 成功
 *  @param error   失败
 */
-(void)deleteWithName:(NSString *)name score:(NSString *)score success:(void(^)(id successObj))success error:(void(^)(void))error;

/**
 *  更新一条数据
 *
 *  @param name    <#name description#>
 *  @param score   <#score description#>
 *  @param success <#success description#>
 *  @param error   <#error description#>
 */
-(void)updateWithName:(NSString *)name score:(NSString *)score atIndex:(NSInteger)index success:(void(^)(id successObj))success error:(void(^)(void))error;

-(void)sortWithType:(NSInteger)type success:(void(^)(id successObj))success error:(void(^)(void))eror;
@end
