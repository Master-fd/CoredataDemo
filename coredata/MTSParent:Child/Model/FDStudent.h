//
//  FDStudent.h
//  coredata
//
//  Created by asus on 16/7/16.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


//这些都是自动生成
@class FDDepartment;

@interface FDStudent : NSManagedObject

@property (nonatomic, retain) NSNumber * age;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) FDDepartment *department;  //和表department关联关系为one

@end
