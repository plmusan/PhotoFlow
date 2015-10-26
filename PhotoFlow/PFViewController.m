//
//  PFViewController.m
//  PhotoFlow
//
//  Created by x.wang on 15/10/23.
//  Copyright (c) 2015年 x.wang. All rights reserved.
//

#import "PFViewController.h"
#import "PFCollectionViewCell.h"

const CGFloat PFViewBottonTypeHeight = 180.0;
const NSTimeInterval AnimationDuration = 0.5;

@interface PFViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headerViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *footerViewHeight;

@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UIView *footerView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation PFViewController

+ (instancetype)defaultController {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"PFView" bundle:nil];
    PFViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"PFViewController"];
    return controller;
}

#pragma mark Interface Method

- (void)scrollToItemAtIndex:(NSInteger)index animated:(BOOL)animated {
    if (self.viewType == PFViewTypeBottom) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
        [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    }
}

- (void)showPhotoFlowViewInViewController:(UIViewController *)controller viewType:(PFViewType)viewType {
    [controller addChildViewController:self];
    [controller.view addSubview:self.view];
    [self changeViewType:viewType animated:NO];
}

- (void)dismissPhotoFlowView {
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}

- (void)changeViewType:(PFViewType)viewType animated:(BOOL)animated {
    if (! self.parentViewController) return;
    self.viewType = viewType;
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    BOOL isBottomType = viewType == PFViewTypeBottom;
    self.collectionView.alwaysBounceHorizontal = isBottomType;
    self.collectionView.alwaysBounceVertical = ! isBottomType;
    layout.scrollDirection = isBottomType ? UICollectionViewScrollDirectionHorizontal : UICollectionViewScrollDirectionVertical;
    if (animated) {
        [UIView animateWithDuration:AnimationDuration animations:^{
            [self showPhotoFlowViewWithViewType:viewType];
        } completion:^(BOOL finished) {
            [self.collectionView reloadData];
        }];
    } else {
        [self showPhotoFlowViewWithViewType:viewType];
        [self.collectionView reloadData];
    }
}

- (void)showPhotoFlowViewWithViewType:(PFViewType)viewType {
    if (viewType == PFViewTypeBottom) {
        CGFloat x = self.parentViewController.view.frame.origin.x;
        CGFloat y = self.parentViewController.view.frame.size.height - PFViewBottonTypeHeight;
        CGFloat width = self.parentViewController.view.frame.size.width;
        self.view.frame = CGRectMake(x, y, width, PFViewBottonTypeHeight);
    } else if (viewType == PFViewTypeFullScreen) {
        self.view.frame = self.parentViewController.view.frame;
    }
    [self.view layoutIfNeeded];
}

- (void)setConstumHeaderView:(UIView *)constumHeaderView {
    CGFloat width = self.headerView.frame.size.width;
    CGFloat height = constumHeaderView.frame.size.height;
    
    self.headerViewHeight.constant = height;
    [self.headerView addSubview:constumHeaderView];
    constumHeaderView.center = CGPointMake(width / 2, height / 2);
    [self.view layoutIfNeeded];
}

- (void)setConstumFooterView:(UIView *)constumFooterView {
    CGFloat width = self.footerView.frame.size.width;
    CGFloat height = constumFooterView.frame.size.height;
    
    self.footerViewHeight.constant = height;
    [self.footerView addSubview:constumFooterView];
    constumFooterView.center = CGPointMake(width / 2, height / 2);
    [self.view layoutIfNeeded];
}

#pragma mark Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.footerViewHeight.constant = 0.0;
}
- (IBAction)rightButtonPressed:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(photoFlowView:rightButtonPressed:)]) {
        [self.delegate photoFlowView:self rightButtonPressed:sender];
    }
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(photoFlowView:shouldSelecteItemAtIndex:)]) {
        return [self.delegate photoFlowView:self shouldSelecteItemAtIndex:indexPath.row];
    }
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(photoFlowView:didSelectedItemAtIndex:)]) {
        [self.delegate photoFlowView:self didSelectedItemAtIndex:indexPath.row];
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.datasource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *const identifier = @"PFCollectionViewCell";
    PFCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.coverImageView.image = self.datasource[indexPath.row];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(110, 110);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10.0, 10.0, 10.0, 10.0);
}

@end
