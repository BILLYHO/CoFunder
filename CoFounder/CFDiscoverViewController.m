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

@interface CFDiscoverViewController ()

@end

@implementation CFDiscoverViewController

static NSString *eventCellIndentifier = @"EventCell";

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
	
	UINib *eventNib = [UINib nibWithNibName:@"CFEventCell" bundle:nil];
	[self.tableView registerNib:eventNib forCellReuseIdentifier:eventCellIndentifier];
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
	return 10;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *discoverCell = @"discoverCell";
    static BOOL isRegNib = NO;
    if (!isRegNib)
	{
        [tableView registerNib:[UINib nibWithNibName:@"CFDiscoverCell" bundle:nil] forCellReuseIdentifier:discoverCell];
        isRegNib = YES;
    }
    
    CFDiscoverCell *cell = [tableView dequeueReusableCellWithIdentifier:discoverCell];
    
    
	cell.titleLabel.text = [NSString stringWithFormat:@"row %ld", (long)indexPath.row];
	cell.pictureView.image = [UIImage imageNamed:@"iphone_png-3"];
	cell.moneyLabel.text = [NSString stringWithFormat:@"¥ %d", arc4random()%100000];
	cell.peopleLabel.text = [NSString stringWithFormat:@"%d", arc4random()%10000];
	unsigned progress = arc4random()%100;
	cell.progressLabel.text = [NSString stringWithFormat:@"%d %%",progress];
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
	[self.navigationController pushViewController:detailView animated:YES];
}


@end
