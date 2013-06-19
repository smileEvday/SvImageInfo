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
    
    NSString *str = [[NSBundle mainBundle] pathForResource:@"DSC02039" ofType:@"JPG"];
    NSURL *fileUrl = [NSURL fileURLWithPath:str];
    
    SvImageInfoEditUtils *editUtils = [[SvImageInfoEditUtils alloc] initWithURL:fileUrl];
    [editUtils setImageOrientation:UIImageOrientationDown];
    [editUtils release];
    
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageV.image = [UIImage imageNamed:@"DSC02039.JPG"];
    imageV.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:imageV];
    [imageV release];
    
    SvImageInfoUtils *imageInfoUtils = [[SvImageInfoUtils alloc] initWithURL:fileUrl];
    
    NSLog(@"image size: %d", [imageInfoUtils fileSize]);
    NSLog(@"image type: %@", [imageInfoUtils fileType]);
    NSLog(@"image exif info: %@", [imageInfoUtils exifDictionary]);
    NSLog(@"image tiff info: %@", [imageInfoUtils tiffDictonary]);
    
    [imageInfoUtils release];
    
    
    
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
