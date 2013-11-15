//
//  SecondViewController.h
//  Blinker
//
//  Created by Ryan Stickel on 11/13/13.
//  Copyright (c) 2013 Blinker. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VehiclesViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) IBOutlet UITableView *tbView;
@property (nonatomic, strong) NSMutableArray *vehiclesArray;

@end
