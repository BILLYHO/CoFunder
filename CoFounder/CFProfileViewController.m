//
//  CFProfileViewController.m
//  CoFounder
//
//  Created by BILLY HO on 3/2/14.
//  Copyright (c) 2014 BILLY HO. All rights reserved.
//

#import "CFProfileViewController.h"
#import "CFLoginViewController.h"
#import "CFInsertViewController.h"

@interface CFProfileViewController ()

@end

@implementation CFProfileViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
		self.title = @"Profile";
		self.navigationController.navigationItem.leftBarButtonItem = nil;
		self.navigationItem.hidesBackButton = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	
	NSUserDefaults *dataBase = [NSUserDefaults standardUserDefaults];
	_profileLabel.text = [NSString stringWithFormat:@"Hello! %@!", [dataBase objectForKey:@"currentUser"]];
	_nameLabel.text = [dataBase objectForKey:@"currentUser"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)logout:(id)sender
{
	NSUserDefaults *dataBase = [NSUserDefaults standardUserDefaults];
	[dataBase setObject:@"" forKey:@"currentUser"];
	[dataBase synchronize];
	
	CFLoginViewController *loginView = [[CFLoginViewController alloc]initWithNibName:@"CFLoginViewController" bundle:nil];
	[self.navigationController pushViewController:loginView animated:YES];

}
- (IBAction)didInsertButtonClicked:(id)sender
{
	NSLog(@"click");
	CFInsertViewController *insertView = [[CFInsertViewController alloc]initWithNibName:@"CFInsertViewController" bundle:nil];
	[self.navigationController pushViewController:insertView animated:YES];
}
@end
