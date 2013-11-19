//
//  GallerySliderViewController.h
//  Blinker
//
//  Created by Ryan Stickel on 11/18/13.
//  Copyright (c) 2013 Blinker. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GallerySliderViewController : UIViewController <UIScrollViewDelegate>

@property (nonatomic, strong) NSArray *imageArray;
@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) IBOutlet UIPageControl *pageControl;
@property (nonatomic, strong) IBOutlet UIImageView *imageView;
@property (nonatomic, assign) NSInteger initialPage;

- (IBAction)scrollToImage;

@end
