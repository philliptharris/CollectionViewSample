//
//  MyCell.h
//  CollectionViewSample
//
//  Created by Phillip Harris on 6/30/14.
//  Copyright (c) 2014 Phillip Harris. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString * const MyCellId;

@interface MyCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UILabel *label;

@end
