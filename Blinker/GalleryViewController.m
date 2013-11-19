//
//  GalleryViewController.m
//  Blinker
//
//  Created by Ryan Stickel on 11/14/13.
//  Copyright (c) 2013 Blinker. All rights reserved.
//

#import "GalleryViewController.h"
#import "GalleryViewCell.h"
#import "GallerySliderViewController.h"

@interface GalleryViewController () {

    NSMutableArray *testImages;
}

@end

@implementation GalleryViewController

@synthesize colView = _colView;

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
    
    // Initialize recipe image array
    NSArray *strImages = [NSArray arrayWithObjects:@"350z.jpg", @"accord.jpg", @"mdx.jpg", @"1.jpg", nil];
    
    testImages = [[NSMutableArray alloc] initWithArray:strImages];
}


-(IBAction)showCameraAction:(id)sender
{
    UIImagePickerController *imagePickController=[[UIImagePickerController alloc]init];
    imagePickController.sourceType=UIImagePickerControllerSourceTypeCamera;
    imagePickController.delegate = self;
    imagePickController.allowsEditing=TRUE;
    [self.navigationController presentViewController:imagePickController animated:YES completion:nil];
}


#pragma mark - UIImagePickerControllerDelegate

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    
    [testImages addObject:image];
    
    [self.colView reloadData];
    
    //Upload image async to server
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - UICollectionView Datasource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    NSLog(@"count: %d", [testImages count]);
    
    return [testImages count];
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"Cell";
    
    GalleryViewCell *cell = (GalleryViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    if ([[testImages objectAtIndex:indexPath.row] isKindOfClass:[NSString class]]) {
        
        UIImageView *imageView = (UIImageView *)[cell viewWithTag:100];
        imageView.image = [UIImage imageNamed:[testImages objectAtIndex:indexPath.row]];
        
    } else if ([[testImages objectAtIndex:indexPath.row] isKindOfClass:[UIImage class]]) {
        
        UIImageView *imageView = (UIImageView *)[cell viewWithTag:100];
        imageView.image = [testImages objectAtIndex:indexPath.row];
        
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    GallerySliderViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"GallerySliderViewController"];
    
    vc.imageArray = testImages;
    vc.initialPage = indexPath.row;
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
