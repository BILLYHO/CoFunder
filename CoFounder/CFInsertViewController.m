//
//  CFInsertViewController.m
//  CoFounder
//
//  Created by BILLY HO on 3/18/14.
//  Copyright (c) 2014 BILLY HO. All rights reserved.
//

#import "CFInsertViewController.h"

@interface CFInsertViewController ()

@end

@implementation CFInsertViewController

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
	//self.tabBarController.tabBar.hidden = YES;
	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"为了获取更好的使用体验,请使用电脑登录." delegate:self cancelButtonTitle:@"好的" otherButtonTitles: nil];
	[alert show];
	
	[_insertWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://zdtw.sysu.edu.cn/begin/index.php/Item/"]]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
	
}

@end
