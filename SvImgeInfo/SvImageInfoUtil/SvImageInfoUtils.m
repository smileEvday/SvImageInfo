//
//  SvImageInfoUtils.m
//  SvImgeInfo
//
//  Created by  maple on 6/19/13.
//  Copyright (c) 2013 maple. All rights reserved.
//


#import "SvImageInfoUtils.h"
#import <MobileCoreServices/MobileCoreServices.h>

@interface SvImageInfoUtils () {
    NSDictionary     *_imageProperty;
}

@end

@implementation SvImageInfoUtils

- (id)initWithURL:(NSURL*)imageUrl
{
    self = [super init];
    if (self) {
        _imageRef = CGImageSourceCreateWithURL((CFURLRef)imageUrl, NULL);
        _imageProperty = (NSDictionary*)CGImageSourceCopyPropertiesAtIndex(_imageRef, 0, NULL);
    }
    
    return self;
}

- (void)dealloc
{
    if (_imageRef != NULL) {
        CFRelease(_imageRef);
    }
    
    [_imageProperty release];
    
    [super dealloc];
}

- (NSInteger)fileSize
{
    CFDictionaryRef dict = CGImageSourceCopyProperties(_imageRef, NULL);
    CFNumberRef fileSize = (CFNumberRef)CFDictionaryGetValue(dict, kCGImagePropertyFileSize);
    
    CFNumberType type = CFNumberGetType(fileSize);
    
    int size = 0;
    if (type == kCFNumberSInt32Type) {
        CFNumberGetValue(fileSize, type, &size);
    }
    
    CFRelease(dict);
    
    return 0;
}

- (NSString*)fileType
{
    CFStringRef fileUTI = CGImageSourceGetType(_imageRef);
    NSLog(@"type Ref: %@", fileUTI);
    
    CFStringRef fileTypeDes = UTTypeCopyDescription(fileUTI);
    NSString *typeRef = (NSString*)fileTypeDes;
    [typeRef retain];
    
    CFRelease(fileTypeDes);
    return [typeRef autorelease];
}

- (int)colorDepth
{
    return [[_imageProperty valueForKey:(NSString*)kCGImagePropertyDepth] intValue];
}

- (NSString*)colorModel
{
    return [_imageProperty valueForKey:(NSString*)kCGImagePropertyColorModel];
}

- (UIImageOrientation)imageOrientation
{
    return [[_imageProperty valueForKey:(NSString*)kCGImagePropertyOrientation] intValue];
}

- (int)dpiWidth
{
    return [[_imageProperty valueForKey:(NSString*)kCGImagePropertyDPIWidth] intValue];
}

- (int)dpiHeight
{
    return [[_imageProperty valueForKey:(NSString*)kCGImagePropertyDPIHeight] intValue];
}

- (int)pixelWidth
{
    return [[_imageProperty valueForKey:(NSString*)kCGImagePropertyPixelWidth] intValue];
}

- (int)pixelHeight
{
    return [[_imageProperty valueForKey:(NSString*)kCGImagePropertyPixelHeight] intValue];
}

- (NSDictionary*)tiffDictonary
{    
    return [_imageProperty valueForKey:(NSString*)kCGImagePropertyTIFFDictionary];
}

- (NSDictionary*)exifDictionary
{
    return [_imageProperty valueForKey:(NSString*)kCGImagePropertyExifDictionary];
}

@end
