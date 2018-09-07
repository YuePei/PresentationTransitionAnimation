//
//  ViewController.m
//  PresentAnimation
//
//  Created by Peyton on 2018/8/9.
//  Copyright © 2018年 Peyton. All rights reserved.
//

#import "ViewController.h"
#import "DetailVC.h"
#import "CollectionViewCell.h"
#import "NavigationAnimation.h"


@interface ViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UINavigationControllerDelegate>

@property (nonatomic, strong)NavigationAnimation *presentAnimation;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (@available(iOS 11, *)) {
        self.collectionView.contentInsetAdjustmentBehavior = NO;
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
}

- (void)viewDidAppear:(BOOL)animated {
    self.navigationController.delegate = self;
}

#pragma mark UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell1" forIndexPath:indexPath];
    if (!cell) {
        cell = [[CollectionViewCell alloc]init];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    DetailVC *vc = [sb instantiateViewControllerWithIdentifier:@"detailVC"];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark UINavigationControllerDelegate
- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC {
    
    if ([toVC isKindOfClass:[DetailVC class]]) {
        _presentAnimation = [[NavigationAnimation alloc]init];
        return self.presentAnimation;
    }else {
        return nil;
    }
}


@end
