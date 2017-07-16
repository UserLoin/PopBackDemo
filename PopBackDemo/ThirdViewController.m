
//
//  ThirdViewController.m
//  PopInterceptDemo
//
//

#import "ThirdViewController.h"
#import "SecondViewController.h"
#import "LPNavigationController.h"
#import "UIViewController+BackButtonHandler.h"
@interface ThirdViewController ()<LPNavigationControllerDelegate>

@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"Third";
    
   
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
