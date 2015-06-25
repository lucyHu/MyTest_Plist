//
//  UserPlistService.m
//  HTest_Plist
//
//  Created by 胡晓阳 on 15/6/25.
//  Copyright (c) 2015年 HXY. All rights reserved.
//

#import "UserPlistService.h"
#define UserPlistName @"user.plist"

@implementation UserPlistService
+(UserPlistService *)share
{
    static UserPlistService *_service = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _service = [[UserPlistService alloc] init];

    });
    
    return _service;
}

/**
 *  获取所有数据
 *
 *  @param success 成功
 *  @param error   失败
 */
-(void)fetchAllUserPlistSuccess:(void (^)(id successObj))success error:(void (^)(void))error
{
    NSString *documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *plistPath = [documentDirectory stringByAppendingPathComponent:UserPlistName];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:plistPath]) {
        NSMutableArray *userPlist = [NSMutableArray arrayWithContentsOfFile:plistPath];
        success(userPlist);
    }else
    {
        
        NSMutableArray *userList = [[NSMutableArray alloc] init];
        [userList writeToFile:plistPath atomically:YES];
        error();
    }
}

/**
 *  添加一条记录
 *
 *  @param name    姓名
 *  @param score   成绩
 *  @param success 成功
 *  @param error   失败
 */
-(void)insertWithName:(NSString *)name score:(NSString *)score scucess:(void (^)(id success))success error:(void (^)(void))error
{
     NSString *plistPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:UserPlistName];
    NSMutableArray *userList = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:name,@"name",score,@"score", nil];
    [userList addObject:dic];
    [userList writeToFile:plistPath atomically:YES];
    success(userList);
    
}

/**
 *  删除一条记录
 *
 *  @param name    姓名
 *  @param score   成绩
 *  @param success 成功
 *  @param error   失败
 */
-(void)deleteWithName:(NSString *)name score:(NSString *)score success:(void (^)(id))success error:(void (^)(void))error
{
    NSString *plistPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:UserPlistName];
    NSMutableArray *userList = [NSMutableArray arrayWithContentsOfFile:plistPath];
    [userList removeObject:@{@"name":name,@"score":score}];
    [userList writeToFile:plistPath atomically:YES];
    
    success(userList);
}


/**
 *  更新一条数据
 *
 *  @param name    <#name description#>
 *  @param score   <#score description#>
 *  @param success <#success description#>
 *  @param error   <#error description#>
 */
-(void)updateWithName:(NSString *)name score:(NSString *)score atIndex:(NSInteger)index success:(void (^)(id))success error:(void (^)(void))error
{
    NSString *plistPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:UserPlistName];
    NSMutableArray *userList = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
    
    NSDictionary *newDic = @{@"name":name,@"score":score};
    [userList replaceObjectAtIndex:index withObject:newDic];
    if ([userList writeToFile:plistPath atomically:YES]) {
        success(userList);
    }else
    {
        NSLog(@"写文件失败");
    }
}

/**
 *  给记录排序
 *
 *  @param type    0：升序 1：降序
 *  @param success 成功
 *  @param eror    失败
 */
-(void)sortWithType:(NSInteger)type success:(void (^)(id successObj))success error:(void (^)(void))eror
{
    NSString *plistPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:UserPlistName];
    NSMutableArray *userList = [NSMutableArray arrayWithContentsOfFile:plistPath];
    
    if (type == 0) {
        //升序
        NSSortDescriptor *scoreUp_sort = [NSSortDescriptor sortDescriptorWithKey:@"score" ascending:YES];
        NSArray *arr = [userList sortedArrayUsingDescriptors:@[scoreUp_sort]];
        if ([arr writeToFile:plistPath atomically:YES]) {
             success(arr);
        }
       
    }else
    {
        //降序
        NSSortDescriptor *scoreDown_sort = [NSSortDescriptor sortDescriptorWithKey:@"score" ascending:NO];
        NSArray *arr = [userList sortedArrayUsingDescriptors:@[scoreDown_sort]];
        if ([arr writeToFile:plistPath atomically:YES]) {
            success(arr);
        }
        
    }
}
@end
