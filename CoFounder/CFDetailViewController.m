//
//  CFDetailViewController.m
//  CoFounder
//
//  Created by BILLY HO on 3/2/14.
//  Copyright (c) 2014 BILLY HO. All rights reserved.
//

#import "CFDetailViewController.h"
#import "CFDetailCell.h"

@interface CFDetailViewController ()
@property (strong, nonatomic) NSString *detailCell;
@end

@implementation CFDetailViewController

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
	
	    _detailCell = @"detailCell";
	[_tableView registerNib:[UINib nibWithNibName:@"CFDetailCell" bundle:nil] forCellReuseIdentifier:_detailCell];
	
	_topImageView.image = [UIImage imageNamed:@"project"];
	_titleLabel.text = [NSString stringWithFormat:@"乐心智能儿童身高测量仪--熊孩子家必备神器！"];
	_descriptionLabel.text = [NSString stringWithFormat:@"市面上很多的智能产品都是为自己设计的，从来没有一款可以陪伴小孩成长的智能产品，乐心智能身高测量仪是全球第一款真正智能记录身高的测量仪，它能够精确的记录宝宝每次的身高数据并且分析，建议；配合光学测量技术，为孩子带来简单轻松的测量体验。它是伴随你宝宝成长最好的礼物。"];
	
	
	_content = @[
	@"【智能身高测量仪1台】感谢您对乐心智能身高测量仪的大力支持！作为点名时间支持者，您能够以极其优惠的价格得到智能身高测量仪一台，比预计市场价399便宜200元！限量50台。",
	@"【智能身高测量仪1台】感谢您对乐心智能身高测量仪的大力支持！虽然您没有拿到最优惠的前50台，但支持这一项您仍然可以以269元的价格得到399智能身高测量仪一台，并优先发货。",
	@"【智能身高测量仪2台】感谢您对乐心智能身高测量仪的大力支持！您一定是特有爱的支持者，我们为您准备了两台装，一台您宝宝用，一台给您关心的人。",
	@"【智能身高测量仪50台】感谢您对乐心智能身高测量仪的大力支持！ 大小经销商们的支持者看过来，我们为您准备了50台装，您可以用来在自己的渠道中试销智能身高测量仪，或作为馈赠礼品使用。同时，我们也欢迎全球各地经销商与我们联系、洽谈后续的商业合作事宜。",];
	
	_money = @[@"199", @"299", @"499", @"9999"];
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
	return [_content count];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{


    
    CFDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:_detailCell];

	
	if (cell == nil)
	{
		cell = [[CFDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:_detailCell];
		NSLog(@"new cell");
	}
	
	
    
    cell.contentLabel.text = @"";

	NSString *text = [_content objectAtIndex:[indexPath row]];
    
    CGSize constraint = CGSizeMake(320 - (20 * 2), 20000.0f);
    
    NSAttributedString *attributedText = [[NSAttributedString alloc]initWithString:text attributes:@{
																									 NSFontAttributeName:[UIFont systemFontOfSize:16.0f]
																									 }];
    CGRect rect = [attributedText boundingRectWithSize:constraint
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                               context:nil];
    CGSize size = rect.size;
	
    
    UILabel *con = [[UILabel alloc]initWithFrame:CGRectMake(20, 78, 320 - (20 * 2), size.height+30)];
	con.text = [_content objectAtIndex:indexPath.row];
	con.numberOfLines = 99;
    [cell addSubview:con];
	
	cell.moneyLabel.text = [NSString stringWithFormat:@"支持 ¥ %@",  [_money objectAtIndex:[indexPath row]]];

	unsigned people = arc4random()%10000;
	cell.peopleLabel.text = [NSString stringWithFormat:@"%d位支持者",people];
	cell.remainLabel.text = [NSString stringWithFormat:@"限%d位, 剩余%d位", 10000, 10000-people];
	
    return cell;
}


#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSString *text = [_content objectAtIndex:[indexPath row]];
    
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
	
    return height + 120;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}

@end
