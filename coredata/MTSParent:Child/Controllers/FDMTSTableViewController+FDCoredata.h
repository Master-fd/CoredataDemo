//
//  FDMTSTableViewController+FDCoredata.h
//  coredata
//
//  Created by asus on 16/7/14.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDMTSTableViewController.h"



@interface FDMTSTableViewController (FDCoredata)<NSFetchedResultsControllerDelegate>

/**
 *  结果集
 */
@property (nonatomic, strong) NSFetchedResultsController *fetchResultsController;


@end
