//
//  FDNormalTableViewController.m
//  coredata
//
//  Created by asus on 16/7/13.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDNormalTableViewController.h"
#import "FDDataModel.h"
#import "NSObject+FDCoredataHeader.h"
#import "FDDataModel+FDCoredataProperties.h"
#import "FDNormalTableViewController+FDCoredata.h"



@interface FDNormalTableViewController ()

@end

@implementation FDNormalTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    FDLog(@"coredata 普通模式测试");
    [self setTestData:9000];  //插入测试数据
}

/**
 *  测试数据
 */
- (void)setTestData:(NSInteger)count
{
    FDLog(@"开始插入数据，插入到缓存，不耗时");
    for (int i=0; i<count; i++) {
        @autoreleasepool {
            FDDataModel *model = [FDDataModel insertNewObjectInManagedObjectContext:self.manageObjectContext];
            model.iD = [NSNumber numberWithInt:i];
            model.age = [NSNumber numberWithInt:i+10];
            model.name = [NSString stringWithFormat:@"normalCoredata-%d", i];
            
        }
    }
    FDLog(@"开始保存数据，保存到数据库，耗时");
    [self.manageObjectContext saveContext];  //保存到数据库

    
    FDLog(@"保存数据完毕");
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [[self.fetchResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchResultsController sections][section];
    
    return [sectionInfo numberOfObjects];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString * const cellid = @"cellid";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellid];
    }
    
    FDDataModel *dataModel = [self.fetchResultsController objectAtIndexPath:indexPath];
    
    cell.textLabel.text = dataModel.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", dataModel.age];
    
    return cell;
}

@end
