# PopBackDemo
iOS-截获导航控制器系统返回按钮的点击pop及右滑pop事件的两种方法


##方法一：给UIViewController添加分类（推荐使用，已测试）

```
#import <UIKit/UIKit.h>
@protocol BackButtonHandlerProtocol <NSObject>
@optional
// Override this method in UIViewController derived class to handle 'Back' button click
- (BOOL)navigationShouldPopOnBackButton;
@end

@interface UIViewController (BackButtonHandler) <BackButtonHandlerProtocol>
@end
```

```
#import "UIViewController+BackButtonHandler.h"
#import <objc/runtime.h>

@implementation UIViewController (BackButtonHandler)

@end

static NSString *const kOriginDelegate = @"kOriginDelegate";

@implementation UINavigationController (ShouldPopOnBackButton)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        SEL originSelector = @selector(viewDidLoad);
        SEL swizzledSelector = @selector(new_viewDidLoad);
        
        Method originMethod = class_getInstanceMethod(class, originSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        BOOL didAddMethod = class_addMethod(class,
                                            originSelector,
                                            method_getImplementation(swizzledMethod),
                                            method_getTypeEncoding(swizzledMethod));
        if (didAddMethod) {
            class_replaceMethod(class,
                                swizzledSelector,
                                method_getImplementation(originMethod),
                                method_getTypeEncoding(originMethod));
        } else {
            method_exchangeImplementations(originMethod, swizzledMethod);
        }
    });
}

- (void)new_viewDidLoad
{
    [self new_viewDidLoad];
    
    objc_setAssociatedObject(self, [kOriginDelegate UTF8String], self.interactivePopGestureRecognizer.delegate, OBJC_ASSOCIATION_ASSIGN);
    self.interactivePopGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)self;
}

#pragma mark - 按钮

- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item {
    
	if([self.viewControllers count] < [navigationBar.items count]) {
		return YES;
	}

	BOOL shouldPop = YES;
	UIViewController* vc = [self topViewController];
	if([vc respondsToSelector:@selector(navigationShouldPopOnBackButton)]) {
		shouldPop = [vc navigationShouldPopOnBackButton];
	}

	if(shouldPop) {
		dispatch_async(dispatch_get_main_queue(), ^{
			[self popViewControllerAnimated:YES];
		});
	} else {
		for(UIView *subview in [navigationBar subviews]) {
			if(0. < subview.alpha && subview.alpha < 1.) {
				[UIView animateWithDuration:.25 animations:^{
					subview.alpha = 1.;
				}];
			}
		}
	}
	return NO;
}

#pragma mark - 手势

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer == self.interactivePopGestureRecognizer) {
        UIViewController *vc = [self topViewController];
        if([vc respondsToSelector:@selector(navigationShouldPopOnBackButton)]) {
            return [vc navigationShouldPopOnBackButton];
        }
        id<UIGestureRecognizerDelegate> originDelegate = objc_getAssociatedObject(self, [kOriginDelegate UTF8String]);
        return [originDelegate gestureRecognizerShouldBegin:gestureRecognizer];
    }
    return YES;
}
@end
```
使用方法：
```
在需要拦截pop方法的类里面写
#pragma mark- BackButtonHandlerProtocol
-(BOOL)navigationShouldPopOnBackButton{
     NSLog(@"我拦截到了分类方法2");
    //相关逻辑处理
    
    return YES;
}
```

##方法二：继承UINavigationController添加协议(不推荐使用)
```
#import <UIKit/UIKit.h>
@protocol LPNavigationControllerDelegate <NSObject>
@optional
- (BOOL)controllerWillPopHandler;
@end

@interface LPNavigationController : UINavigationController
@end
```
```
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
```
使用方法：
```
在需要拦截pop方法的类里面写
添加代理 <LPNavigationControllerDelegate>
#pragma mark- LPNavigationControllerDelegate
-(BOOL)controllerWillPopHandler{
    
    NSLog(@"我拦截到了方法1");
    //相关逻辑处理
    
    return YES;
}
```
[简书地址](http://www.jianshu.com/p/ec790770d1fb)

