//
//  ViewController.m
//  DCFollowupTableVC
//
//  Created by 树妖 on 2018/8/9.
//  Copyright © 2018年 树妖. All rights reserved.
//

#import "ViewController.h"
#import "DCFollowupTableVC.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"点击" style:UIBarButtonItemStyleDone target:self action:@selector(doRightAction)];
}

- (void)doRightAction {
    DCFollowupTableVC *vc = [DCFollowupTableVC new];
    [self.navigationController pushViewController:vc animated:true];
}
@end
