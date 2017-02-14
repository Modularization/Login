//
//  LoginViewController.m
//  MaZhan
//
//  Created by majianghai on 2017/1/9.
//  Copyright © 2017年 mazhan. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginView.h"


@interface LoginViewController ()
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) LoginView *loginView;
@end

@implementation LoginViewController

- (void)loadView
{
    self.view = [UIView new];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBar.hidden = YES;
    
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.loginView];
}


#pragma mark - setter && getter
- (UIScrollView *)scrollView
{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.contentSize = CGSizeMake(0, 550);
    }
    return _scrollView;
}


- (LoginView *)loginView
{
    if (_loginView == nil) {
        _loginView = [[LoginView alloc] initWithFrame:_scrollView.bounds];
    }
    return _loginView;
}

@end
