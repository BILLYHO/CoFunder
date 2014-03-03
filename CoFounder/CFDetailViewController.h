//
//  CFDetailViewController.h
//  CoFounder
//
//  Created by BILLY HO on 3/2/14.
//  Copyright (c) 2014 BILLY HO. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CFDetailViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIImageView *topImageView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *moneyLabel;
@property (strong, nonatomic) IBOutlet UILabel *peopleLabel;
@property (strong, nonatomic) IBOutlet UILabel *progressLabel;
@property (strong, nonatomic) IBOutlet UIButton *descriptionButton;
@property (strong, nonatomic) IBOutlet UILabel *descriptionLabel;

@property (strong, nonatomic) NSArray *content;

@end
