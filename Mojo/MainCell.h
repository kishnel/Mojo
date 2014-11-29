//
//  MainCell.h
//  Mojo
//
//  Created by Marcello Mascia on 27/11/2014.
//  Copyright (c) 2014 Marcello Mascia. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum : NSUInteger
{
	MainCellDirection_Forward,
	MainCellDirection_Backward
} MainCellDirection;

@interface MainCell : UICollectionViewCell

- (void)setItems:(NSArray *)items direction:(MainCellDirection)direction;

@end
