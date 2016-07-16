//
//  FDDepartment.h
//  coredata
//
//  Created by asus on 16/7/16.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class FDStudent;

@interface FDDepartment : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *students;
@end

@interface FDDepartment (CoreDataGeneratedAccessors)

- (void)addStudentsObject:(FDStudent *)value;
- (void)removeStudentsObject:(FDStudent *)value;
- (void)addStudents:(NSSet *)values;
- (void)removeStudents:(NSSet *)values;

@end
