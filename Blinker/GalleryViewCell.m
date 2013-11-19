//
//  GalleryViewCell.m
//  Blinker
//
//  Created by Ryan Stickel on 11/18/13.
//  Copyright (c) 2013 Blinker. All rights reserved.
//

#import "GalleryViewCell.h"

@implementation GalleryViewCell

@synthesize imageView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        // self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pic_frame.png"]];
    }
    return self;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
