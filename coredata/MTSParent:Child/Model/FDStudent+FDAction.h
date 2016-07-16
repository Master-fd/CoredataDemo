//
//  FDStudent+FDAction.h
//  coredata
//
//  Created by asus on 16/7/16.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDStudent.h"

@interface FDStudent (FDAction)


/**
 *  表名称，需要和normalData相对应
 */
+(NSString *)entityName;

/**
 * 插入一行数据
 */
+(FDStudent *)insertNewObjectInManagedObjectContext:(NSManagedObjectContext *)context;

/**
 *  读取数据的描述
 */
+(NSEntityDescription *)entityInManagedObjectContext:(NSManagedObjectContext *)context;

/**
 *  查询总数
 */
+(NSUInteger)countWithContext:(NSManagedObjectContext *)context;


@end
