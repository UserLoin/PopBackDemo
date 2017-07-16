//
//  AppDelegate.m


#import "AppDelegate.h"
#import "FirstViewController.h"
#import "LPNavigationController.h"
typedef NS_ENUM(NSInteger,BackButtonHandlerType){
    BackButtonHandlerOne = 0,
    BackButtonHandlerTwo,

};
@interface AppDelegate ()
@property(nonatomic,assign)BackButtonHandlerType type;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    UIWindow *window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window = window;
    
    /* 注意
     测试方法一时，方法二也会打印
     推荐使用、方法二分类的方法
     */
    
    //更改self.type的类型、改变方法
    self.type = BackButtonHandlerOne;
    
    switch (self.type) {
        case BackButtonHandlerOne://方法一
        {
            
            LPNavigationController *naVc = [[LPNavigationController alloc]initWithRootViewController:[[FirstViewController alloc]init]];
            
            self.window.rootViewController = naVc;
        }
            break;
        case BackButtonHandlerTwo://方法二
        {
            UINavigationController *naVc = [[UINavigationController alloc]initWithRootViewController:[[FirstViewController alloc]init]];
            
            self.window.rootViewController = naVc;
        }
            break;
            
        default:
            break;
    }
    
    return YES;
}

@end
