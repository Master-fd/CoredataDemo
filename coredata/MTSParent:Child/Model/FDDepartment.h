//
//  FDDepartment.h
//  coredata
//
//  Created by asus on 16/7/16.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


//这些都是自动生成的
@class FDStudent;

@interface FDDepartment : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *students;  //和表student 的关联关系为many
@end

@interface FDDepartment (CoreDataGeneratedAccessors)

- (void)addStudentsObject:(FDStudent *)value;
- (void)removeStudentsObject:(FDStudent *)value;
- (void)addStudents:(NSSet *)values;
- (void)removeStudents:(NSSet *)values;

@end
