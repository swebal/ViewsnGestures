//
//  ViewController.m
//  ViewsnGestures
//
//  Created by Markus on 2019-02-12.
//  Copyright © 2019 The App Factory AB. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Setup
    self.view.backgroundColor = [UIColor blueColor];
    [self.tileView setColumns:3 andRows:9];
    self.tileView.tileDelegate = self;
}

#pragma mark - Tile Delegate

- (void)tileTappedForColumn:(NSInteger)column andRow:(NSInteger)row {
    NSLog(@"ViewController did receive tap for column: %ld and row: %ld", column, row);
    UIView *tile = [_tileView viewForColumn:column andRow:row];
    [tile setBackgroundColor:[UIColor greenColor]];
}

- (void)tileTapped:(UIView *)tile {
    [tile setBackgroundColor:[UIColor greenColor]];
}

@end
