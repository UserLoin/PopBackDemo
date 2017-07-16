//
//  LPNavigationController.h
//  PopInterceptDemo
//
//

#import <UIKit/UIKit.h>
@protocol LPNavigationControllerDelegate <NSObject>
@optional
- (BOOL)controllerWillPopHandler;
@end

@interface LPNavigationController : UINavigationController
@end
