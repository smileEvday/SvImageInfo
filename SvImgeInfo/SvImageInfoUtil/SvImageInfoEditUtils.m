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
        _imageDestination = CGImageDestinationCreateWithURL((CFURLRef)imageUrl, imagUTI, 1, NULL);
        
        _newImageInfoDictonary = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}

- (void)dealloc
{
    if (_imageDestination != NULL) {
        [self save];
    }
    
    CFRelease(_imageDestination);
    
    [_newImageInfoDictonary release];
    
    [super dealloc];
}

- (void)setImageOrientation:(UIImageOrientation)newOrientation
{
    [_newImageInfoDictonary setValue:[NSNumber numberWithInteger:newOrientation] forKey:(NSString*)kCGImagePropertyOrientation];
}

- (void)setTiffOrientation:(UIImageOrientation)newOrientation
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

    
//    CGImageDestinationAddImageFromSource(_imageDestination, _imageRef, 0, <#CFDictionaryRef properties#>)
    
    CGImageDestinationFinalize(_imageDestination);
}

@end
