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
    
    NSURL *fileUrl = [[NSBundle mainBundle] URLForResource:@"DSC02039" withExtension:@"JPG"];
    
    NSLog(@"%@", NSHomeDirectory());
    
    SvImageInfoEditUtils *editUtils = [[SvImageInfoEditUtils alloc] initWithURL:fileUrl];
    [editUtils setImageOrientation:exifOrientationDown];
    [editUtils setTiffOrientation:exifOrientationDown];
    [editUtils release];
    
    SvImageInfoUtils *imageInfoUtils = [[SvImageInfoUtils alloc] initWithURL:fileUrl];
    
    NSLog(@"image size: %d", [imageInfoUtils fileSize]);
    NSLog(@"image type: %@", [imageInfoUtils fileType]);
    NSLog(@"image exif info: %@", [imageInfoUtils exifDictionary]);
    NSLog(@"image tiff info: %@", [imageInfoUtils tiffDictonary]);
    
    [imageInfoUtils release];
    
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageV.image = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/Documents/DSC02040.JPG", NSHomeDirectory()]];
    imageV.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:imageV];
    [imageV release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
