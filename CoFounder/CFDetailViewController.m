//
//  CFDetailViewController.m
//  CoFounder
//
//  Created by BILLY HO on 3/2/14.
//  Copyright (c) 2014 BILLY HO. All rights reserved.
//

#import "CFDetailViewController.h"
#import "CFDetailCell.h"
#import "AppMarco.h"
#import "UIImageView+WebCache.h"
#import "CFConfirmViewController.h"
#import "AppMarco.h"

@interface CFDetailViewController ()

@end

@implementation CFDetailViewController

static NSString *detailCell = @"detailCell";

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
	self.navigationController.navigationBarHidden = YES;
	self.tabBarController.tabBar.hidden = YES;
	
	[_tableView registerNib:[UINib nibWithNibName:@"CFDetailCell" bundle:nil] forCellReuseIdentifier:detailCell];
	
	[_topImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",serverUrl,[_contentDic objectForKey:@"proj_pic"]]]];
	_titleLabel.text = [_contentDic objectForKey:@"proj_name"];
	_descriptionLabel.text = [_contentDic objectForKey:@"proj_intro"];
	
	_itemContent = [[NSMutableArray alloc] init];
	for (int i=0; i<[[NSString stringWithFormat:@"%@",[_contentDic objectForKey:@"item_number"]]intValue]; i++)
	{
		NSString *key = [NSString stringWithFormat:@"%d",i];
		[_itemContent addObject:[_contentDic objectForKey:key]];
	}
	
	NSUserDefaults *dataBase = [NSUserDefaults standardUserDefaults];
	_username = [dataBase objectForKey:@"currentUser"];
	_proj = [_contentDic objectForKey:@"proj_id"];
	
	NSError *error;
	NSString *urlString = [NSString stringWithFormat:@"%@/index.php/Index/isFollowing/username/%@/proj_id/%@",serverUrl, _username, _proj];
	NSURL *url = [NSURL URLWithString:urlString];
	NSURLRequest *request = [NSURLRequest requestWithURL:url];
	NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
	NSDictionary *favDic = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
	
	if ([[favDic objectForKey:@"response"] isEqualToString:@"true"])
	{
		_favButton.tintColor = [UIColor colorWithRed:255 green:200 blue:0 alpha:1];
	}
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)backButtonClicked:(id)sender
{
	self.navigationController.navigationBarHidden = NO;
	self.tabBarController.tabBar.hidden = NO;
	[self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Table view data source
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [_itemContent count];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{


    
    CFDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:detailCell];

	
	
    
    //cell.contentLabel.text = @"";

	NSDictionary *cellDic = [_itemContent objectAtIndex:indexPath.row];
    
	NSString *text = [cellDic objectForKey:@"item_return"];

	cell.contentLabel.text = text;
	for(int i=0; i<99; i++)
		cell.contentLabel.text = [cell.contentLabel.text stringByAppendingString:@"\n "];
    
	
	cell.moneyLabel.text = [NSString stringWithFormat:@"支持 ¥ %@",[cellDic objectForKey:@"item_money" ]];

	unsigned now = [[NSString stringWithFormat:@"%@",[cellDic objectForKey:@"item_people_now"]]intValue];
	unsigned reqire = [[NSString stringWithFormat:@"%@",[cellDic objectForKey:@"item_people_request"]]intValue];
	cell.peopleLabel.text = [NSString stringWithFormat:@"%d位支持者",now];
	cell.remainLabel.text = [NSString stringWithFormat:@"限%d位, 剩余%d位", reqire, reqire - now];
	[cell.remainLabel sizeToFit];
    return cell;
}


#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSDictionary *cellDic = [_itemContent objectAtIndex:[indexPath row]];
    
	NSString *text = [cellDic objectForKey:@"item_return"];

    
    CGSize constraint = CGSizeMake(320 - (20 * 2), 20000.0f);
    
    NSAttributedString *attributedText =[[NSAttributedString alloc]
     initWithString:text
     attributes:@
     {
     NSFontAttributeName:[UIFont systemFontOfSize:16.0f]
     }];
    CGRect rect = [attributedText boundingRectWithSize:constraint
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                               context:nil];
    CGSize size = rect.size;
	
    
    CGFloat height = size.height;
    //NSLog([NSString stringWithFormat:@"height: %f", height]);
	
    return height + 150;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
	
		
	CFConfirmViewController *confirmView = [[CFConfirmViewController alloc]initWithNibName:@"CFConfirmViewController" bundle:nil];
	confirmView.tabBarController.hidesBottomBarWhenPushed = YES;
	
	confirmView.contentDic = [_itemContent objectAtIndex:indexPath.row];
	
	[self.navigationController pushViewController:confirmView animated:YES];

}

- (IBAction)didClickedFavButton:(id)sender
{
	if ([_favButton.tintColor isEqual:[UIColor colorWithRed:255 green:200 blue:0 alpha:1]])
	{
		NSError *error;
		NSString *urlString = [NSString stringWithFormat:@"%@/index.php/Index/removeFollowing/username/%@/proj_id/%@",serverUrl, _username, _proj];
		NSURL *url = [NSURL URLWithString:urlString];
		NSURLRequest *request = [NSURLRequest requestWithURL:url];
		NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
		NSDictionary *favDic = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
		
		if ([[favDic objectForKey:@"response"] isEqualToString:@"OK"])
		{
			_favButton.tintColor = [UIColor colorWithRed:0 green:0.48 blue:255 alpha:1];
		}
	}
	else
	{
		NSError *error;
		NSString *urlString = [NSString stringWithFormat:@"%@/index.php/Index/addFollowing/username/%@/proj_id/%@",serverUrl, _username, _proj];
		NSURL *url = [NSURL URLWithString:urlString];
		NSURLRequest *request = [NSURLRequest requestWithURL:url];
		NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
		NSDictionary *favDic = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
		
		if ([[favDic objectForKey:@"response"] isEqualToString:@"ok"])
		{
			_favButton.tintColor = [UIColor colorWithRed:255 green:200 blue:0 alpha:1];
		}
	}
}


@end
