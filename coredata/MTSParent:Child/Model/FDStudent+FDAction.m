//
//  FDStudent+FDAction.m
//  coredata
//
//  Created by asus on 16/7/16.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDStudent+FDAction.h"

@implementation FDStudent (FDAction)


/**
 *  表名称,需要和normaldata中相对应
 */
+(NSString *)entityName
{
    return @"Student";
}

+(FDStudent *)insertNewObjectInManagedObjectContext:(NSManagedObjectContext *)context
{//insert方法，系统默认会自动在内部开启一个后台线程来执行耗时的插入操作，所以插入的顺序是不确定的，所以查询的时候要排序
    return [NSEntityDescription insertNewObjectForEntityForName:[self entityName] inManagedObjectContext:context];
}

+(NSEntityDescription *)entityInManagedObjectContext:(NSManagedObjectContext *)context
{
    return [NSEntityDescription entityForName:[self entityName] inManagedObjectContext:context];
}

+(NSUInteger)countWithContext:(NSManagedObjectContext *)context
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [self entityInManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    return [context countForFetchRequest:fetchRequest error:nil];
}


@end
