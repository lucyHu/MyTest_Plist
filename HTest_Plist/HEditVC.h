//
//  HEditVC.h
//  HTest_Plist
//
//  Created by 胡晓阳 on 15/6/25.
//  Copyright (c) 2015年 HXY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HEditVC : UIViewController
{
    IBOutlet UITextField *nameTF;
    
    IBOutlet UITextField *scoreTF;
}
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *score;

@property (nonatomic, strong) void(^EditSuccessBlock)(id successObj);
@end
