//
//  FDNormalTableViewController+FDCoredata.h
//  coredata
//
//  Created by asus on 16/7/15.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import "FDNormalTableViewController.h"

@interface FDNormalTableViewController (FDCoredata)<NSFetchedResultsControllerDelegate>

/**
 *  结果集
 */
@property (nonatomic, strong) NSFetchedResultsController *fetchResultsController;

@end
