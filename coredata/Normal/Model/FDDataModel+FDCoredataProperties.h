//
//  FDDataModel+FDCoredataProperties.h
//  coredata
//
//  Created by asus on 16/7/13.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDDataModel.h"

NS_ASSUME_NONNULL_BEGIN
@interface FDDataModel (FDCoredataProperties)


/**
 *  数据库一条数据，具体的每个字段，需要新建一个momd文件相互配合
 */
@property (nonatomic, retain) NSNumber * iD;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * age;

@end
NS_ASSUME_NONNULL_END