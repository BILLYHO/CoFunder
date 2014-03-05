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
	[self.favTableView registerNib:[UINib nibWithNibName:@"CFFavouriteCell" bundle:nil] forCellReuseIdentifier:favouriteCell];
	
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
	
    CFFavouriteCell *cell = [tableView dequeueReusableCellWithIdentifier:favouriteCell];
    
    cell.titleLabel.text = [NSString stringWithFormat:@"row %ld", (long)indexPath.row];
	unsigned progress = arc4random()%100;
	cell.progressLabel.text = [NSString stringWithFormat:@"进度 %d%%",progress];
	cell.progressBar.progress = progress/100.0f;
	
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
	
	CFDetailViewController *detailView = [[CFDetailViewController alloc]initWithNibName:@"CFDetailViewController" bundle:nil];
	detailView.tabBarController.hidesBottomBarWhenPushed = YES;
	[self.navigationController pushViewController:detailView animated:YES];
}


@end
