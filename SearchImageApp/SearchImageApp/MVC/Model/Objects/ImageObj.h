//
//  ImageObj.h
//  SearchImageApp
//
//  Created by DELL7447 on 9/21/17.
//  Copyright © 2017 y4gamilight. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageObj : JSONModel
/*
 "image": {
    "contextLink": "https://vimeo.com/user2082250",
    "height": 300,
    "width": 300,
    "byteSize": 3801,
    "thumbnailLink": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR_ttK8NlBgui_JndBj349UxZx0kHn0Z-Essswci-_5UQCmUOruY1PNl3M",
    "thumbnailHeight": 116,
    "thumbnailWidth": 116
 }
 */

@property (nonatomic, strong) NSString  <Optional>*contextLink;
@property (nonatomic, strong) NSString  <Optional>*height;
@property (nonatomic, strong) NSString  <Optional>*width;
@property (nonatomic, strong) NSString  <Optional>*byteSize;
@property (nonatomic, strong) NSString  <Optional>*thumbnailLink;
@property (nonatomic, strong) NSString  <Optional>*thumbnailHeight;
@property (nonatomic, strong) NSString  <Optional>*thumbnailWidth;
@end
