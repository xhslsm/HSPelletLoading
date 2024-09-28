//
//  ViewController.m
//  HSPelletLoading
//
//  Created by 123 on 2024/9/27.
//

#import "ViewController.h"
#import "HSPelletLoadingView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
 
    UIButton *btn = [[UIButton alloc] initWithFrame:self.view.bounds];
    [btn setBackgroundImage:[UIImage imageNamed:@"bbb"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    btn.adjustsImageWhenHighlighted = NO;
    [self.view addSubview:btn];
}

- (void)btnClick{
    NSLog(@"点中了");
    [HSPelletLoadingView dismiss];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [HSPelletLoadingView showSuccessWithStatus:@"正在努力生成中" maskType:HSHudMaskTypeNone];
}
@end
