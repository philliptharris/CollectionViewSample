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

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _scrollDirection = UICollectionViewScrollDirectionVertical;
        
        _numberOfColumns = 6;
        _itemSize = CGSizeMake(50.0, 50.0);
        _interColumn = 0.5;
        _interRow = 0.5;
        _minimumSize = CGSizeMake(50.0, 50.0);
        
        CGFloat inset = 0.5;
        _outsideMargins = UIEdgeInsetsMake(inset, inset, inset, inset);
    }
    return self;
}

// At the beginning of the layout cycle, the layout object calls prepareLayout before beginning the layout process. This method is your chance to calculate information that later informs your layout. The prepareLayout method is not required to implement a custom layout but is provided as an opportunity to make initial calculations if necessary. After this method is called, your layout must have enough information to calculate the collection view’s content size, the next step in the layout process. The information, however, can range from this minimum requirement to creating and storing all the layout attributes objects your layout will use. Use of the prepareLayout method is subject to the infrastructure of your app and to what makes sense to compute up front versus what to compute upon request.
- (void)prepareLayout {
    
    if (self.scrollDirection == UICollectionViewScrollDirectionVertical) {
        
        NSMutableArray *layoutAttributes = [NSMutableArray array];
        
        NSInteger numberOfItems = [self.collectionView numberOfItemsInSection:0];
        
        CGRect availableFrame = UIEdgeInsetsInsetRect(self.collectionView.bounds, self.outsideMargins);
        CGFloat availableWidth = CGRectGetWidth(availableFrame);
        CGFloat exactNumberOfColumns = (availableWidth + self.interColumn) / (self.minimumSize.width + self.interColumn);
        self.numberOfColumns = floorf(exactNumberOfColumns);
        
        CGFloat availableWidthForItems = availableWidth - ((self.numberOfColumns - 1) * self.interColumn);
        CGFloat exactItemWidth = availableWidthForItems / self.numberOfColumns;
        CGFloat roundedItemWidth = floorf(exactItemWidth);
        
        CGFloat leftoverItemWidth = availableWidthForItems - (roundedItemWidth * self.numberOfColumns);
        
        NSMutableArray *widthByColumn = [NSMutableArray array];
        for (int c = 0; c < self.numberOfColumns; c++) {
            [widthByColumn addObject:[NSNumber numberWithFloat:roundedItemWidth]];
        }
        
        NSInteger column = 0;
        while (leftoverItemWidth > 0.0) {
            if (column >= self.numberOfColumns) {
                column = 0;
            }
            NSNumber *number = [widthByColumn objectAtIndex:column];
            CGFloat width = [number floatValue];
            width += 0.5;
            leftoverItemWidth -= 0.5;
            [widthByColumn replaceObjectAtIndex:column withObject:[NSNumber numberWithFloat:width]];
            column++;
        }
        
        self.itemSize = CGSizeMake(roundedItemWidth, self.minimumSize.height);
        
        CGFloat xPoint = self.outsideMargins.left;
        
        for (int i = 0; i < numberOfItems; i++) {
            
            NSInteger column = i % self.numberOfColumns;
            CGFloat rowAsFloat = 1.0 * i / self.numberOfColumns;
            NSInteger row = floorf(rowAsFloat);
            
            if (column == 0) {
                xPoint = self.outsideMargins.left;
            }
            
            CGFloat widthForColumn = [[widthByColumn objectAtIndex:column] floatValue];
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
            UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
            attributes.frame = CGRectMake(xPoint, self.outsideMargins.top + (self.itemSize.height + self.interRow) * row, widthForColumn, self.itemSize.height);
            [layoutAttributes addObject:attributes];
            
            xPoint += widthForColumn;
            xPoint += self.interColumn;
            
            self.numberOfRows = row + 1;
        }
        
        self.layoutAttributes = layoutAttributes;
    }
    else {
        
        NSMutableArray *layoutAttributes = [NSMutableArray array];
        
        NSInteger numberOfItems = [self.collectionView numberOfItemsInSection:0];
        
        CGRect availableFrame = UIEdgeInsetsInsetRect(self.collectionView.bounds, self.outsideMargins);
        CGFloat availableHeight = CGRectGetHeight(availableFrame);
        CGFloat exactNumberOfRows = (availableHeight + self.interRow) / (self.minimumSize.height + self.interRow);
        self.numberOfRows = floorf(exactNumberOfRows);
        
        CGFloat availableHeightForItems = availableHeight - ((self.numberOfRows - 1) * self.interRow);
        CGFloat exactItemHeight = availableHeightForItems / self.numberOfRows;
        CGFloat roundedItemHeight = floorf(exactItemHeight);
        
        CGFloat leftoverItemHeight = availableHeightForItems - (roundedItemHeight * self.numberOfRows);
        
        NSMutableArray *heightByRow = [NSMutableArray array];
        for (int r = 0; r < self.numberOfRows; r++) {
            [heightByRow addObject:[NSNumber numberWithFloat:roundedItemHeight]];
        }
        
        NSInteger row = 0;
        while (leftoverItemHeight > 0.0) {
            if (row >= self.numberOfRows) {
                row = 0;
            }
            NSNumber *number = [heightByRow objectAtIndex:row];
            CGFloat height = [number floatValue];
            height += 0.5;
            leftoverItemHeight -= 0.5;
            [heightByRow replaceObjectAtIndex:row withObject:[NSNumber numberWithFloat:height]];
            row++;
        }
        
        self.itemSize = CGSizeMake(self.minimumSize.width, roundedItemHeight);
        
        CGFloat yPoint = self.outsideMargins.top;
        
        for (int i = 0; i < numberOfItems; i++) {
            
            NSInteger row = i % self.numberOfRows;
            CGFloat columnAsFloat = 1.0 * i / self.numberOfRows;
            NSInteger column = floorf(columnAsFloat);
            
            if (row == 0) {
                yPoint = self.outsideMargins.top;
            }
            
            CGFloat heightForRow = [[heightByRow objectAtIndex:row] floatValue];
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
            UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
            attributes.frame = CGRectMake(self.outsideMargins.left + (self.itemSize.width + self.interColumn) * column, yPoint, self.itemSize.width, heightForRow);
            [layoutAttributes addObject:attributes];
            
            yPoint += heightForRow;
            yPoint += self.interRow;
            
            self.numberOfColumns = column + 1;
        }
        
        self.layoutAttributes = layoutAttributes;
    }
}

- (CGSize)collectionViewContentSize {
    
    CGFloat width = self.outsideMargins.left + self.outsideMargins.right + self.numberOfColumns * self.itemSize.width + (self.numberOfColumns - 1) * self.interColumn;
    CGFloat height = self.outsideMargins.top + self.outsideMargins.bottom + self.numberOfRows * self.itemSize.height + (self.numberOfRows - 1) * self.interRow;
    return CGSizeMake(width, height);
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    return self.layoutAttributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [self.layoutAttributes objectAtIndex:indexPath.item];
}

@end
