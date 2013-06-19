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
- (void)setImageOrientation:(UIImageOrientation)newOrientation;

/*
 * @brief set orientation in tiff info
 */
- (void)setTiffOrientation:(UIImageOrientation)newOrientation;

/*
 * @brief save modify to image file
 */
- (void)save;

@end
