//
//  LoginViewController.m
//  MaZhan
//
//  Created by majianghai on 2017/1/9.
//  Copyright © 2017年 mazhan. All rights reserved.
//

#import "LoginViewController.h"


@interface LoginViewController ()
@property (nonatomic, strong) UIScrollView *scrollView;
@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBar.hidden = YES;
    
    [self.view addSubview:self.scrollView];
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




@end
