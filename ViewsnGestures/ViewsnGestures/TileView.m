//
//  TileView.m
//  ViewsnGestures
//
//  Created by Markus on 2019-02-12.
//  Copyright © 2019 The App Factory AB. All rights reserved.
//

#import "TileView.h"

@interface TileView()

@property (nonatomic, assign) NSInteger numberOfColumns;
@property (nonatomic, assign) NSInteger numberOfRows;

@end

@implementation TileView

- (void)setColumns:(NSInteger)columns andRows:(NSInteger)rows {
    
    self.numberOfColumns = columns;
    self.numberOfRows = rows;
    
    // Skapa scrollview om den inte finns
    if (!_myScrollView) {
        self.myScrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    }
    
    // Lägg till scrollview om den inte redan är
    if (![self.subviews containsObject: _myScrollView]) {
        _myScrollView.tag = -1; // Så vi kan använda index 0
        [_myScrollView setFrame:self.bounds];
        [self addSubview:_myScrollView];
    }
    
    CGFloat screenWidth = self.frame.size.width;
    CGFloat spacing = 1;
    CGFloat viewWidth = (screenWidth - (columns - 1) * spacing) / columns;
    
    // (100 - 3 * 1) / 4 ≈ 24 p
    
    CGFloat totalWidth = columns * viewWidth + (columns - 1) * spacing;
    CGFloat totalHeight = rows * viewWidth + (rows - 1) * spacing;
    
    _myScrollView.contentSize = CGSizeMake(totalWidth, totalHeight);
    
    // Innan vi lägger till fler vyer, bör vi ta bort alla "gamla" tumnaglar
    for (UIView *subView in _myScrollView.subviews) {
        [subView removeFromSuperview];
    }
    
    for (int i=0; i<_numberOfColumns; i++) {
        for (int j=0; j<_numberOfRows; j++) {
            CGRect rect = CGRectMake(i * (viewWidth+spacing),
                                     j * (viewWidth+spacing),
                                     viewWidth,
                                     viewWidth);
            UIView *myView = [[UIView alloc] initWithFrame:rect];
            [myView setBackgroundColor:[UIColor whiteColor]];
            NSInteger index = i + j * columns;
            myView.tag = index;
            
            UIButton *myButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [myButton setFrame:CGRectMake(30, 30, viewWidth-60, viewWidth-60)];
            [myButton setBackgroundColor:[UIColor yellowColor]];
            [myButton setTitle:[NSString stringWithFormat:@"%d, %d", i, j] forState:UIControlStateNormal];
            [myButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [myButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
            [myView addSubview:myButton]; // Den här metoden tilldelar: myButton.superView = myView;
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTap:)];
            [myView addGestureRecognizer:tap]; // Den här metoden tilldelar: tap.view = myView;
            
            [_myScrollView addSubview:myView];
        }
    }
}

- (void)buttonPressed:(UIButton *)button {
    NSInteger index = button.superview.tag;
    NSLog(@"Did press button: %ld", index);
    [button setBackgroundColor:[UIColor purpleColor]];
}

- (void)didTap:(UIGestureRecognizer *)recognizer {
    NSInteger index = recognizer.view.tag;
    NSInteger row = index / self.numberOfColumns; // 8/3=2
    NSInteger column = index % self.numberOfColumns; // 8%3=2
//    NSLog(@"Hej på dig, index %ld!", index);
//    [_tileDelegate tileTappedForColumn:column andRow:row];
    [_tileDelegate tileTapped:recognizer.view];
}

- (UIView *)viewForColumn:(NSInteger)column andRow:(NSInteger)row {
    if (column >= 0
        && column < self.numberOfColumns
        && row > 0
        && row < self.numberOfRows) {
        NSInteger index = column + row * self.numberOfColumns;
        return [_myScrollView viewWithTag:index];
    }
    return nil;
}

@end
