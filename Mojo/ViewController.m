//
//  ViewController.m
//  Mojo
//
//  Created by Marcello Mascia on 27/11/2014.
//  Copyright (c) 2014 Marcello Mascia. All rights reserved.
//

#import "MainCell.h"
#import "ViewController.h"


static NSString *kMainCellIdentifier											= @"MainCell";
static NSString *kWeatherCellIdentifier											= @"WeatherCell";


@interface ViewController () < UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout >

@property (nonatomic, strong) IBOutlet UICollectionView *						weatherCollectionView;
@property (nonatomic, strong) IBOutlet UICollectionView *						collectionView;

@property (nonatomic, strong) NSArray *											sections;
@property (nonatomic, readwrite) NSInteger										currentCellPosition;
@property (nonatomic, readwrite) CGFloat										weatherCellWidth;

@end


@implementation ViewController


#pragma mark - Model


- (NSArray *)sections
{
	if (!_sections)
	{
		NSString *plistPath		= [[NSBundle mainBundle] pathForResource:@"datasource" ofType:@"plist"];
		
		_sections				= [NSArray arrayWithContentsOfFile:plistPath];
	}
	
	return _sections;
}

- (CGFloat)weatherCellWidth
{
	// I'm assuming that the weather cell is half the main cell
	CGFloat width		= CGRectGetWidth(self.collectionView.frame);
	CGFloat cellWidth	= width / 2.0;

	return cellWidth;
}


#pragma mark - ScrollView stuff


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	if (scrollView == self.collectionView)
	{
		CGPoint offset	= self.weatherCollectionView.contentOffset;
		offset.x		= scrollView.contentOffset.x * 0.5;
		
		self.weatherCollectionView.contentOffset = offset;
	}
}


#pragma mark - CollectionView stuff


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
	if (collectionView == self.weatherCollectionView)
	{
		return CGSizeMake(self.weatherCellWidth, CGRectGetHeight(collectionView.frame));
	}
	else
	{
		return collectionView.frame.size;
	}
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
	if (collectionView == self.weatherCollectionView)
	{
		CGFloat width		= CGRectGetWidth(collectionView.frame);
		CGFloat margin		= (width - self.weatherCellWidth) / 2.0;
		
		return UIEdgeInsetsMake(0.0, margin, 0.0, margin);
	}
	else
	{
		return UIEdgeInsetsZero;
	}
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
	return self.sections.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
	if (collectionView == self.collectionView)
	{
		NSArray *items					= self.sections[indexPath.row];
		MainCellDirection direction		= self.currentCellPosition > indexPath.row ? MainCellDirection_Backward : MainCellDirection_Forward;
		
		MainCell *cell					= [collectionView dequeueReusableCellWithReuseIdentifier:kMainCellIdentifier forIndexPath:indexPath];
		[cell setItems:items direction:direction];
		
		self.currentCellPosition		= indexPath.row;
		
		return cell;
	}
	else
	{
		UICollectionViewCell *cell		= [collectionView dequeueReusableCellWithReuseIdentifier:kWeatherCellIdentifier forIndexPath:indexPath];
		
		return cell;
	}
}


@end
