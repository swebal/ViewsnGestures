//
//  ViewController.h
//  ViewsnGestures
//
//  Created by Markus on 2019-02-12.
//  Copyright © 2019 The App Factory AB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TileView.h"

@interface ViewController : UIViewController <TileViewDelegate>

@property (weak, nonatomic) IBOutlet TileView *tileView;

@end

