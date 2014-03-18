//
//  CFActivityViewController.m
//  CoFounder
//
//  Created by BILLY HO on 3/2/14.
//  Copyright (c) 2014 BILLY HO. All rights reserved.
//

#import "CFActivityViewController.h"
#import "CFDetailViewController.h"
#import "CFFavouriteCell.h"
#import "AppMarco.h"

@interface CFActivityViewController ()

@end

@implementation CFActivityViewController

static NSString *favouriteCell = @"favouriteCell";

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
		self.title = @"Activity";
		self.tabBarItem.image = [UIImage imageNamed:@"activity"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	
	NSUserDefaults *dataBase = [NSUserDefaults standardUserDefaults];
	if ([[dataBase objectForKey:@"currentUser"] isEqualToString:@""])
	{
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"请先登录" delegate:self cancelButtonTitle:@"ok" otherButtonTitles: nil];
		[alert show];
	}
	
	[self.favTableView registerNib:[UINib nibWithNibName:@"CFFavouriteCell" bundle:nil] forCellReuseIdentifier:favouriteCell];
	
		
	[self loadInvest];
	[self loadFav];

	_record = _investArr;
}

- (void)loadInvest
{
	NSUserDefaults *dataBase = [NSUserDefaults standardUserDefaults];
	NSError *error1;
	NSString *urlString1 = [NSString stringWithFormat:@"%@/index.php/Index/getInvestmentbyUsername/username/%@",serverUrl, [dataBase objectForKey:@"currentUser"]];
	NSURL *url1 = [NSURL URLWithString:urlString1];
	NSURLRequest *request1 = [NSURLRequest requestWithURL:url1];
	NSData *response1 = [NSURLConnection sendSynchronousRequest:request1 returningResponse:nil error:nil];
	_investArr = [NSJSONSerialization JSONObjectWithData:response1 options:NSJSONReadingMutableLeaves error:&error1];
}

- (void)loadFav
{
	NSUserDefaults *dataBase = [NSUserDefaults standardUserDefaults];
	NSError *error2;
	NSString *urlString2 = [NSString stringWithFormat:@"%@/index.php/Index/getFollowingbyUsername/username/%@",serverUrl, [dataBase objectForKey:@"currentUser"]];
	NSURL *url2 = [NSURL URLWithString:urlString2];
	NSURLRequest *request2 = [NSURLRequest requestWithURL:url2];
	NSData *response2 = [NSURLConnection sendSynchronousRequest:request2 returningResponse:nil error:nil];
	_favArr = [NSJSONSerialization JSONObjectWithData:response2 options:NSJSONReadingMutableLeaves error:&error2];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	if ([_segment selectedSegmentIndex] == 0)
	{
		return [_investArr count]-1;
	}
	else
	{
		return [_favArr count];
	}
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	
    CFFavouriteCell *cell = [tableView dequeueReusableCellWithIdentifier:favouriteCell];
    
	NSDictionary *cellDic = [_record objectAtIndex:indexPath.row];
		
    cell.titleLabel.text = [cellDic objectForKey:@"proj_name"];
	
	double current = [[NSString stringWithFormat:@"%@",[cellDic objectForKey:@"money_now"]] intValue];
	double require = [[NSString stringWithFormat:@"%@",[cellDic objectForKey:@"money"]] intValue];
	double progress =  current/require*100;
	
	
	cell.progressLabel.text = [NSString stringWithFormat:@"%.0lf %%",progress];
	cell.progressBar.progress = progress/100.0f;
	
	if ([_segment selectedSegmentIndex] == 0)
	{
		cell.statusLabel.text = [NSString stringWithFormat:@"已支持¥%@", [cellDic objectForKey:@"personal_item_money"]];
	}
	else
	{
		cell.statusLabel.text = [NSString stringWithFormat:@"已筹集¥%@", [cellDic objectForKey:@"money_now"]];
	}
	
	
    return cell;
}


#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
	NSDictionary *cellDic = [_record objectAtIndex:indexPath.row];
	
	CFDetailViewController *detailView = [[CFDetailViewController alloc]initWithNibName:@"CFDetailViewController" bundle:nil];
	detailView.tabBarController.hidesBottomBarWhenPushed = YES;
	detailView.contentDic = cellDic;
	[self.navigationController pushViewController:detailView animated:YES];
}


#pragma Segment stuff
- (IBAction)changeSegment:(UISegmentedControl *)sender
{
    if ([sender selectedSegmentIndex] == 0)
	{
		[self loadInvest];
		_record = _investArr;
		[_favTableView reloadData];
    }
	else
	{
		[self loadFav];
		_record = _favArr;
		[_favTableView reloadData];
	}
}

@end
