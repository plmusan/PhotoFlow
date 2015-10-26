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
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)btnPressed:(id)sender {
    NSMutableArray *datasource = [NSMutableArray array];
    PFViewController *controller = [PFViewController defaultController];
    for (char i = 'a'; i < 't'; i ++) {
        NSString *name = [NSString stringWithFormat:@"%c.png", i];
        UIImage *image = [UIImage imageNamed:name];
        [datasource addObject:image];
    }
    controller.datasource = datasource;
    controller.delegate = self;
    [controller showPhotoFlowViewInViewController:self viewType:PFViewTypeBottom];
}

- (void)photoFlowView:(PFViewController *)controller rightButtonPressed:(UIButton *)rightButton {
    if (controller.viewType == PFViewTypeBottom) {
        [controller changeViewType:PFViewTypeFullScreen animated:YES];
    } else {
        [controller changeViewType:PFViewTypeBottom animated:YES];
    }
}

- (void)photoFlowView:(PFViewController *)controller didSelectedItemAtIndex:(NSInteger)index {
    self.imageView.image = controller.datasource[index];
    [controller dismissPhotoFlowView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
