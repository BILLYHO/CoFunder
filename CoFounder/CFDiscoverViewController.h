//
//  CFDiscoverViewController.h
//  CoFounder
//
//  Created by BILLY HO on 3/2/14.
//  Copyright (c) 2014 BILLY HO. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "REMenu.h"
#import "AppMarco.h"

@interface CFDiscoverViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) REMenu *menu;

@property (strong, nonatomic) NSMutableArray *projectArr;

@end
