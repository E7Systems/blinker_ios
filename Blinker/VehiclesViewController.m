//
//  SecondViewController.m
//  Blinker
//
//  Created by Ryan Stickel on 11/13/13.
//  Copyright (c) 2013 Blinker. All rights reserved.
//

#import "VehiclesViewController.h"

@interface VehiclesViewController ()

@end

@implementation VehiclesViewController

@synthesize tbView = _tbView;
@synthesize vehiclesArray = _vehiclesArray;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.vehiclesArray = [[NSMutableArray alloc] init];
    
    NSArray *objects = [NSArray arrayWithObjects:@"2004" ,@"Nissan" ,@"350Z" ,@"$12,000" ,@"350z.jpg" , nil];
    NSArray *keys = [NSArray arrayWithObjects:@"year" ,@"make" ,@"model" ,@"price" ,@"thumbnail" , nil];
    
    NSDictionary *carDict = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
    [self.vehiclesArray addObject:carDict];
    
    NSArray *objects1 = [NSArray arrayWithObjects:@"2012" ,@"Toyota" ,@"Tacoma" ,@"$24,000" ,@"tacoma.jpg" , nil];
    NSArray *keys1 = [NSArray arrayWithObjects:@"year" ,@"make" ,@"model" ,@"price" ,@"thumbnail" , nil];
    
    NSDictionary *carDict1 = [NSDictionary dictionaryWithObjects:objects1 forKeys:keys1];
    [self.vehiclesArray addObject:carDict1];
    
    NSArray *objects2 = [NSArray arrayWithObjects:@"2001" ,@"Acura" ,@"MDX" ,@"$9,000" ,@"mdx.jpg" , nil];
    NSArray *keys2 = [NSArray arrayWithObjects:@"year" ,@"make" ,@"model" ,@"price" ,@"thumbnail" , nil];
    
    NSDictionary *carDict2 = [NSDictionary dictionaryWithObjects:objects2 forKeys:keys2];
    [self.vehiclesArray addObject:carDict2];
    
    NSArray *objects3 = [NSArray arrayWithObjects:@"2006" ,@"Honda" ,@"Accord" ,@"$12,000" ,@"accord.jpg" , nil];
    NSArray *keys3 = [NSArray arrayWithObjects:@"year" ,@"make" ,@"model" ,@"price" ,@"thumbnail" , nil];
    
    NSDictionary *carDict3 = [NSDictionary dictionaryWithObjects:objects3 forKeys:keys3];
    [self.vehiclesArray addObject:carDict3];
    
}

#pragma mark - Custom table view cell

//- (UITableViewCell *) getFirstCellContentView:(NSString *)cellIdentifier {
//    
//    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
//    
//    UIImageView *imageView = nil;
//    UILabel *carInfo = nil;
//    
//    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 60, 60)];
//    imageView.contentMode = UIViewContentModeScaleAspectFit;
//    imageView.tag = 1;
//    [cell.contentView addSubview:imageView];
//    
//    make.frame = CGRectMake(70, 5, <#CGFloat width#>, 30);
//    make.font = [UIFont boldSystemFontOfSize:13];
//    make.backgroundColor = [UIColor clearColor];
//    make.tag = 2;
//    [cell.contentView addSubview:make];
//    
//    model.font = [UIFont boldSystemFontOfSize:13];
//    model.backgroundColor = [UIColor clearColor];
//    model.tag = 3;
//    [cell.contentView addSubview:model];
//    
//    year.font = [UIFont boldSystemFontOfSize:13];
//    year.backgroundColor = [UIColor clearColor];
//    year.tag = 4;
//    [cell.contentView addSubview:year];
//    
//    price.font = [UIFont boldSystemFontOfSize:13];
//    price.backgroundColor = [UIColor clearColor];
//    price.tag = 5;
//    [cell.contentView addSubview:price];
//    
//    return cell;
//}


#pragma mark - Table view data source

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.vehiclesArray count];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 80;
    
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    NSString *carInfo = [NSString stringWithFormat:@"%@ %@ %@", [[self.vehiclesArray objectAtIndex:indexPath.row] objectForKey:@"year"], [[self.vehiclesArray objectAtIndex:indexPath.row] objectForKey:@"make"], [[self.vehiclesArray objectAtIndex:indexPath.row] objectForKey:@"model"]];
    
    cell.textLabel.text = carInfo;
    cell.detailTextLabel.text = [[self.vehiclesArray objectAtIndex:indexPath.row] objectForKey:@"price"];
    cell.imageView.image = [UIImage imageNamed:[[self.vehiclesArray objectAtIndex:indexPath.row] objectForKey:@"thumbnail"]];
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    
//    CorporateViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"CorporateViewController"];
//    
//    vc.navTitle = [[_content objectAtIndex:indexPath.row] objectForKey:@"headerTitle"];
//    vc.content = [[_content objectAtIndex:indexPath.row] objectForKey:@"rowValues"];
//    
//    [self.navigationController pushViewController:vc animated:YES];
    
}


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
