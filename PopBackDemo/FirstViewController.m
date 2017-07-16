//
//  FirstViewController.m
//  PopInterceptDemo
//

#import "FirstViewController.h"
#import "SecondViewController.h"
@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"First";
    
    UIButton *button = [[UIButton alloc]init];
    [self.view addSubview:button];
    button.frame = CGRectMake(0, 0, 100, 40);
    button.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
    button.backgroundColor = [UIColor redColor];
    [button setTitle:@"下一页" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(nextPage) forControlEvents:UIControlEventTouchUpInside];
}

- (void)nextPage{
    SecondViewController *secondVc = [[SecondViewController alloc]init];
    [self.navigationController pushViewController:secondVc animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
