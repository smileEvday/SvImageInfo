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
    NSMutableDictionary   *_newImageInfoDictonary;
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
        
        _newImageInfoDictonary = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}

- (void)dealloc
{
    if (_imageDestination != NULL) {
        [self save];
        CFRelease(_imageDestination);
    }
        
    [_newImageInfoDictonary release];
    
    [super dealloc];
}

- (void)setImageOrientation:(ExifOrientation)newOrientation
{
    [_newImageInfoDictonary setValue:[NSNumber numberWithInteger:newOrientation] forKey:(NSString*)kCGImagePropertyOrientation];
}

- (void)setTiffOrientation:(ExifOrientation)newOrientation
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:[self tiffDictonary]];
    [dict setValue:[NSNumber numberWithInteger:newOrientation] forKey:(NSString*)kCGImagePropertyTIFFOrientation];
    
    [_newImageInfoDictonary setValue:dict forKey:(NSString*)kCGImagePropertyTIFFDictionary];
}

- (void)save
{
    NSDictionary *dict = (NSDictionary*)CGImageSourceCopyPropertiesAtIndex(_imageRef, 0, NULL);
    NSMutableDictionary *dictInfo = [NSMutableDictionary dictionaryWithDictionary:dict];
    
    // modify dict before add
    
    // modify orientation
    [dictInfo setValue:[_newImageInfoDictonary valueForKey:(NSString *)kCGImagePropertyOrientation] forKey:(NSString*)kCGImagePropertyOrientation];
    
    // modify tiff orientation
    NSMutableDictionary *tiffDict = [NSMutableDictionary dictionaryWithDictionary:[_newImageInfoDictonary valueForKey:(NSString*)kCGImagePropertyTIFFDictionary]];
    [dictInfo setValue:tiffDict forKey:(NSString*)kCGImagePropertyTIFFDictionary];
    
    CGImageDestinationAddImageFromSource(_imageDestination, _imageRef, 0, (CFDictionaryRef)dictInfo);
    CGImageDestinationFinalize(_imageDestination);
}

@end
