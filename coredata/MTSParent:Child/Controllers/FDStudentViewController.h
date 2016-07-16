//
//  FDStudentViewController.h
//  coredata
//
//  Created by asus on 16/7/16.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface FDStudentViewController : UITableViewController


@property (nonatomic, strong) NSManagedObjectID *departmentID;   //coredata会自动生成一个递增的id

@property (nonatomic, strong) NSManagedObjectContext *parentContext;   //夫context

@end
