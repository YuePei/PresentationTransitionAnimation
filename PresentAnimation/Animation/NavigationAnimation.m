//
//  NavigationAnimation.m
//  PresentAnimation
//
//  Created by Peyton on 2018/8/9.
//  Copyright © 2018年 Peyton. All rights reserved.
//

#import "NavigationAnimation.h"
#import "ViewController.h"
#import "DetailVC.h"
#import "CollectionViewCell.h"

@implementation NavigationAnimation

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.5;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    ViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    DetailVC *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = [transitionContext containerView];
    
    //1. 获取用户点击到的cell
    CollectionViewCell *cell = (CollectionViewCell *)[fromVC.collectionView cellForItemAtIndexPath:[fromVC.collectionView indexPathsForSelectedItems].firstObject];
    //2. 对点击的cell的imageView进行截图
    UIView *snapView = [cell.imageView snapshotViewAfterScreenUpdates:NO];
    //3. 让截图替代cell中原本的imageView的位置, 用以之后的动画
    CGRect snapViewRect = [fromVC.view convertRect:cell.imageView.frame fromView:cell.imageView.superview];
    [snapView setFrame:snapViewRect];
    //4. 隐藏原来的cell中的imageView
    cell.imageView.hidden = YES;
    
    //5. 设置目的控制器的透明度
    toVC.view.alpha = 0;
    toVC.iv.hidden = YES;
    [toVC.view layoutIfNeeded];
    CGRect detailLabelRect = toVC.detailLabel.frame;
    [toVC.detailLabel setFrame:CGRectMake(0, CGRectGetHeight([UIScreen mainScreen].bounds), CGRectGetWidth(detailLabelRect), CGRectGetHeight(detailLabelRect))];
    
    [containerView addSubview:toVC.view];
    [containerView addSubview:snapView];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        toVC.view.alpha = 1;
        CGRect rect = [containerView convertRect:toVC.iv.frame fromView:toVC.view];
        rect.origin = CGPointMake(0, 64);
        [snapView setFrame:rect];
        
        [toVC.detailLabel setFrame:CGRectMake(0, detailLabelRect.origin.y, CGRectGetWidth(toVC.detailLabel.frame), CGRectGetHeight(toVC.detailLabel.frame))];
    } completion:^(BOOL finished) {
        
        [transitionContext completeTransition:YES];
        cell.imageView.hidden = NO;
        toVC.iv.hidden = NO;
        snapView.hidden = YES;
    }];
}

@end
