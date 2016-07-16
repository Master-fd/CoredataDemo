//
//  FDDataModel.h
//  coredata
//
//  Created by asus on 16/7/14.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface FDDataModel : NSManagedObject

/**
 *  表名称，需要和normalData相对应
 */
+(NSString *)entityName;

/**
 * 插入一行数据
 */
+(FDDataModel *)insertNewObjectInManagedObjectContext:(NSManagedObjectContext *)context;

/**
 *  读取数据的描述
 */
+(NSEntityDescription *)entityInManagedObjectContext:(NSManagedObjectContext *)context;

/**
 *  查询总数
 */
+(NSUInteger)count;


@end
