//
//  CFActivityViewController.h
//  CoFounder
//
//  Created by BILLY HO on 3/2/14.
//  Copyright (c) 2014 BILLY HO. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CFActivityViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITableView *favTableView;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segment;


@property (strong, nonatomic) NSArray *investArr;
@property (strong, nonatomic) NSArray *favArr;
@property (strong, nonatomic) NSArray *record;


@end
