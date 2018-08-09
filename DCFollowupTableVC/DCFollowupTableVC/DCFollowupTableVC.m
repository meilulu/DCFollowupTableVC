//
//  DCFollowupTableVC.m
//  DevelopControls
//
//  Created by 树妖 on 2018/8/7.
//  Copyright © 2018年 树妖. All rights reserved.
//

#import "DCFollowupTableVC.h"
#import "Masonry.h"

@interface DCFollowupTableVC ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UIView *headerView;
@property (strong, nonatomic) UITableView *tableView;

@property (assign, nonatomic) CGFloat lastContentOffsetY;
@property (assign, nonatomic) CGFloat headerViewOriginCenterY;
@property (assign, nonatomic) CGFloat headerViewOriginCenterX;
@end

@implementation DCFollowupTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupViews];
}

- (void)setupViews {
    CGFloat width = self.view.bounds.size.width;
    
    self.headerView = [UIView new];
    self.headerView.backgroundColor = [UIColor redColor];
    self.headerView.frame = CGRectMake(0, 64, width, 200);
    [self.view addSubview:self.headerView];
    self.headerViewOriginCenterY = self.headerView.center.y;
    self.headerViewOriginCenterX = self.headerView.center.x;
    
    self.tableView = [UITableView new];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.headerView.mas_bottom);
    }];

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"标题：%ld",indexPath.row];
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat contentOffsetY = scrollView.contentOffset.y;
    if (contentOffsetY<=0) {
        /*表示已经滑动到顶部。但是scrollView会有回弹效果，避免回弹产生的contentOffsetY变化
        导致headerView抖动*/
        return;
    }
    if (contentOffsetY>=scrollView.contentSize.height - scrollView.frame.size.height) {
        /*表示已经滑动到底部。但是scrollView会有回弹效果，避免回弹产生的contentOffsetY变化
         导致headerView抖动*/
        return;
    }
    
    CGFloat offsetDistance = contentOffsetY - self.lastContentOffsetY;
    self.headerView.center = CGPointMake(self.headerViewOriginCenterX, self.headerView.center.y - offsetDistance);
    if (self.headerView.center.y >= self.headerViewOriginCenterY) {
        //headerView全部拉出
        self.headerView.center = CGPointMake(self.headerViewOriginCenterX, self.headerViewOriginCenterY);
    }
    if (self.headerView.center.y <= self.headerViewOriginCenterY - 200) {
        //headerView全部隐藏
        self.headerView.center = CGPointMake(self.headerViewOriginCenterX, self.headerViewOriginCenterY - 200);
    }

    
    self.lastContentOffsetY = contentOffsetY;
}

@end
