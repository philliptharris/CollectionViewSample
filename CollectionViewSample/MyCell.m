//
//  MyCell.m
//  CollectionViewSample
//
//  Created by Phillip Harris on 6/30/14.
//  Copyright (c) 2014 Phillip Harris. All rights reserved.
//

#import "MyCell.h"

NSString * const MyCellId = @"MyCellId";

@implementation MyCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.label.textColor = [UIColor whiteColor];
    self.label.font = [UIFont fontWithName:@"AvenirNext-Bold" size:18.0];
    
    UIView *selectedBackgroundView = [[UIView alloc] initWithFrame:self.contentView.bounds];
    selectedBackgroundView.backgroundColor = [UIColor purpleColor];
    self.selectedBackgroundView = selectedBackgroundView;
}

@end
