//
//  ViewController.m
//  字体
//
//  Created by ww on 2018/8/29.
//  Copyright © 2018年 zww. All rights reserved.
//

#import "ViewController.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

#define IS_IPAD ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) && (SCREEN_WIDTH > 760 )

#define SCALE_FONT (IS_IPAD ? (15.537/12.0):((SCREEN_WIDTH == 320) ? 1 : ((SCREEN_WIDTH == 375 )? (14.077/12.0) : (15.537/12.0))))

//let  IS_IPAD = UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad && (screen_width > 760 )
//
//let SCALE_FONT = IS_IPAD ?  (15.537/12.0) : ((screen_width == 320) ? 1 : ((screen_width == 375) ? (14.077/12.0) : (15.537/12.0)))
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *dataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.dataSource = [NSMutableArray array];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self getFontNames];
}

- (void)getFontNames {

    NSArray *familyNames = [UIFont familyNames];
    
    for (NSString *familyName in familyNames) {
//        printf("familyNames = %s\n",[familyName UTF8String]);
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
//        [self.dataSource addObject:familyName];
        [dic setObject:familyName forKey:@"section"];
        
        NSArray *fontNames = [UIFont fontNamesForFamilyName:familyName];
        NSMutableArray *aa = [NSMutableArray array];
        for (NSString *fontName in fontNames) {
            [aa addObject:fontName];
//            printf("\tfontName = %s\n",[fontName UTF8String]);
        }
        [dic setObject:aa forKey:@"sub"];
        [self.dataSource addObject:dic];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    NSDictionary *dict = self.dataSource[indexPath.section];
    
    cell.textLabel.text = dict[@"sub"][indexPath.row];
    cell.textLabel.font = [UIFont fontWithName:cell.textLabel.text size:15*SCALE_FONT];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return ((NSMutableArray *)self.dataSource[section][@"sub"]).count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSource.count;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 30)];
     NSDictionary *dict = self.dataSource[section];
    label.backgroundColor = [UIColor grayColor];
    label.text = dict[@"section"];
    return label;
}


@end
