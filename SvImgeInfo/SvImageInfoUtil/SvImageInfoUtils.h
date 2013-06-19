//
//  SvImageInfoUtils.h
//  SvImgeInfo
//
//  Created by  maple on 6/19/13.
//  Copyright (c) 2013 maple. All rights reserved.
//
//  The util class to obtain image's exif info

#import <Foundation/Foundation.h>
#import <ImageIO/ImageIO.h>

@interface SvImageInfoUtils : NSObject {
    CGImageSourceRef _imageRef;
}

- (id)initWithURL:(NSURL*)imageUrl;

/*
 * @brief get filesize info
 */
- (NSInteger)fileSize;

/*
 * @brief get user-readable type description
 */
- (NSString*)fileType;

/*
 * @brief
 */
- (int)colorDepth;

/*
 * @brief get image's colorspacemodel
 */
- (NSString*)colorModel;

/*
 * @brief get image's orientation
 */
- (UIImageOrientation)imageOrientation;


- (int)dpiWidth;
- (int)dpiHeight;
- (int)pixelWidth;
- (int)pixelHeight;

/*
 * @brief get the tiff dictionary about image
 */
- (NSDictionary*)tiffDictonary;

/*
 * @brief get the exif dictionary about image
 */
- (NSDictionary*)exifDictionary;

@end
