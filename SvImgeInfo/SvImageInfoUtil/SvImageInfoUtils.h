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

// http://www.impulseadventure.com/photo/exif-orientation.html
// Virtually all Canon and Nikon digital cameras have an orientation sensor.
// The output of this sensor is used to set the EXIF orientation flag in the image file's metatdata
// to reflect the positioning of the camera with respect to the ground. Canon calls their
// sensor the "Intelligent Orientation" sensor. It is presumably a 2-axis tilt sensor,
// allowing 4 possible orientations to be detected (shown in the left side of the diagram below).
// Note that one would only expect the four orientation settings shown on the left to be
// possible with a digital camera. The other four settings would imply that the
// resulting image was flipped horizontally before recording. Unless the camera were to
// encode the image right-to-left or know that you were taking a photo in a mirror,
// I don't see how these values will ever be used.


enum {
    exifOrientationUp = 1,      // UIImageOrientationUp
    exifOrientationDown = 3,    // UIImageOrientationDown
    exifOrientationLeft = 6,    // UIImageOrientationLeft
    exifOrientationRight = 8,   // UIImageOrientationRight
    
    // these four exifOrientation does not support by all camera, but IOS support these orientation
    exifOrientationUpMirrored = 2,          // UIImageOrientationUpMirrored
    exifOrientationDownMirrored = 4,        // UIImageOrientationDownMirrored
    exifOrientationLeftMirrored = 5,        // UIImageOrientationLeftMirrored
    exifOrientationRightMirrored = 7,       // UIImageOrientationRightMirrored
};
typedef NSInteger ExifOrientation;


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
