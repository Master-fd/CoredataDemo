//
//  FDDepartment+FDActive.h
//  coredata
//
//  Created by asus on 16/7/16.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDDepartment.h"

@interface FDDepartment (FDActive)

/**
 *  表名称，需要和normalData相对应
 */
+(NSString *)entityName;

/**
 * 插入一行数据
 */
+(FDDepartment *)insertNewObjectInManagedObjectContext:(NSManagedObjectContext *)context;

/**
 *  读取数据的描述
 */
+(NSEntityDescription *)entityInManagedObjectContext:(NSManagedObjectContext *)context;

/**
 *  查询总数
 */
+(NSUInteger)countWithContext:(NSManagedObjectContext *)context;

@end
