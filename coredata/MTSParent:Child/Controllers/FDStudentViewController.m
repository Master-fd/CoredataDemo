//
//  FDStudentViewController.m
//  coredata
//
//  Created by asus on 16/7/16.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDStudentViewController.h"
#import "FDDepartment.h"
#import "FDStudent.h"
#import "FDStudent+FDAction.h"




@interface FDStudentViewController ()


@property (nonatomic, strong) NSMutableArray *students;

@property (nonatomic, strong) FDDepartment *department;

@property (nonatomic, strong) NSManagedObjectContext *childContext;

@end




@implementation FDStudentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    FDLog(@"设置student");
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(saveContext)];
    
    self.navigationItem.rightBarButtonItem = item;
    
    //插入多个数据,并没有直接保存到数据库，只是缓存而已，不耗时
    [self addTestData:20000];
}


- (void)addTestData:(NSInteger )count
{

    FDLog(@"student开始插入数据，插入到缓存，插入操作不耗时");

    for (int i=0; i<count; i++) {
        @autoreleasepool {
            FDStudent *student = [FDStudent insertNewObjectInManagedObjectContext:self.childContext];
            
            student.name = [NSString stringWithFormat:@"student--%d", i];
            student.age = [NSNumber numberWithInt:i];
            student.department = self.department;  //这个操作会耗时大
            
        }
    }

    FDLog(@"student 插入数据完毕");
    [self.tableView reloadData];

}

- (void)saveContext
{
    FDLog(@"最近关于child contexts的争论很多，并不建议在多线程中使用它。如果在非主线程中创建了一个context作为main context的child context，在这些非主线程中执行保存操作还是会阻塞主线程。反过来，要是将main context设置为其他非主线程context的child context，其效果与传统的创建两个有依赖关系的contexts类似，还是需要手动的将其他线程的context变化和main context做合并。事实证明，除非有更好的选择，否则设置一个persistent store coordinator和两个独立的contexts才是对Core Data多线程操作的合理方式。");
    
    FDLog(@"开始保存数据，需要在异步线程操作，耗时");
    [self.childContext performBlock:^{
        
        FDLog(@"student保存线程%@", [NSThread currentThread]);
        FDLog(@"保存,不会直接保存，会提交到parentcontext中，当parentcontext保存之后才真正的写入到数据库");
        NSError *error = nil;
        if ([self.childContext hasChanges] && ![self.childContext save:&error]) {
            FDLog(@"%@", error);
        }
    }];
    
    FDLog(@"异步操作，即可返回");

}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self saveContext];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.students.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString * const reuse = @"reuseid";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuse];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuse];
    }
    
    
    FDStudent *student = self.students[indexPath.row];
    
    cell.textLabel.text = student.name;
    cell.detailTextLabel.text = [student.age stringValue];
    
    return cell;
}


/**
 *  懒加载
 */
- (NSManagedObjectContext *)childContext
{
    if (!_childContext) {
        _childContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
        [_childContext setParentContext:self.parentContext];
    }
    
    return _childContext;
}
- (FDDepartment *)department
{
    if (!_department) {
        _department = (FDDepartment *)[self.childContext objectWithID:self.departmentID];
    }
    return _department;
}
- (NSMutableArray *)students
{
    return [NSMutableArray arrayWithArray:[self.department.students allObjects]];
}

- (void)dealloc
{
    FDLog(@"student dealloc");
}

@end
