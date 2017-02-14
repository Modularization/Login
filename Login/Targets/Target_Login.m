//
//  Target_Login.m
//  Login
//
//  Created by majianghai on 2017/2/13.
//  Copyright © 2017年 maZhan. All rights reserved.
//

#import "Target_Login.h"
#import "LoginViewController.h"

@implementation Target_Login
- (UIViewController *)Action_viewController:(NSDictionary *)params
{
    LoginViewController *viewController = [[LoginViewController alloc] init];
    return viewController;
}

@end
