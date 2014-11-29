//
//  MainCell.m
//  Mojo
//
//  Created by Marcello Mascia on 27/11/2014.
//  Copyright (c) 2014 Marcello Mascia. All rights reserved.
//

#import "MainCell.h"
#import "SubCell.h"


static NSString *kSubCellIdentifier												= @"SubCell";


@interface MainCell() < UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout >

@property (nonatomic, strong) IBOutlet UICollectionView *						collectionView;

@property (nonatomic, strong) NSArray *											items;

@end


@implementation MainCell


- (void)setItems:(NSArray *)items direction:(MainCellDirection)direction
{
	if (_items != items)
	{
		_items = items;
		
		[self.collectionView reloadData];
		
		CGFloat x = 0.0;
		
		if (direction == MainCellDirection_Backward)
		{
			x = CGRectGetWidth(self.collectionView.frame) * (items.count-1);
		}
		
		self.collectionView.contentOffset = CGPointMake(x, 0.0);
	}
}


#pragma mark - CollectionView stuff


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
	return collectionView.frame.size;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
	return self.items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
	NSString *imageName		= self.items[indexPath.row];
	
	SubCell *cell			= [collectionView dequeueReusableCellWithReuseIdentifier:kSubCellIdentifier forIndexPath:indexPath];
	cell.textLabel.text		= imageName;
	
	return cell;
}


@end
