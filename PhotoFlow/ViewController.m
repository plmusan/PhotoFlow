//
//  ViewController.m
//  PhotoFlow
//
//  Created by x.wang on 15/10/23.
//  Copyright (c) 2015年 x.wang. All rights reserved.
//

#import "ViewController.h"
#import "PFViewController.h"

@interface ViewController () <PFViewControllerDelegate>
@property (nonatomic, weak) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) PFViewController *controller;
@property (nonatomic) NSInteger showingIndex;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSMutableArray *datasource = [NSMutableArray array];
    PFViewController *controller = [PFViewController defaultController];
    for (char i = 'a'; i < 't'; i ++) {
        NSString *name = [NSString stringWithFormat:@"%c.png", i];
        UIImage *image = [UIImage imageNamed:name];
        [datasource addObject:image];
    }
    controller.datasource = datasource;
    controller.delegate = self;
    self.controller = controller;
}
- (IBAction)btnPressed:(id)sender {
    [self.controller showPhotoFlowViewInViewController:self viewType:PFViewTypeBottom];
    [self.controller scrollToItemAtIndex:self.showingIndex animated:YES];
    
}

- (void)photoFlowView:(PFViewController *)controller rightButtonPressed:(UIButton *)rightButton {
    if (controller.viewType == PFViewTypeBottom) {
        [controller changeViewType:PFViewTypeFullScreen animated:YES];
    } else {
        [controller changeViewType:PFViewTypeBottom animated:YES];
    }
}

- (void)photoFlowView:(PFViewController *)controller didSelectedItemAtIndex:(NSInteger)index {
    self.showingIndex = index;
    self.imageView.image = controller.datasource[index];
    [controller dismissPhotoFlowView];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = touches.anyObject;
    CGPoint location = [touch locationInView:self.view];
    CGFloat y = self.view.frame.size.height - self.controller.view.frame.size.height;
    if (location.y < y) {
        [self.controller dismissPhotoFlowView];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
