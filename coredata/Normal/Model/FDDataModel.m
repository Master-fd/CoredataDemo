//
//  FDDataModel.m
//  coredata
//
//  Created by asus on 16/7/14.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDDataModel.h"
#import "FDDataModel+FDCoredataProperties.h"
#import "NSObject+FDCoredataHeader.h"


@implementation FDDataModel

/**
 *  表名称,需要和normaldata中相对应
 */
+(NSString *)entityName
{
    return @"Student";
}

+(FDDataModel *)insertNewObjectInManagedObjectContext:(NSManagedObjectContext *)context
{//insert方法，系统默认会自动在内部开启一个后台线程来执行耗时的插入操作，所以插入的顺序是不确定的，所以查询的时候要排序
    return [NSEntityDescription insertNewObjectForEntityForName:[self entityName] inManagedObjectContext:context];
}

+(NSEntityDescription *)entityInManagedObjectContext:(NSManagedObjectContext *)context
{
    return [NSEntityDescription entityForName:[self entityName] inManagedObjectContext:context];
}

+(NSUInteger)count
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [self entityInManagedObjectContext:self.manageObjectContext];
    [fetchRequest setEntity:entity];
    
    return [self.manageObjectContext countForFetchRequest:fetchRequest error:nil];
}


@end
