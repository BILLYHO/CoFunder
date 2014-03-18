//
//  CFConfirmViewController.m
//  CoFounder
//
//  Created by BILLY HO on 3/17/14.
//  Copyright (c) 2014 BILLY HO. All rights reserved.
//

#import "CFConfirmViewController.h"


@interface CFConfirmViewController ()

@end

@implementation CFConfirmViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	_moneyLabel.text = [NSString stringWithFormat:@"¥ %@", [_contentDic objectForKey:@"item_money"]];
	_contentLabel.text = [_contentDic objectForKey:@"item_return"];
	for(int i=0; i<9; i++)
		_contentLabel.text = [_contentLabel.text stringByAppendingString:@"\n "];
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)confirmButtonClicked:(id)sender
{
	_HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
	
	[self.navigationController.view addSubview:_HUD];
	_HUD.labelText = @"正在处理...";
	
	// Regiser for HUD callbacks so we can remove it from the window at the right time
	_HUD.delegate = self;
	
	// Show the HUD while the provided method executes in a new thread
	[_HUD showWhileExecuting:@selector(confirm) onTarget:self withObject:nil animated:YES];
	
}

- (void)confirm
{
	// Indeterminate mode
	sleep(2);
	

	_HUD.mode = MBProgressHUDModeCustomView;
	_HUD.labelText = @"支付成功!";
	sleep(1);
	
	[self.navigationController popToRootViewControllerAnimated:YES];
	self.navigationController.navigationBarHidden = NO;
	self.tabBarController.tabBar.hidden = NO;
}

#pragma mark MBProgressHUDDelegate methods

- (void)hudWasHidden:(MBProgressHUD *)hud
{
	// Remove HUD from screen when the HUD was hidded
	[_HUD removeFromSuperview];
	_HUD = nil;
}

- (IBAction)didClickBackButton:(id)sender
{
	[self.navigationController popViewControllerAnimated:YES];
}




@end
