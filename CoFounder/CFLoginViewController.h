//
//  CFLoginViewController.h
//  CoFounder
//
//  Created by BILLY HO on 3/6/14.
//  Copyright (c) 2014 BILLY HO. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface CFLoginViewController : UIViewController<MBProgressHUDDelegate>

@property (strong, nonatomic) MBProgressHUD *HUD;

@property (strong, nonatomic) IBOutlet UITextField *emailLabel;
@property (strong, nonatomic) IBOutlet UITextField *passwordLabel;
@property (strong, nonatomic) NSString *username;

- (IBAction)touchDownReturn:(id)sender;
- (IBAction)keyboradReturn:(id)sender;

@end
