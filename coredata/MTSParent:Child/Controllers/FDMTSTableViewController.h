//
//  FDMTSTableViewController.h
//  coredata
//
//  Created by asus on 16/7/13.
//  Copyright (c) 2016年 asus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@class FDStore;
@interface FDMTSTableViewController : UITableViewController{
    
    NSFetchedResultsController *_fetchResultsController;
}

@property (nonatomic, strong) FDStore *store;

@end
