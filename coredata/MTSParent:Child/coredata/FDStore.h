//
//  FDStore.h
//  coredata
//
//  Created by asus on 16/7/16.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface FDStore : NSObject


/**
 *  上下文
 */
@property (nonatomic, strong) NSManagedObjectContext *manageObjectContext;

/**
 *  被管理的实体模型
 */
@property (nonatomic, strong) NSManagedObjectModel *manageObjectModel;

/**
 *  数据协调器，通过它才可以将上下文的数据和数据库交流
 */
@property (nonatomic, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;


/**
 *  保存数据
 */
- (void)saveContext;

/**
 *  数据库URL路径
 */
- (NSURL *)applicationDocumentsDirectory;


@end
