//
//  PFViewController.h
//  PhotoFlow
//
//  Created by x.wang on 15/10/23.
//  Copyright (c) 2015年 x.wang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, PFViewType) {
    PFViewTypeBottom,
    PFViewTypeFullScreen,
};

@protocol PFViewControllerDelegate;
@interface PFViewController : UIViewController

+ (instancetype)defaultController;

@property (nonatomic, assign) PFViewType viewType;
// if [PFViewController parentViewController] is nil, nothing effect.
- (void)changeViewType:(PFViewType)viewType animated:(BOOL)animated;

@property (nonatomic, copy) NSArray *datasource;

@property (nonatomic, weak) id <PFViewControllerDelegate> delegate;

@property (nonatomic, strong) UIView *constumHeaderView; //default is nil
@property (nonatomic, strong) UIView *constumFooterView; // default is nil

- (void)showPhotoFlowViewInViewController:(UIViewController *)controller viewType:(PFViewType)viewType;
- (void)scrollToItemAtIndex:(NSInteger)index animated:(BOOL)animated; // only effect with PFViewTypeBottom

- (void)dismissPhotoFlowView;

@end


@protocol PFViewControllerDelegate <NSObject>

@optional

- (BOOL)photoFlowView:(PFViewController *)controller shouldSelecteItemAtIndex:(NSInteger)index;
- (void)photoFlowView:(PFViewController *)controller didSelectedItemAtIndex:(NSInteger)index;

- (void)photoFlowView:(PFViewController *)controller rightButtonPressed:(UIButton *)rightButton;

@end