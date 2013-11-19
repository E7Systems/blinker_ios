//
//  GallerySliderViewController.m
//  Blinker
//
//  Created by Ryan Stickel on 11/18/13.
//  Copyright (c) 2013 Blinker. All rights reserved.
//

#import "GallerySliderViewController.h"

@interface GallerySliderViewController () {
    
    NSInteger visiblePageBeforeRotation;
}

@end

@implementation GallerySliderViewController

@synthesize imageArray, scrollView, pageControl, imageView, initialPage;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    for (int i = 0; i < [imageArray count]; i++) {
        CGRect frame;
        frame.origin.x = self.scrollView.frame.size.width * i;
        frame.origin.y = 0;
        frame.size = self.scrollView.frame.size;
        
        UIImageView *subview = [[UIImageView alloc] initWithFrame:frame];
        
        subview.tag = 100 + i;
        
        if ([[imageArray objectAtIndex:i] isKindOfClass:[NSString class]]) {
            
            subview.image = [UIImage imageNamed:[imageArray objectAtIndex:i]];
            
        } else if ([[imageArray objectAtIndex:i] isKindOfClass:[UIImage class]]) {
            
            subview.image = [imageArray objectAtIndex:i];
            
        }
        
        subview.contentMode = UIViewContentModeScaleAspectFit;
        
        [self.scrollView addSubview:subview];
        
        [self.scrollView sendSubviewToBack:subview];
    }
    
    self.pageControl.numberOfPages = [imageArray count];
    
    visiblePageBeforeRotation = self.initialPage;
    
    self.pageControl.currentPage = self.initialPage;
    
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * imageArray.count, self.scrollView.frame.size.height);
    
    [self scrollToImage];
}

- (IBAction)scrollToImage {
    // update the scroll view to the appropriate page
    
    NSLog(@"%d", self.pageControl.currentPage);
    
    CGRect frame;
    frame.origin.x = self.scrollView.frame.size.width * self.pageControl.currentPage;
    frame.origin.y = 0;
    frame.size = self.scrollView.frame.size;
    [self.scrollView scrollRectToVisible:frame animated:YES];
}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)sender {
    // Update the page when more than 50% of the previous/next page is visible
    CGFloat pageWidth = self.scrollView.frame.size.width;
    int page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    self.pageControl.currentPage = page;
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    visiblePageBeforeRotation = self.pageControl.currentPage;
    
}


#pragma mark orientation support delegate method
- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)  interfaceOrientation duration:(NSTimeInterval)duration
{
    
    NSLog(@"%f", self.scrollView.frame.size.height);
    
    
    self.scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * [imageArray count], self.scrollView.frame.size.height);
    self.scrollView.contentOffset = CGPointMake(visiblePageBeforeRotation * self.scrollView.bounds.size.width, 0);
    
    for (int i = 0; i < [imageArray count]; i++) {
        UIImageView *existingImageView = (UIImageView *)[self.scrollView viewWithTag:100+i];
        
        CGRect frame;
        frame.origin.x = self.scrollView.frame.size.width * i;
        frame.origin.y = 0;
        frame.size = self.scrollView.frame.size;
        
        existingImageView.frame = frame;
        
    }

    
//    self.pageControl.currentPage = self.initialPage;
//    
//    [self scrollToImage];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
