//
//  DetailVC.m
//  PresentAnimation
//
//  Created by Peyton on 2018/8/9.
//  Copyright © 2018年 Peyton. All rights reserved.
//

#import "DetailVC.h"
#import "NavigationPopAnimation.h"
#import "ViewController.h"
#import "NavigationAnimation.h"


#define screen_width [UIScreen mainScreen].bounds.size.width
#define screen_height [UIScreen mainScreen].bounds.size.height

@interface DetailVC ()<UINavigationControllerDelegate>

@property (nonatomic, strong)NavigationPopAnimation *popAnimation;

@property (nonatomic, strong)UIPercentDrivenInteractiveTransition *percentTransition;
@end

@implementation DetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.delegate = self;
    
    UIScreenEdgePanGestureRecognizer *panGesture = [[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self action:@selector(sweepLeftEdge:)];
    panGesture.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:panGesture];
    
}

- (void)sweepLeftEdge:(UIScreenEdgePanGestureRecognizer *)panGesture {
    CGPoint lastPoint = [panGesture translationInView:self.view];
    CGFloat progress = lastPoint.x / screen_width;
    progress = fminf(1.0, fmaxf(0.0, progress));
    
    switch (panGesture.state) {
        case UIGestureRecognizerStateBegan: {
            self.percentTransition = [[UIPercentDrivenInteractiveTransition alloc]init];
            [self.navigationController popViewControllerAnimated:YES];
        }
            break;
        case UIGestureRecognizerStateChanged: {
            //手指移动
            [self.percentTransition updateInteractiveTransition:progress];
        }
            break;
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled: {
            if (progress  > 0.4) {
                [self.percentTransition finishInteractiveTransition];
            }else {
                [self.percentTransition cancelInteractiveTransition];
            }
            //如果不加这一句, 当手势取消的时候, 会导致左上角返回按钮点击出错
            self.percentTransition = nil;
        }
            break;
        default:
            break;
    }
}

- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC {
    if ([toVC isKindOfClass:[ViewController class]]) {
        _popAnimation = [NavigationPopAnimation new];
        
        return self.popAnimation;
    }else {
        return nil;
    }
}

- (nullable id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                                   interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) 
animationController {
    if ([animationController isKindOfClass:[NavigationPopAnimation class]]) {
        return self.percentTransition;
    }else {
        return nil;
    }
}




@end
