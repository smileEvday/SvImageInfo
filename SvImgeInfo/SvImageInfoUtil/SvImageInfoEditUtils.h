//
//  SvImageInfoEditUtils.h
//  SvImgeInfo
//
//  Created by  maple on 6/19/13.
//  Copyright (c) 2013 maple. All rights reserved.
//
//  the util class to modify image info 

#import "SvImageInfoUtils.h"

@interface SvImageInfoEditUtils : SvImageInfoUtils

/*
 * @brief set image's orientation
 */
- (void)setImageOrientation:(ExifOrientation)newOrientation;

/*
 * @brief save modify to image file
 */
- (void)save;

@end
