//
//  MyCollectionViewLayout.m
//  CollectionViewSample
//
//  Created by Phillip Harris on 6/30/14.
//  Copyright (c) 2014 Phillip Harris. All rights reserved.
//

#import "MyCollectionViewLayout.h"

@interface MyCollectionViewLayout ()

@property (nonatomic, strong) NSMutableArray *layoutAttributes;

@property (nonatomic, assign) NSInteger numberOfRows;
@property (nonatomic, assign) CGSize itemSize;
@property (nonatomic, assign) NSInteger numberOfColumns;
@property (nonatomic, assign) CGFloat interColumn;
@property (nonatomic, assign) CGFloat interRow;

@end

@implementation MyCollectionViewLayout

// At the beginning of the layout cycle, the layout object calls prepareLayout before beginning the layout process. This method is your chance to calculate information that later informs your layout. The prepareLayout method is not required to implement a custom layout but is provided as an opportunity to make initial calculations if necessary. After this method is called, your layout must have enough information to calculate the collection view’s content size, the next step in the layout process. The information, however, can range from this minimum requirement to creating and storing all the layout attributes objects your layout will use. Use of the prepareLayout method is subject to the infrastructure of your app and to what makes sense to compute up front versus what to compute upon request.
- (void)prepareLayout {
    
    NSMutableArray *layoutAttributes = [NSMutableArray array];
    
    NSInteger numberOfItems = [self.collectionView numberOfItemsInSection:0];
    
    self.numberOfColumns = 4;
    
    self.itemSize = CGSizeMake(50.0, 50.0);
    
    self.interColumn = 0.5;
    self.interRow = 0.5;
    
    for (int i = 0; i < numberOfItems; i++) {
        
        NSInteger column = i % self.numberOfColumns;
        NSInteger row = ceilf((i + 1) / self.numberOfColumns) - 1;
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        attributes.frame = CGRectMake((self.itemSize.width + self.interColumn) * column, (self.itemSize.height + self.interRow) * row, self.itemSize.width, self.itemSize.height);
        [layoutAttributes addObject:attributes];
        
        self.numberOfRows = row;
    }
    
    self.layoutAttributes = layoutAttributes;
}

- (CGSize)collectionViewContentSize {
    return CGSizeMake(self.numberOfColumns * (self.itemSize.width + self.interColumn), self.numberOfRows * (self.itemSize.height + self.interRow));
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    return self.layoutAttributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [self.layoutAttributes objectAtIndex:indexPath.item];
}

@end
