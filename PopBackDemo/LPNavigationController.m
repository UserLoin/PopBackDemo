//
//  LPNavigationController.m
//  PopInterceptDemo
//

#import "LPNavigationController.h"

@interface UINavigationController (UINavigationControllerNeedshouldPopItem)
- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item;
@end
@implementation UINavigationController(UINavigationControllerNeedshouldPopItem)

@end
// 以上几行就是使用Category使UINavigationController将其实现的navigationBar:shouldPopItem:暴露出来，
// 让我们定制的子类可以调用


@interface LPNavigationController ()<UINavigationBarDelegate>

@end

@implementation LPNavigationController

- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item
{
    UIViewController *vc = self.topViewController;
    if ([vc respondsToSelector:@selector(controllerWillPopHandler)])
    {
        if ([vc performSelector:@selector(controllerWillPopHandler)])
        {
            return [super navigationBar:navigationBar shouldPopItem:item];
        }
        else
        {
            return NO;
        }
    }
    else
    {
        return [super navigationBar:navigationBar shouldPopItem:item];
    }
}


@end
