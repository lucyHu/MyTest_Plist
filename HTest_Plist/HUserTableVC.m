//
//  HUserTableVC.m
//  HTest_Plist
//
//  Created by 胡晓阳 on 15/6/25.
//  Copyright (c) 2015年 HXY. All rights reserved.
//

#import "HUserTableVC.h"
#import "UserPlistService.h"
#import "HEditVC.h"

@interface HUserTableVC ()
{
    NSMutableArray *userPlist;
}
@end

@implementation HUserTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectZero];
    [_myTable setTableFooterView:footerView];
    
    
    
    [[UserPlistService share] fetchAllUserPlistSuccess:^(id successObj) {
        userPlist = [NSMutableArray arrayWithArray:successObj];
        [_myTable reloadData];
    } error:^{
        userPlist  = [[NSMutableArray alloc] init];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return userPlist.count+1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *userCellID = @"UserCell";
    static NSString *addCellID = @"AddCell";
    
    // Configure the cell...
    UITableViewCell *myCell = nil;
    if (userPlist.count == 0 || (userPlist.count != 0 && indexPath.row == userPlist.count)) {
        
        myCell = [tableView dequeueReusableCellWithIdentifier:addCellID forIndexPath:indexPath];
    }else
    {
        
        myCell = [tableView dequeueReusableCellWithIdentifier:userCellID forIndexPath:indexPath];
        UILabel *nameLB = (UILabel *)[myCell.contentView viewWithTag:1];
        UILabel *scoreLB = (UILabel *)[myCell.contentView viewWithTag:2];
        
        NSString *name = [[userPlist objectAtIndex:indexPath.row] objectForKey:@"name"];
        NSString *score = [[userPlist objectAtIndex:indexPath.row] objectForKey:@"score"];
        
        [nameLB setText:name];
        [scoreLB setText:score];
    }
    
    return myCell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //添加事件
    if (indexPath.row == userPlist.count) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"添加一条成绩记录" message:@"" preferredStyle:1];
        
        [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
            [textField setPlaceholder:@"姓名"];
            
        }];
        
        [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
            [textField setPlaceholder:@"成绩"];
            [textField setKeyboardType:UIKeyboardTypeNumberPad];
        }];
        
        UIAlertAction *acton1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            
        }];
        
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"完成" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            NSString *name = [[alert.textFields objectAtIndex:0] text];
            NSString *score = [[alert.textFields objectAtIndex:1] text];
            //写入plist
            
            [[UserPlistService share] insertWithName:name score:score scucess:^(id successObj) {
                userPlist = successObj;
                [_myTable reloadData];
            } error:^{
                
            }];
        }];
        
        [alert addAction:acton1];
        [alert addAction:action2];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    else//修改某一条成绩
    {
        
        
        HEditVC *editVC = (HEditVC *)[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"HEditVC"];
        editVC.index = indexPath.row;
        editVC.name = [[userPlist objectAtIndex:indexPath.row] objectForKey:@"name"];
        editVC.score = [[userPlist objectAtIndex:indexPath.row] objectForKey:@"score"];
        [self.navigationController pushViewController:editVC animated:YES];
        
        editVC.EditSuccessBlock = ^(id successObj){
            userPlist = successObj;
            [_myTable reloadData];
        };
    }
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        
        [[UserPlistService share] deleteWithName:[[userPlist objectAtIndex:indexPath.row] objectForKey:@"name"]  score:[[userPlist objectAtIndex:indexPath.row] objectForKey:@"score"] success:^(id successObj) {
            userPlist = [NSMutableArray arrayWithArray:successObj];
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        } error:^{
            
        }];
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

/**
 *  给成绩排序
 *
 *  @param sender <#sender description#>
 */
- (IBAction)orderTheScore:(UIBarButtonItem *)sender {
    if ([sender.title isEqualToString:@"升序"]) {
        [sender setTitle:@"降序"];
        
        [[UserPlistService share] sortWithType:0 success:^(id successObj) {
            userPlist = [NSMutableArray arrayWithArray:successObj];
            [_myTable reloadData];

        } error:^{
            
        }];
        
    }else{
        
        [sender setTitle:@"升序"];
        [[UserPlistService share] sortWithType:1 success:^(id successObj) {
            userPlist = [NSMutableArray arrayWithArray:successObj];
            [_myTable reloadData];
            
        } error:^{
            
        }];
    }
}


@end
