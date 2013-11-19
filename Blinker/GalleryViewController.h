//
//  GalleryViewController.h
//  Blinker
//
//  Created by Ryan Stickel on 11/14/13.
//  Copyright (c) 2013 Blinker. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GalleryViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) IBOutlet UICollectionView *colView;

-(IBAction)showCameraAction:(id)sender;

@end
