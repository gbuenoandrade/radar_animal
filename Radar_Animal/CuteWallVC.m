//
//  CuteWallVC.m
//  Radar_Animal
//
//  Created by Guilherme Andrade on 6/7/14.
//  Copyright (c) 2014 Guilherme Andrade. All rights reserved.
//

#import "CuteWallVC.h"
#import "CuteCell.h"
#import "Server.h"

@interface CuteWallVC () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSArray* cutesItens;

@end

@implementation CuteWallVC

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
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSArray*)cutesItens{
	if(!_cutesItens){
		Server *server = [[Server alloc] init];
		_cutesItens = server.cutesArray;
	}
	return _cutesItens;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
	return [self.cutesItens count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	CuteCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"cuteCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
	cell.imageView.image = [UIImage imageNamed:self.cutesItens[indexPath.row][@"ImageName"]];
	cell.textLabel.text = self.cutesItens[indexPath.row][@"Title"];
	
    return cell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
