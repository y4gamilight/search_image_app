//
//  Constants.h
//  SearchImageApp
//
//  Created by DELL7447 on 9/21/17.
//  Copyright © 2017 y4gamilight. All rights reserved.
//

#ifndef ConstantsApp_h
#define ConstantsApp_h

#ifdef COCOAPODS

// Pods
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <UIImageView+AFNetworking.h>
#import <AFNetworking/AFNetworking.h>
#endif
/**************************************************************************************************************/

// Device Constants

#define DEVICE_UUID                                     [[[UIDevice currentDevice] identifierForVendor] UUIDString]
#define DEVICE_DELEGATE                                 [[UIApplication sharedApplication] delegate]
#define DEVICE_WINDOW                                   [[[UIApplication sharedApplication] delegate] window]
#define DEVICE_BOUNDS                                   [UIScreen mainScreen].bounds
#define DEVICE_WIDTH                                    [UIScreen mainScreen].bounds.size.width
#define DEVICE_HEIGHT                                   [UIScreen mainScreen].bounds.size.height
#define DISPLAY_SCALE                                   ((DEVICE_WIDTH < DEVICE_HEIGHT)?(DEVICE_WIDTH) / 320.0f:(DEVICE_HEIGHT) / 320.0f)
#define DISPLAY_SCALE_IPAD                                   ((DEVICE_WIDTH < DEVICE_HEIGHT)?(DEVICE_WIDTH) / 768.0:(DEVICE_HEIGHT) / 768.0)

#define VERSION                                         [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey]

#define IS_WIDESCREEN                                   ((double)[[UIScreen mainScreen] bounds].size.height >= (double)568.0)
#define IS_IOS8                                         [[UIDevice currentDevice].systemVersion floatValue] >= 8.0f
#define IS_IOS9                                         [[UIDevice currentDevice].systemVersion floatValue] >= 9.0f
#define IS_IPHONE                                       (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
/**************************************************************************************************************/

// Log
#ifdef DEBUG

#define XLOG_TAG_
#define XLOG_FATAL   0
#define XLOG_ERROR   1
#define XLOG_WARNING 2
#define XLOG_INFO    3
#define XLOG_DEBUG   4
#define XLOG_TRACE   5

#define XLog(tag,level,...) NSLog(__VA_ARGS__)

#else

#define XLog(...) do{}while(0)
#define XLogData(...) do{}while(0)
#define XLogImage(...) do{}while(0)
#define XLogMarker(...) do{}while(0)

#endif
/**************************************************************************************************************/

#endif /* ConstantsApp_h */
