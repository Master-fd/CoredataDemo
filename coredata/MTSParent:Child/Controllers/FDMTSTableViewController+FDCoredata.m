//
//  FDMTSTableViewController+FDCoredata.m
//  coredata
//
//  Created by asus on 16/7/14.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDMTSTableViewController+FDCoredata.h"
#import "FDDepartment+FDActive.h"
#import "FDDepartment.h"
#import "FDStore.h"



@implementation FDMTSTableViewController (FDCoredata)


#pragma mark - 实现代理
- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath
{
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            
        case NSFetchedResultsChangeMove:
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            
        case NSFetchedResultsChangeUpdate:
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            
        default:
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id<NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            
        default:
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView endUpdates];
}

/**
 *  数据结果器懒加载
 */
- (NSFetchedResultsController *)fetchResultsController
{
    if (_fetchResultsController) {
        return _fetchResultsController;
    }
    //实体描述，相对于表来说，也即是字段
    NSEntityDescription *entity = [FDDepartment entityInManagedObjectContext:self.store.manageObjectContext];
    //设置请求器
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:entity];
    // 设置过滤器
    //        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"<#format string#>", <#arguments#>];
    //        [fetchRequest setPredicate:predicate];
    // 排序，排序是必须有的，否则会报错
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name"                                                                      ascending:YES];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor, nil]];
    _fetchResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.store.manageObjectContext sectionNameKeyPath:nil cacheName:nil];
    _fetchResultsController.delegate = self;
    if (![_fetchResultsController performFetch:nil]) {
        FDLog(@"查询错误");
    }
    
    return _fetchResultsController;
}



@end



