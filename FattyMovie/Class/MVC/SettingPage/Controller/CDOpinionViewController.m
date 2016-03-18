//
//  CDOpinionViewController.m
//  FattyMovie
//
//  Created by luo on 16/3/17.
//  Copyright © 2016年 luo. All rights reserved.
//

#import "CDOpinionViewController.h"

@interface CDOpinionViewController ()
@property (weak, nonatomic) IBOutlet UITextView *tf;

@end

@implementation CDOpinionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)Upload:(id)sender {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"提交成功" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [_tf resignFirstResponder];

}


@end
