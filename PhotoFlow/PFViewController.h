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
@property (nonatomic, copy) NSArray *datasource;

@property (nonatomic, weak) id <PFViewControllerDelegate> delegate;

@property (nonatomic, strong) UIView *constumHeaderView; //default is nil
@property (nonatomic, strong) UIView *constumFooterView; // default is nil

- (void)showPhotoFlowViewAtIndex:(NSInteger)index inViewController:(UIViewController *)controller;
- (void)dismissPhotoFlowView;

@end


@protocol PFViewControllerDelegate <NSObject>

@optional
- (BOOL)photoFlowView:(PFViewController *)controller shouldSelecteItemAtIndex:(NSInteger)index;
- (void)photoFlowView:(PFViewController *)controller didSelectedItemAtIndex:(NSInteger)index;

@end