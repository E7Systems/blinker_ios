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
@synthesize vehicleDict;

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
    
    testImages = [[NSMutableArray alloc] init];
    
    // Initialize recipe image array
    //NSArray *strImages = [NSArray arrayWithObjects:@"350z.jpg", @"accord.jpg", @"mdx.jpg", @"1.jpg", nil];
    
    NSString *url = [NSString stringWithFormat:@"http://blnkr-carrier.herokuapp.com/api/v1/images/%@?access_token=1c67d1634ec0798226b17a58b3fcbeebd07e753391ef9ed892a0cd459b067a5d", [vehicleDict objectForKey:@"VIN"]];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        
        //NSError *jsonError = nil;
        //id jsonObject = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:&jsonError];
        
        if ([responseObject isKindOfClass:[NSArray class]]) {
            NSArray *jsonArray = (NSArray *)responseObject;
            NSLog(@"jsonArray - %@",jsonArray);
            
            testImages = [NSMutableArray arrayWithArray:jsonArray];
            
            [self.colView reloadData];
        }
        else {
            NSLog(@"its probably a dictionary");
            NSDictionary *jsonDictionary = (NSDictionary *)responseObject;
            NSLog(@"jsonDictionary - %@",jsonDictionary);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
}


-(IBAction)showCameraAction:(id)sender
{
    UIImagePickerController *imagePickController=[[UIImagePickerController alloc]init];
    imagePickController.sourceType=UIImagePickerControllerSourceTypeCamera;
    imagePickController.delegate = self;
    imagePickController.allowsEditing=NO;
    [self.navigationController presentViewController:imagePickController animated:YES completion:nil];
}


#pragma mark - UIImagePickerControllerDelegate

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // Dismiss the image picker first to free its memory
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    NSLog(@"width: %f height: %f", image.size.width, image.size.height);
    
    UIImage *resizedImage = [image resizedImageToFitInSize:CGSizeMake(1024, 768) scaleIfSmaller:YES];
    
    NSLog(@"width: %f height: %f", resizedImage.size.width, resizedImage.size.height);
    
    [testImages addObject:resizedImage];
    
    [self.colView reloadData];
    
    NSData *imageToUpload = UIImageJPEGRepresentation(resizedImage, 90);
    
    NSDictionary *header = [NSDictionary dictionaryWithObjectsAndKeys:
                            @"1c67d1634ec0798226b17a58b3fcbeebd07e753391ef9ed892a0cd459b067a5d", @"access_token",
                            @"1", @"image_type_id",
                            nil];
    
    
    
    //UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    //NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //NSDictionary *parameters = @{@"foo": @"bar"};
    //NSURL *filePath = [NSURL fileURLWithPath:@"file://path/to/image.png"];
    [manager POST:@"http://blnkr-carrier.herokuapp.com/api/v1/images/99999" parameters:header constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        //[formData appendPartWithFileData:imageToUpload name:@"image" error:nil];
        [formData appendPartWithFileData:imageToUpload name:@"image" fileName:@"temp.jpeg" mimeType:@"image/jpeg"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Success: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    //Upload image async to server
}


#pragma mark - UICollectionView Datasource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    //NSLog(@"count: %d", [testImages count]);
    
    return [testImages count];
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"Cell";
    
    GalleryViewCell *cell = (GalleryViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    if ([[testImages objectAtIndex:indexPath.row] isKindOfClass:[UIImage class]]) {
        
        UIImageView *imageView = (UIImageView *)[cell viewWithTag:100];
        imageView.image = [testImages objectAtIndex:indexPath.row];
        
    } else {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^(void) {
            
            //NSString *key = [[venueDict objectForKey:@"logoUrl"] MD5Hash];
            //NSData *data = [FTWCache objectForKey:key];
            
            UIImage *image = nil;
            
            NSString *url = [[testImages objectAtIndex:indexPath.row] objectForKey:@"path_small"];
            
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
            //[FTWCache setObject:data forKey:key];
            image = [UIImage imageWithData:data];
            
            dispatch_sync(dispatch_get_main_queue(), ^(void) {
                UIImageView *imageView = (UIImageView *)[cell viewWithTag:100];
                imageView.image = image;
                [cell setNeedsLayout];
            });
        });
        
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
