
//
//  SecondViewController.m
//  PopInterceptDemo
//
//

#import "SecondViewController.h"
#import "LPNavigationController.h"
#import "UIViewController+BackButtonHandler.h"
#import "ThirdViewController.h"

@interface SecondViewController ()<LPNavigationControllerDelegate>

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"Second";
    
    UIButton *button = [[UIButton alloc]init];
    [self.view addSubview:button];
    button.frame = CGRectMake(0, 0, 100, 40);
    button.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
    button.backgroundColor = [UIColor redColor];
    [button setTitle:@"下一页" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(nextPage) forControlEvents:UIControlEventTouchUpInside];
}
- (void)nextPage{
    ThirdViewController *secondVc = [[ThirdViewController alloc]init];
    [self.navigationController pushViewController:secondVc animated:YES];
}

//方法一
#pragma mark- LPNavigationControllerDelegate
-(BOOL)controllerWillPopHandler{
    
    NSLog(@"我拦截到了方法1");
    //相关逻辑处理
    
    return YES;
}

//方法二
#pragma mark- BackButtonHandlerProtocol
-(BOOL)navigationShouldPopOnBackButton{
     NSLog(@"我拦截到了分类方法2");
    //相关逻辑处理
    
    return YES;
}
@end
