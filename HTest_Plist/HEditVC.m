//
//  HEditVC.m
//  HTest_Plist
//
//  Created by 胡晓阳 on 15/6/25.
//  Copyright (c) 2015年 HXY. All rights reserved.
//

#import "HEditVC.h"
#import "UserPlistService.h"

@interface HEditVC ()

@end

@implementation HEditVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"修改成绩";
    
    [nameTF setText:_name];
    [scoreTF setText:_score];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  保存
 *
 *  @param sender <#sender description#>
 */
- (IBAction)saveAction:(id)sender {
    
    [[UserPlistService share] updateWithName:nameTF.text score:scoreTF.text atIndex:_index success:^(id successObj) {
        if (_EditSuccessBlock) {
            _EditSuccessBlock(successObj);
        }
        
        [self.navigationController popViewControllerAnimated:YES];
    } error:^{
        
    }];
}
@end
