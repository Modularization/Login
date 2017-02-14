//
//  LoginView.m
//  MaZhan
//
//  Created by majianghai on 2017/1/9.
//  Copyright © 2017年 mazhan. All rights reserved.
//

#import "LoginView.h"
#import "Masonry/Masonry.h"
#import <Register_Category/CTMediator+Register.h>


@interface LoginView ()<UITextFieldDelegate>
@property (weak, nonatomic) UIButton    *clearBtn;   // 登录按钮
@property (weak, nonatomic) UITextField *phoneTF;    // 手机号
@property (weak, nonatomic) UITextField *passwordTF; // 密码
@property (weak, nonatomic) UIButton    *loginBtn;   // 登录按钮

@end

@implementation LoginView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
//        self.backgroundColor = cBackgroundColor;
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(loginViewClicked)]];
        
        
        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:cancelBtn];
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        cancelBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [cancelBtn addTarget:self action:@selector(cancelBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(20);
            make.left.equalTo(self.mas_left).offset(15);
            make.size.mas_equalTo(CGSizeMake(30, 20));
        }];
        
        
        UIImageView *imageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_logo"]];
        [self addSubview:imageV];
        [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.top.mas_equalTo(cancelBtn.mas_top).offset(70);
            make.size.mas_equalTo(CGSizeMake(75, 75));
        }];
        
        
        UIView *backView = [UIView new];
        [self addSubview:backView];
        backView.backgroundColor = [UIColor whiteColor];
        [backView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left);
            make.right.equalTo(self.mas_right);
            make.top.equalTo(imageV.mas_bottom).offset(50);
            make.height.mas_equalTo(90);
        }];
        
        UIImageView *phoneImageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_phone"]];
        [backView addSubview:phoneImageV];
        [phoneImageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(backView.mas_top).offset(10);
            make.left.equalTo(backView.mas_left).offset(15);
            make.size.mas_equalTo(CGSizeMake(25, 25));
        }];
        
        UITextField *phoneTF = [UITextField new];
        self.phoneTF = phoneTF;
        [backView addSubview:phoneTF];
        phoneTF.delegate = self;
        phoneTF.keyboardType = UIKeyboardTypePhonePad;
        phoneTF.borderStyle = UITextBorderStyleNone;
        phoneTF.font = [UIFont systemFontOfSize:16];
        phoneTF.placeholder = @"请输入手机号码";
        [phoneTF addTarget:self action:@selector(textFieldChanged) forControlEvents:UIControlEventEditingChanged];
        [phoneTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(backView.mas_top);
            make.left.equalTo(phoneImageV.mas_right).offset(15);
            make.right.equalTo(backView.mas_right);
            make.height.mas_equalTo(45);
        }];
        
        UIButton *clearBtn = [UIButton new];
        self.clearBtn = clearBtn;
        [backView addSubview:clearBtn];
        [clearBtn setBackgroundImage:[UIImage imageNamed:@"login_clear"] forState:UIControlStateNormal];
        [clearBtn addTarget:self action:@selector(clearBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        clearBtn.hidden = YES;
        [clearBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(phoneImageV.mas_top);
            make.right.equalTo(backView.mas_right).offset(-15);
            make.size.mas_equalTo(CGSizeMake(25, 25));
        }];
        
        
        
        UIView *lineV = [UIView new];
        [backView addSubview:lineV];
//        lineV.backgroundColor = clineColor;
        [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(phoneTF.mas_bottom);
            make.left.equalTo(backView.mas_left).offset(15);
            make.right.equalTo(backView.mas_right).offset(-15);
            make.height.mas_equalTo(0.5);
        }];
        
        
        UIImageView *passwordImageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_password"]];
        [backView addSubview:passwordImageV];
        [passwordImageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lineV.mas_top).offset(10);
            make.left.equalTo(lineV.mas_left);
            make.size.mas_equalTo(CGSizeMake(25, 25));
        }];
        
        UITextField *passwordTF = [UITextField new];
        self.passwordTF = passwordTF;
        [backView addSubview:passwordTF];
        passwordTF.delegate = self;
        passwordTF.borderStyle = UITextBorderStyleNone;
        passwordTF.font = [UIFont systemFontOfSize:16];
        passwordTF.secureTextEntry = YES;
        passwordTF.placeholder = @"请输入密码";
        [passwordTF addTarget:self action:@selector(textFieldChanged) forControlEvents:UIControlEventEditingChanged];
        [passwordTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lineV.mas_top);
            make.left.equalTo(passwordImageV.mas_right).offset(15);
            make.right.equalTo(lineV.mas_right);
            make.height.mas_equalTo(45);
        }];
        
        UIButton *showBtn = [UIButton new];
        [backView addSubview:showBtn];
        [showBtn setBackgroundImage:[UIImage imageNamed:@"login_close"] forState:UIControlStateNormal];
        [showBtn setBackgroundImage:[UIImage imageNamed:@"login_open"] forState:UIControlStateSelected];
        [showBtn addTarget:self action:@selector(showBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [showBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(passwordImageV.mas_top);
            make.right.equalTo(backView.mas_right).offset(-15);
            make.size.mas_equalTo(CGSizeMake(25, 25));
        }];
        
        
        UIButton *loginBtn = [UIButton new];
        [self addSubview:loginBtn];
        self.loginBtn = loginBtn;
//        loginBtn.backgroundColor = cBrandColor;
        loginBtn.layer.cornerRadius = 5.f;
        loginBtn.clipsToBounds = YES;
        loginBtn.alpha = 0.6;
        loginBtn.enabled = NO;
        [loginBtn addTarget:self action:@selector(loginBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [loginBtn setTitle:@"登 录" forState:UIControlStateNormal];
        loginBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(backView.mas_bottom).offset(20);
            make.left.equalTo(lineV.mas_left);
            make.right.equalTo(lineV.mas_right);
            make.height.mas_equalTo(35);
        }];
        
        UIButton *registerBtn = [UIButton new];
        [self addSubview:registerBtn];
        registerBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [registerBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [registerBtn setTitle:@"注册账号" forState:UIControlStateNormal];
        [registerBtn addTarget:self action:@selector(registerBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        [registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(loginBtn.mas_bottom).offset(30);
            make.left.equalTo(loginBtn.mas_left);
        }];
        
        
        UIButton *forgotBtn = [UIButton new];
        [self addSubview:forgotBtn];
        forgotBtn.titleLabel.font = [UIFont systemFontOfSize:16];
//        [forgotBtn setTitleColor:cTextColor2 forState:UIControlStateNormal];
        [forgotBtn setTitle:@"忘记密码？" forState:UIControlStateNormal];
        [forgotBtn addTarget:self action:@selector(registerBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        [forgotBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(loginBtn.mas_bottom).offset(30);
            make.right.equalTo(loginBtn.mas_right);
        }];
        
        UILabel *textLabel1 = [UILabel new];
        textLabel1.text = @"快速登录";
//        textLabel1.textColor = cTextColor1;
        textLabel1.font = [UIFont systemFontOfSize:13];
        [self addSubview:textLabel1];
        [textLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {

            make.centerX.mas_equalTo(self.mas_centerX);
            make.top.mas_equalTo(registerBtn.mas_bottom).offset(30);
        }];
        
        UIView *leftLine = [UIView new];
        [self addSubview:leftLine];
        leftLine.backgroundColor = [UIColor blackColor];
        [leftLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.mas_equalTo(textLabel1.mas_leading);
            make.centerY.mas_equalTo(textLabel1.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(48, 1));
        }];
        
        
        UIView *rightLine = [UIView new];
        [self addSubview:rightLine];
        rightLine.backgroundColor = [UIColor blackColor];
        [rightLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(textLabel1.mas_trailing);
            make.centerY.mas_equalTo(textLabel1.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(48, 1));
        }];
        
        
        UIButton *wxBtn = [UIButton new];
        [self addSubview:wxBtn];
        [wxBtn setImage:[UIImage imageNamed:@"loginWX"] forState:UIControlStateNormal];
        [wxBtn addTarget:self action:@selector(wxBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        [wxBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.top.mas_equalTo(textLabel1.mas_bottom).offset(20);
        }];
        
        
        UILabel *textLabel2 = [UILabel new];
        textLabel2.text = @"微信登录";
//        textLabel2.textColor = cTextColor2;
        textLabel2.font = [UIFont systemFontOfSize:12];
        [self addSubview:textLabel2];
        [textLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.top.mas_equalTo(wxBtn.mas_bottom).offset(15);
        }];
    }
    
    return self;
}


#pragma mark - 用户操作产生的事件
- (void)loginViewClicked
{
    [self endEditing:YES];
}


- (void)loginBtnClicked:(UIButton *)sender
{
//    if ([ValidateTool validateMobile:self.phoneTF.text] == NO) {
//        [[ProgressHUD shareHUD] showMessage:@"请输入正确的手机号"];
//        return;
//    }
//    
//    if (self.passwordTF.text.length == 0) {
//        [[ProgressHUD shareHUD] showMessage:@"请输入密码"];
//        return;
//    }
//    
//    NSMutableDictionary *paramsDict = [NSMutableDictionary dictionary];
//    paramsDict[@"user_mobile"]  = self.phoneTF.text;
//    paramsDict[@"pwd"]          = self.passwordTF.text;
//    paramsDict[@"os_type"]      = @"1";
//    
//    [LoginTool loginWithParamsDict:paramsDict];
}

/// 取消按钮点击事件
- (void)cancelBtnClicked
{
//    [Utils setupTabBarController].selectedIndex = 0;
//    [[Utils getCurrentVC] dismissViewControllerAnimated:YES completion:nil];
}

- (void)clearBtnClicked
{
    self.phoneTF.text = @"";
}

- (void)showBtnClicked:(UIButton *)btn
{
    btn.selected = !btn.isSelected;
    self.passwordTF.secureTextEntry = !self.passwordTF.secureTextEntry;
}


- (void)registerBtnClicked
{
//    UIViewController *viewController = [[CTMediator sharedInstance] Register_viewControllerWithContentText:@"RegisterViewController"];
//    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)forgotBtnClicked
{
    
}


- (void)wxBtnClicked
{
    
}


#pragma mark - delegate event
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.clearBtn.hidden = textField == self.phoneTF ? NO : YES;
}


- (void)textFieldChanged
{
    if (self.phoneTF.text.length > 0 && self.passwordTF.text.length > 0) {
        self.loginBtn.enabled = YES;
        self.loginBtn.alpha = 1;
    } else {
        self.loginBtn.enabled = NO;
        self.loginBtn.alpha = 0.6;
    }
}





@end
