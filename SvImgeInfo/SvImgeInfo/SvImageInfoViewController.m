//
//  SvImageInfoViewController.m
//  SvImgeInfo
//
//  Created by  maple on 6/17/13.
//  Copyright (c) 2013 maple. All rights reserved.
//

#import "SvImageInfoViewController.h"
#import "SvImageInfoUtils.h"
#import "SvImageInfoEditUtils.h"

@interface SvImageInfoViewController ()

@end

@implementation SvImageInfoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = CGRectMake(0, 0, 140, 60);
    btn.center = CGPointMake(self.view.bounds.size.width / 2, self.view.bounds.size.height / 2);
    [btn setTitle:@"Load Image" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(loadImage:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadImage:(UIButton*)btn
{
    UIImage *image = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/Documents/DSC02040.JPG", NSHomeDirectory()]];

    NSLog(@"%f %f %f %d", image.size.width, image.size.height, image.scale, image.imageOrientation);

    CGImageRef imageRef = image.CGImage;
    NSLog(@"%zd %zd", CGImageGetWidth(imageRef), CGImageGetHeight(imageRef));

    UIImageView *imageV = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageV.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    imageV.backgroundColor = [UIColor redColor];
    imageV.image = image;
    imageV.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:imageV];
    [imageV release];
    
    UIImageWriteToSavedPhotosAlbum(imageV.image, nil, nil, nil);
}

@end
