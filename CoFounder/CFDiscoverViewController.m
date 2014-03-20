//
//  CFDiscoverViewController.m
//  CoFounder
//
//  Created by BILLY HO on 3/2/14.
//  Copyright (c) 2014 BILLY HO. All rights reserved.
//

#import "CFDiscoverViewController.h"
#import "CFDiscoverCell.h"
#import "CFDetailViewController.h"
#import "UIImageView+WebCache.h"


@interface CFDiscoverViewController ()

@end

@implementation CFDiscoverViewController

static NSString *discoverCell = @"discoverCell";

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
		self.title = @"Discover";
		self.tabBarItem.image = [UIImage imageNamed:@"discover"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	
	_projectArr = [NSMutableArray arrayWithArray:[self loadDataAfterId:@"0"]];
	
	[self.tableView registerNib:[UINib nibWithNibName:@"CFDiscoverCell" bundle:nil] forCellReuseIdentifier:discoverCell];
	
	self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Menu" style:UIBarButtonItemStyleBordered target:self action:@selector(showMenu)];
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refresh)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Load Data
- (NSArray *)loadDataAfterId:(NSString *) identifier
{
	NSError *error;
	NSString *urlString = [NSString stringWithFormat:@"%@/index.php/Index/getNumOfProjects/id/%@",serverUrl, identifier];
	NSURL *url = [NSURL URLWithString:urlString];
	NSURLRequest *request = [NSURLRequest requestWithURL:url];
	NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
	NSArray *projArr = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
	return projArr;
}


#pragma mark - Table view data source
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [_projectArr count];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	NSDictionary *cellInfo = [_projectArr objectAtIndex:indexPath.row];
 
    CFDiscoverCell *cell = [tableView dequeueReusableCellWithIdentifier:discoverCell];
    
    
//	cell.titleLabel.text = [NSString stringWithFormat:@"row %ld", (long)indexPath.row];
//	cell.pictureView.image = [UIImage imageNamed:@"iphone_png-3"];
//	cell.moneyLabel.text = [NSString stringWithFormat:@"¥ %d", arc4random()%100000];
//	cell.peopleLabel.text = [NSString stringWithFormat:@"%d", arc4random()%10000];
//	unsigned progress = arc4random()%100;
//	cell.progressLabel.text = [NSString stringWithFormat:@"%d %%",progress];
//	cell.progressBar.progress = progress/100.0f;
	
	cell.titleLabel.text = [cellInfo objectForKey:@"proj_name"];
	[cell.pictureView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",serverUrl,[cellInfo objectForKey:@"proj_pic"]]]];
	cell.moneyLabel.text = [NSString stringWithFormat:@"¥ %@",[cellInfo objectForKey:@"money_now"]];
	cell.peopleLabel.text = [NSString stringWithFormat:@"%@",[cellInfo objectForKey:@"people_now"]];
	
	double current = [[NSString stringWithFormat:@"%@",[cellInfo objectForKey:@"money_now"]] intValue];
	double require = [[NSString stringWithFormat:@"%@",[cellInfo objectForKey:@"money"]] intValue];
	double progress =  current/require*100;
	
	//NSLog([NSString stringWithFormat:@"%lf, %lf, %.0lf", current, require, progress]);
	
	cell.progressLabel.text = [NSString stringWithFormat:@"%.0lf %%",progress];
	cell.progressBar.progress = progress/100.0f;

    return cell;
}


#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 300;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	CFDetailViewController *detailView = [[CFDetailViewController alloc]initWithNibName:@"CFDetailViewController" bundle:nil];
	detailView.tabBarController.hidesBottomBarWhenPushed = YES;
	
	detailView.contentDic = [_projectArr objectAtIndex:indexPath.row];
	
	[self.navigationController pushViewController:detailView animated:YES];
}

//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//	if (indexPath.row + 1 == [_projectArr count])
//	{
//		NSArray *newArr = [[NSArray alloc]init];
//		newArr = [self loadDataAfterId:[[_projectArr objectAtIndex:indexPath.row] objectForKey:@"proj_id" ]];
//		if (newArr != nil)
//		{
//			[_projectArr addObjectsFromArray:newArr];
//			[tableView reloadData];
//		}
//	}
//}

#pragma navigationbar menu
- (void)showMenu
{
    if (_menu.isOpen)
        return [_menu close];
    
    
    REMenuItem *homeItem = [[REMenuItem alloc] initWithTitle:@"最新"
                                                       image:nil
                                            highlightedImage:nil
                                                      action:^(REMenuItem *item) {
                                                          NSLog(@"Item: %@", item);
														  self.title = @"最新";
														  [self.tableView reloadData];
                                                      }];
    
    REMenuItem *exploreItem = [[REMenuItem alloc] initWithTitle:@"最热"
                                                          image:nil
                                               highlightedImage:nil
                                                         action:^(REMenuItem *item) {
                                                             NSLog(@"Item: %@", item);
															 self.title = @"最热";
															 [self.tableView reloadData];
                                                         }];
    
    REMenuItem *activityItem = [[REMenuItem alloc] initWithTitle:@"推荐"
                                                           image:nil
                                                highlightedImage:nil
                                                          action:^(REMenuItem *item) {
                                                              NSLog(@"Item: %@", item);
															  self.title = @"推荐";
															  [self.tableView reloadData];
                                                          }];
    
    REMenuItem *profileItem = [[REMenuItem alloc] initWithTitle:@"全部"
                                                          image:nil
                                               highlightedImage:nil
                                                         action:^(REMenuItem *item) {
                                                             NSLog(@"Item: %@", item);
															 self.title = @"全部";
															 [self.tableView reloadData];
                                                         }];
    
    homeItem.tag = 0;
    exploreItem.tag = 1;
    activityItem.tag = 2;
    profileItem.tag = 3;
    
    _menu = [[REMenu alloc] initWithItems:@[homeItem, exploreItem, activityItem, profileItem]];
    _menu.cornerRadius = 4;
    _menu.shadowColor = [UIColor blackColor];
    _menu.shadowOffset = CGSizeMake(0, 1);
    _menu.shadowOpacity = 1;
    _menu.imageOffset = CGSizeMake(5, -1);
    
    [_menu showFromNavigationController:self.navigationController];
}

- (void) refresh
{
	[self loadDataAfterId:@"0"];
	[self.tableView reloadData];
}
@end
