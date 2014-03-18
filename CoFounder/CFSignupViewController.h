//
//  CFSignupViewController.h
//  CoFounder
//
//  Created by BILLY HO on 3/6/14.
//  Copyright (c) 2014 BILLY HO. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface CFSignupViewController : UIViewController<MBProgressHUDDelegate>

@property (strong, nonatomic) MBProgressHUD *HUD;
@property (strong, nonatomic) IBOutlet UITextField *userNameLabel;
@property (strong, nonatomic) IBOutlet UITextField *emailLabel;
@property (strong, nonatomic) IBOutlet UITextField *passwordLabel;


- (IBAction)returnKeyboard:(id)sender;
- (IBAction)touchDownReturn:(id)sender;


@end
