//
//  FDMTSTableViewController.m
//  coredata
//
//  Created by asus on 16/7/13.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDMTSTableViewController.h"
#import "FDMTSTableViewController+FDCoredata.h"
#import "FDStore.h"
#import "FDDepartment.h"
#import "FDDepartment+FDActive.h"
#import "FDStudentViewController.h"



@interface FDMTSTableViewController ()


@end

@implementation FDMTSTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //插入测试数据
    FDLog(@"coredata 多线程parent/child model测试");
    FDLog(@"多线程环境只能在多个context之间传递objectID,在这里传递DepartmentID，否则会错误");
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonItemStyleDone target:self action:@selector(addDepartment)];
    
    self.navigationItem.rightBarButtonItem = item;
    

}


/**
 *  添加一个department
 */
- (void)addDepartment
{

    FDDepartment *department = [FDDepartment insertNewObjectInManagedObjectContext:self.store.manageObjectContext];
    department.name = @"department";

}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    //保存
    FDLog(@"开始保存数据，耗时，保存到数据库，马上返回");
    [self.store.manageObjectContext performBlock:^{
        FDLog(@"department保存线程%@", [NSThread currentThread]);
        [self.store saveContext];
    }];
    
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return [[self.fetchResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchResultsController sections][section];
    
    return [sectionInfo numberOfObjects];
}

//显示department
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString * const cellid = @"cellid";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    
    FDDepartment *dataModel = [self.fetchResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = dataModel.name;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
        FDDepartment *department = (FDDepartment *)[self.fetchResultsController objectAtIndexPath:indexPath];
        
        FDStudentViewController *vc = [[FDStudentViewController alloc] init];
        vc.parentContext = self.store.manageObjectContext;
        vc.departmentID = department.objectID;
        
        [self.navigationController pushViewController:vc animated:YES];

    
}

- (FDStore *)store
{
    if (!_store) {
        _store = [[FDStore alloc] init];
    }
    return _store;
}




@end



