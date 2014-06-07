//
//  HomeVC.m
//  Radar_Animal
//
//  Created by Guilherme Andrade on 6/7/14.
//  Copyright (c) 2014 Guilherme Andrade. All rights reserved.
//

#import "HomeVC.h"
#import "Server.h"
#import "NewsFeedCell.h"

@interface HomeVC () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *newsFeeds;
@end

@implementation HomeVC

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
	
}

- (NSArray*)newsFeeds{
	if(!_newsFeeds){
		Server *server = [[Server alloc] init];
		_newsFeeds = server.newsFeeds;
	}
	return _newsFeeds;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	return [self.newsFeeds count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	NewsFeedCell *cell = [tableView dequeueReusableCellWithIdentifier:@"feedCell"];
	
	cell.titleLabel.text = self.newsFeeds[indexPath.row][@"Title"];
	cell.textView.text = self.newsFeeds[indexPath.row][@"Text"];
	cell.imageView.image = [UIImage imageNamed:self.newsFeeds[indexPath.row][@"ImageName"]];
	if( [self.newsFeeds[indexPath.row][@"Status"] isEqualToString:@"Lost"] )
		cell.backgroundColor = [UIColor redColor];
	else if( [self.newsFeeds[indexPath.row][@"Status"] isEqualToString:@"Found"] )
		cell.backgroundColor = [UIColor greenColor];
	
	return cell;
}

@end
