//
//  CDLoginViewController.m
//  FattyMovie
//
//  Created by luo on 16/3/14.
//  Copyright © 2016年 luo. All rights reserved.
//

#import "CDLoginViewController.h"
#import "CateAnimationLogin.h"
#import "CDRegisterViewController.h"
#import "Tool.h"


#define LOGIN_HEIGHT 320
#define LOGIN_Y (SCREEN_HEIGHT-LOGIN_HEIGHT)/2 - 20


@interface CDLoginViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UIImageView *bgView;

@end

@implementation CDLoginViewController{

    CateAnimationLogin *_login;
    UIButton * _loginButton;




}

- (UIImageView *)bgView{
    if (_bgView == nil) {
        _bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    }

    return _bgView;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];

    self.title = @"登录";
    [self.view addSubview:self.bgView];
    self.bgView.image = [UIImage imageNamed:@"3.jpg"];
    self.bgView.userInteractionEnabled = YES;
    [self customRegisterButton];
    
    _login = [[CateAnimationLogin alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, LOGIN_HEIGHT)];
    _login.backgroundColor = [UIColor clearColor];
    [self.bgView addSubview:_login];
    
    
    _loginButton = [[UIButton alloc] initWithFrame:CGRectMake(40, CGRectGetMaxY(_login.frame) + 50, SCREEN_WIDTH - 80, 30)];
    [self.bgView addSubview:_loginButton];
    [_loginButton setTitle:@"登  录" forState:UIControlStateNormal];
    _loginButton.backgroundColor = [UIColor colorWithRed:248/255.0f green:144/255.0f blue:34/255.0f alpha:0.8];
    _loginButton.layer.cornerRadius = 5.0f;
    [_loginButton addTarget:self action:@selector(loginButtonClicked:) forControlEvents:UIControlEventTouchUpInside];

    _loginButton.enabled = NO;
    _loginButton.alpha = 0.6;
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showKeyboard:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideKeyboard:) name:UIKeyboardWillHideNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkTextField) name:UITextFieldTextDidChangeNotification object:nil];
    
    
}

- (void)customRegisterButton{
    
    UIButton * registerButton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 200, self.view.frame.size.height - 170, 190, 30)];
    [self.bgView addSubview:registerButton];
    registerButton.backgroundColor = [UIColor clearColor];
    [registerButton setTitle:@"没有账号?马上注册" forState:UIControlStateNormal];
    [registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    registerButton.titleLabel.font = [UIFont systemFontOfSize:12];
    registerButton.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
    [registerButton addTarget:self action:@selector(registerButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_bgView addSubview:registerButton];
    
    UINavigationItem * naviItem = self.navigationItem;
    UIBarButtonItem * rightBarItem = [[UIBarButtonItem alloc] initWithTitle:@"注册" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemClicked:)];
    rightBarItem.tintColor = [UIColor whiteColor];
    naviItem.rightBarButtonItem = rightBarItem;
    
}


- (void) loginButtonClicked:(UIButton *) sender{

    [SVProgressHUD showWithStatus:@"登录中..." maskType:SVProgressHUDMaskTypeClear];

    NSString *pwdMDTStr = [Tool MD5StringFromString:_login.PassWordTextField.text];
    
    [BmobUser loginWithUsernameInBackground:_login.userNameTextField.text password:pwdMDTStr block:^(BmobUser *user, NSError *error) {
        if (user) {
            [SVProgressHUD showSuccessWithStatus:@"登陆成功"];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"UserRefreshNotice" object:nil];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        }else{
        
            NSString *msg = nil;
            if (error.code == 101) {
                msg = @"账号或密码错误";
            }else{
            
            
            }
            [SVProgressHUD showErrorWithStatus:msg];
        
        }
        
        
        
        
        
    }];
    
    
    


}

- (void) registerButtonClicked:(UIButton *) sender{


    CDRegisterViewController *registerVC = [[CDRegisterViewController alloc] init];
    [self.navigationController pushViewController:registerVC animated:YES];
    
    
    

}

- (void) rightBarButtonItemClicked:(UIBarButtonItem *) sender{


    CDRegisterViewController *registerVC = [[CDRegisterViewController alloc] init];
    [self.navigationController pushViewController:registerVC animated:YES];
    
    
    
    


}


- (void)showKeyboard:(NSNotification *)notif{

    CGFloat animationDuration = [notif.userInfo[@"UIKeyboardAnimationDurationUserInfoKey"]floatValue];
    
    [UIView animateWithDuration:animationDuration animations:^{
        CGRect rect = _login.frame;
        rect.origin.y = -70;
        _login.frame = rect;
        
        CGRect rect1 = _loginButton.frame;
        rect1.origin.y = 310;
        _loginButton.frame = rect1;
        
    }];


}

- (void) hideKeyboard:(NSNotification *) notif {



    CGFloat animationDuration = [notif.userInfo[@"UIKeyboardAnimationDurationUserInfoKey"]floatValue];
    [UIView animateWithDuration:animationDuration animations:^{
        CGRect rect = _login.frame;
        rect.origin.y = 0;
        _login.frame = rect;
        
        
        CGRect rect1 = _loginButton.frame;
        rect1.origin.y = CGRectGetMaxY(_login.frame)+50;
        _loginButton.frame = rect1;
        
    }];




}

- (void) checkTextField{

    if (_login.userNameTextField.text.length != 0 && _login.PassWordTextField.text.length != 0) {
        _loginButton.enabled = YES;
        _loginButton.alpha = 1;
        
    }else{
    
        _loginButton.enabled = NO;
        _loginButton.alpha = 0.5;
    
    
    }
    


}

- (BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{

    NSMutableString *oldString = [NSMutableString stringWithString:textField.text];
    
    if (range.length > 0) {
        [oldString deleteCharactersInRange:range];
    }else{
    
        [oldString insertString:string atIndex:range.location];
    
    }
    if (oldString.length > 16) {
        return NO;
    }
    return YES;

}

- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{


    [self.view endEditing:YES];

}


@end
