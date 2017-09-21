//
//  ResultObj.h
//  SearchImageApp
//
//  Created by DELL7447 on 9/21/17.
//  Copyright © 2017 y4gamilight. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ImageObj.h"
/*
 "kind": "customsearch#result",
 "title": "TEST on Vimeo",
 "htmlTitle": "\u003cb\u003eTEST\u003c/b\u003e on Vimeo",
 "link": "https://i.vimeocdn.com/portrait/58832_300x300",
 "displayLink": "vimeo.com",
 "snippet": "TEST on Vimeo",
 "htmlSnippet": "\u003cb\u003eTEST\u003c/b\u003e on Vimeo",
 "mime": "image/",
 "image": {
 ....
 ....
 ....
 }
 */
@interface ResultObj : JSONModel

@property (nonatomic, strong) NSString  <Optional>*kind;
@property (nonatomic, strong) NSString  <Optional>*title;
@property (nonatomic, strong) NSString  <Optional>*htmlTitle;
@property (nonatomic, strong) NSString  <Optional>*link;
@property (nonatomic, strong) NSString  <Optional> *displayLink;
@property (nonatomic, strong) NSString  <Optional>*snippet;
@property (nonatomic, strong) NSString  <Optional>*htmlSnippet;
@property (nonatomic, strong) NSString  <Optional>*mime;
@property (nonatomic, strong) ImageObj  <Optional>*image;
@end
