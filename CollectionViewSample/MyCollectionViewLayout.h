//
//  MyCollectionViewLayout.h
//  CollectionViewSample
//
//  Created by Phillip Harris on 6/30/14.
//  Copyright (c) 2014 Phillip Harris. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCollectionViewLayout : UICollectionViewLayout

@property (nonatomic, assign) UICollectionViewScrollDirection scrollDirection;

@property (nonatomic, assign) UIEdgeInsets outsideMargins;
@property (nonatomic, assign) CGSize minimumSize;

@end
