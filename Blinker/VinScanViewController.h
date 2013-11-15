//
//  FirstViewController.h
//  Blinker
//
//  Created by Ryan Stickel on 11/13/13.
//  Copyright (c) 2013 Blinker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBarSDK.h"

@interface VinScanViewController : UIViewController <ZBarReaderDelegate> {
    UIImageView *resultImage;
    UITextField *resultText;
}

@property (nonatomic, retain) IBOutlet UIImageView *resultImage;
@property (nonatomic, retain) IBOutlet UITextField *resultText;

- (IBAction) scanButtonTapped;

@end
