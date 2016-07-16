//
//  NSObject+FDCoredataHeader.m
//  coredata
//
//  Created by asus on 16/7/13.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "NSObject+FDCoredataHeader.h"



static NSPersistentStoreCoordinator *__persistentStoreCoordinator;
static NSManagedObjectContext *__managedObjectContext;
static NSManagedObjectModel *__managedObjectModel;


@implementation NSObject (FDCoredataHeader)


/**
 *  懒加载被管理模型
 */
- (NSManagedObjectModel *)manageObjectModel
{
    if (!__managedObjectModel) {
        NSURL *url = [[NSBundle mainBundle] URLForResource:@"normalData" withExtension:@"momd"];
        __managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:url];
    }
    
    return __managedObjectModel;
}

/**
 *  懒加载协调器
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (!__persistentStoreCoordinator) {
        //连接被管理的数据模型
        __persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self manageObjectModel]];
        //连接对应的数据库
        NSURL *url = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Data.sqlite"];
        FDLog(@"数据库地址：%@", url);
        NSError *error=nil;
        if (![__persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:url options:nil error:&error]) {
             //连接数据库错误
            FDLog(@"加载协调器错误%@", error);
            abort();
        }
    }
    return __persistentStoreCoordinator;
}

/**
 *  懒加载上下文
 */
-(NSManagedObjectContext *)manageObjectContext
{

    if (!__managedObjectContext) {
        
        NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];

        if (!coordinator) {
            return nil;
        }  //连接协调器
        __managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        [__managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    
    return __managedObjectContext;
}

/**
 *  数据库URL路径
 */
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

/**
 *  保存数据
 */
- (void)saveContext
{
    
    NSManagedObjectContext *context = self.manageObjectContext;
    if (context) {
        
        NSError *error = nil;
        if ([context hasChanges] && ![context save:&error]) {
            NSLog(@"保存错误 %@ ", error);
        }
    }
}



@end
