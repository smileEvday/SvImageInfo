//
//  SvImageInfoEditUtils.m
//  SvImgeInfo
//
//  Created by  maple on 6/19/13.
//  Copyright (c) 2013 maple. All rights reserved.
//

#import "SvImageInfoEditUtils.h"

@interface SvImageInfoEditUtils () {
    CGImageDestinationRef _imageDestination;
    NSInteger             _newImageOrientation;
}

@end

@implementation SvImageInfoEditUtils

- (id)initWithURL:(NSURL *)imageUrl
{
    self = [super initWithURL:imageUrl];
    if (self) {
        CFStringRef imagUTI = CGImageSourceGetType(_imageRef);
        
        NSURL *newFileUrl = [[NSURL alloc] initFileURLWithPath:[NSString stringWithFormat:@"%@/Documents/DSC02040.JPG", NSHomeDirectory()]];
        _imageDestination = CGImageDestinationCreateWithURL((CFURLRef)newFileUrl, imagUTI, 1, NULL);
        
        _newImageOrientation = -1;  // never set orientation
    }
    
    return self;
}

- (void)dealloc
{
    if (_imageDestination != NULL) {
        [self save];
        CFRelease(_imageDestination);
    }
    
    [super dealloc];
}

- (void)setImageOrientation:(ExifOrientation)newOrientation
{
    _newImageOrientation = newOrientation;
}

- (void)save
{
    NSDictionary *dict = (NSDictionary*)CGImageSourceCopyPropertiesAtIndex(_imageRef, 0, NULL);
    NSMutableDictionary *dictInfo = [NSMutableDictionary dictionaryWithDictionary:dict];
    
    // modify dict before add
    
    NSInteger currentOrientation = [[dict valueForKey:(NSString*)kCGImagePropertyOrientation] intValue];
    
    // if the new Orientation has changed, we should exchange width and height
    if (_newImageOrientation != -1 && currentOrientation != _newImageOrientation) {
        
        NSInteger pixelWidth = [[dict valueForKey:(NSString*)kCGImagePropertyPixelWidth] intValue];
        NSInteger pixelHeight = [[dict valueForKey:(NSString*)kCGImagePropertyPixelHeight] intValue];
        NSMutableDictionary *exifDictInfo = [NSMutableDictionary dictionaryWithDictionary:[dictInfo valueForKey:(NSString *)kCGImagePropertyExifDictionary]];
        
        if ((currentOrientation == exifOrientationUp || currentOrientation == exifOrientationUpMirrored
             || currentOrientation == exifOrientationDown || currentOrientation == exifOrientationDownMirrored)) {
            if (_newImageOrientation == exifOrientationUp
                || _newImageOrientation == exifOrientationUpMirrored
                || _newImageOrientation == exifOrientationDown
                || _newImageOrientation == exifOrientationDownMirrored) {
                // need not exchange width and height
            }
            else {
                [dictInfo setValue:[NSNumber numberWithInteger:pixelHeight] forKey:(NSString*)kCGImagePropertyPixelWidth];
                [dictInfo setValue:[NSNumber numberWithInteger:pixelWidth] forKey:(NSString*)kCGImagePropertyPixelHeight];
                
                [exifDictInfo setValue:[NSNumber numberWithInteger:pixelHeight] forKey:(NSString*)kCGImagePropertyExifPixelXDimension];
                [exifDictInfo setValue:[NSNumber numberWithInteger:pixelWidth] forKey:(NSString*)kCGImagePropertyExifPixelYDimension];
            }
        }
        else if ((currentOrientation == exifOrientationLeft || currentOrientation == exifOrientationLeftMirrored
                  || currentOrientation == exifOrientationRight || currentOrientation == exifOrientationRightMirrored)) {
            if (_newImageOrientation == exifOrientationLeft
                || _newImageOrientation == exifOrientationLeftMirrored
                || _newImageOrientation == exifOrientationRight
                || _newImageOrientation == exifOrientationRightMirrored) {
                // need not exchange width and height
            }
            else {
                [dictInfo setValue:[NSNumber numberWithInteger:pixelHeight] forKey:(NSString*)kCGImagePropertyPixelWidth];
                [dictInfo setValue:[NSNumber numberWithInteger:pixelWidth] forKey:(NSString*)kCGImagePropertyPixelHeight];
                
                [exifDictInfo setValue:[NSNumber numberWithInteger:pixelHeight] forKey:(NSString*)kCGImagePropertyExifPixelXDimension];
                [exifDictInfo setValue:[NSNumber numberWithInteger:pixelWidth] forKey:(NSString*)kCGImagePropertyExifPixelYDimension];
            }
        }
        
        // modify orientation
        [dictInfo setValue:[NSNumber numberWithInteger:_newImageOrientation]forKey:(NSString*)kCGImagePropertyOrientation];
        [dictInfo setValue:exifDictInfo forKey:(NSString*)kCGImagePropertyExifDictionary];
    }
    
    CGImageDestinationAddImageFromSource(_imageDestination, _imageRef, 0, (CFDictionaryRef)dictInfo);
    CGImageDestinationFinalize(_imageDestination);
}

@end
