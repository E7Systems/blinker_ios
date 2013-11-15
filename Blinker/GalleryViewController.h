//
//  GalleryViewController.h
//  Blinker
//
//  Created by Ryan Stickel on 11/14/13.
//  Copyright (c) 2013 Blinker. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GalleryViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *colView;

@end
