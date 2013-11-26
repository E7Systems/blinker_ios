//
//  GalleryViewController.h
//  Blinker
//
//  Created by Ryan Stickel on 11/14/13.
//  Copyright (c) 2013 Blinker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import "UIImage+Resize.h"

@interface GalleryViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) IBOutlet UICollectionView *colView;
@property (nonatomic, strong) NSDictionary *vehicleDict;

-(IBAction)showCameraAction:(id)sender;

@end
