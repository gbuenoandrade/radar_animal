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


- (void)viewWillAppear:(BOOL)animated{
	[self updateScreen];
}

- (void)updateScreen{
	self.newsFeeds = [[Server getServer] newsFeedsArray];
	[self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.newsFeeds = [[Server getServer] newsFeedsArray];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	return [self.newsFeeds count];
}


- (UIImage *)image:(UIImage*)originalImage scaledToSize:(CGSize)size
{
    //avoid redundant drawing
    if (CGSizeEqualToSize(originalImage.size, size))
    {
        return originalImage;
    }
	
    //create drawing context
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0f);
	
    //draw
    [originalImage drawInRect:CGRectMake(0.0f, 0.0f, size.width, size.height)];
	
    //capture resultant image
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
	
    //return image
    return image;
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	
	NewsFeedCell *cell = [tableView dequeueReusableCellWithIdentifier:@"feedCell"];
	
	cell.titleLabel.text = self.newsFeeds[indexPath.row][@"Title"];
	cell.textView.text = self.newsFeeds[indexPath.row][@"Text"];
	
	
	
	UIImage *image;
	
	if(self.newsFeeds[indexPath.row][@"Image"])
		image = self.newsFeeds[indexPath.row][@"Image"];
	else
		image = [UIImage imageNamed:self.newsFeeds[indexPath.row][@"ImageName"]];
	
	
	cell.imageView.image = [self image:image scaledToSize:CGSizeMake(100, 100)];
	
	if( [self.newsFeeds[indexPath.row][@"Status"] isEqualToString:@"Lost"] )
		cell.backgroundColor = [UIColor redColor];
	else if( [self.newsFeeds[indexPath.row][@"Status"] isEqualToString:@"Found"] )
		cell.backgroundColor = [UIColor greenColor];
	
	return cell;
}

@end
