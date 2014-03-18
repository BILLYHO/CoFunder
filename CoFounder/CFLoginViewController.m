//
//  CFLoginViewController.m
//  CoFounder
//
//  Created by BILLY HO on 3/6/14.
//  Copyright (c) 2014 BILLY HO. All rights reserved.
//

#import "CFLoginViewController.h"
#import "CFProfileViewController.h"
#import "CFSignupViewController.h"
#import "AppMarco.h"

@interface CFLoginViewController ()

@end

@implementation CFLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
		self.title = @"登录";
		self.tabBarItem.title = @"Profile";
		self.tabBarItem.image = [UIImage imageNamed:@"profile"];
		self.navigationItem.hidesBackButton = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	NSUserDefaults *dataBase = [NSUserDefaults standardUserDefaults];
	if (![[dataBase objectForKey:@"currentUser"] isEqualToString:@""])
	{
		CFProfileViewController *profileView = [[CFProfileViewController alloc]initWithNibName:@"CFProfileViewController" bundle:nil];
		[self.navigationController pushViewController:profileView animated:YES];
	}
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginButtonClicked:(id)sender
{
	[self touchDownReturn:sender];
	
	_HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
	
	[self.navigationController.view addSubview:_HUD];
	_HUD.labelText = @"正在提交...";
	
	// Regiser for HUD callbacks so we can remove it from the window at the right time
	_HUD.delegate = self;
	
	// Show the HUD while the provided method executes in a new thread
	[_HUD showWhileExecuting:@selector(signUp) onTarget:self withObject:nil animated:YES];
	

}

- (void)signUp
{
	// Indeterminate mode
	sleep(2);
	
	NSError *error;
	NSString *urlString = [NSString stringWithFormat:@"%@/index.php/Index/login/password/%@/email/%@",serverUrl,  _passwordLabel.text, _emailLabel.text];
	NSURL *url = [NSURL URLWithString:urlString];
	NSURLRequest *request = [NSURLRequest requestWithURL:url];
	NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
	NSDictionary *resDic = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
	
	if ([[NSString stringWithFormat:@"%@",[resDic objectForKey:@"status"]] isEqualToString:@"0"])
	{
		_HUD.mode = MBProgressHUDModeCustomView;
		_HUD.labelText = [resDic objectForKey:@"response"];
		sleep(1);
	}
	else
	{
		_username = [resDic objectForKey:@"response"];
		_HUD.mode = MBProgressHUDModeCustomView;
		_HUD.labelText = @"登录成功!";
		sleep(1);
		[self push];
	}
}

#pragma mark MBProgressHUDDelegate methods

- (void)hudWasHidden:(MBProgressHUD *)hud
{
	// Remove HUD from screen when the HUD was hidded
	[_HUD removeFromSuperview];
	_HUD = nil;
}

- (IBAction)signupButtonClicked:(id)sender
{
	CFSignupViewController *signupView = [[CFSignupViewController alloc] initWithNibName:@"CFSignupViewController" bundle:nil];
	[self.navigationController pushViewController:signupView animated:YES];
}

- (void) push
{
	NSUserDefaults *dataBase = [NSUserDefaults standardUserDefaults];
	[dataBase setObject:_username forKey:@"currentUser"];
	[dataBase synchronize];
	
	CFProfileViewController *profileView = [[CFProfileViewController alloc]initWithNibName:@"CFProfileViewController" bundle:nil];
	[self.navigationController pushViewController:profileView animated:YES];
}

- (IBAction)touchDownReturn:(id)sender
{
	[self.emailLabel resignFirstResponder];
	[self.passwordLabel resignFirstResponder];
}

- (IBAction)keyboradReturn:(id)sender
{
	[self resignFirstResponder];
}
@end
