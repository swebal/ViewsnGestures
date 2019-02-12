//
//  TileView.h
//  ViewsnGestures
//
//  Created by Markus on 2019-02-12.
//  Copyright © 2019 The App Factory AB. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TileViewDelegate <NSObject>

- (void)tileTappedForColumn:(NSInteger)column andRow:(NSInteger)row;
- (void)tileTapped:(UIView *)tile;

@end


@interface TileView : UIView

@property (nonatomic, assign) NSInteger columns;
@property (nonatomic, assign) NSInteger rows;
@property (nonatomic, strong) UIScrollView *myScrollView;
@property (nonatomic, assign) id<TileViewDelegate> tileDelegate;

- (void)setColumns:(NSInteger)columns andRows:(NSInteger)rows; // Rensar och skapar nya tiles
- (UIView *)viewForColumn:(NSInteger)column andRow:(NSInteger)row;

@end
