//
//  NavigationPopAnimation.m
//  PresentAnimation
//
//  Created by Peyton on 2018/8/9.
//  Copyright © 2018年 Peyton. All rights reserved.
//

#import "NavigationPopAnimation.h"
#import "ViewController.h"
#import "DetailVC.h"

#define screen_width [UIScreen mainScreen].bounds.size.width
#define screen_height [UIScreen mainScreen].bounds.size.height

@implementation NavigationPopAnimation

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.5;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    DetailVC *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    ViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containView = [transitionContext containerView];
    

    [containView insertSubview:toVC.view belowSubview:fromVC.view];

    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        fromVC.view.alpha = 0;
    } completion:^(BOOL finished) {
        //如果是取消了, 则转场未完成, 反之则完成
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}


@end
