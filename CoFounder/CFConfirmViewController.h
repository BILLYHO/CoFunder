//
//  CFConfirmViewController.h
//  CoFounder
//
//  Created by BILLY HO on 3/17/14.
//  Copyright (c) 2014 BILLY HO. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface CFConfirmViewController : UIViewController<MBProgressHUDDelegate>

@property (strong, nonatomic) MBProgressHUD *HUD;
@property (strong, nonatomic) NSDictionary *contentDic;
@property (strong, nonatomic) IBOutlet UILabel *moneyLabel;
@property (strong, nonatomic) IBOutlet UILabel *contentLabel;

@end
