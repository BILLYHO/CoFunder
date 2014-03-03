//
//  CFDiscoverCell.h
//  CoFounder
//
//  Created by BILLY HO on 3/3/14.
//  Copyright (c) 2014 BILLY HO. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CFDiscoverCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *pictureView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UIProgressView *progressBar;
@property (strong, nonatomic) IBOutlet UILabel *moneyLabel;
@property (strong, nonatomic) IBOutlet UILabel *peopleLabel;
@property (strong, nonatomic) IBOutlet UILabel *progressLabel;

@end
