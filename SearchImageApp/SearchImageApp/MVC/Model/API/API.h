//
//  API.h
//  SearchImageApp
//
//  Created by DELL7447 on 9/21/17.
//  Copyright © 2017 y4gamilight. All rights reserved.
//
#import <AFNetworking/AFNetworking.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import <Foundation/Foundation.h>

//Libraries

@class API;
typedef void (^APISuccessBlock)(API *sender, id result);
typedef void (^APIFailureBlock)(API *sender, NSError * error);

/*!
 *  @brief  Response code return from API
 */
typedef NS_ENUM(NSInteger, APIResponseCode) {
    APIResponseCodeOK = 200,
    APIResponseCodeDBError = 10,
    APIResponseCodeMaintenance = 20,
    APIResponseCodeAppAuthError = 30,
    APIResponseCodeAPIVersionError = 40,
    APIResponseCodeAppVersionError = 50,
    APIResponseCodeParameterError = 60,
    APIResponseCodeUserNotExist = 70,
    APIResponseCodeUnexpectedError = 90,
};

extern NSString * const APIResponseResultKey;
extern NSString * const APIResponseErrorKey;
extern NSString * const APIResponseStatusKey;

@interface API : NSObject

@property (nonatomic) AFHTTPSessionManager *sessionManager;

- (NSDictionary *)commonRequestParameters;

- (void)handleAPIErrorWithCode:(APIResponseCode)code userInfo:(NSDictionary *)userInfo;

- (void)requestWithOptions:(NSDictionary *)options success:(APISuccessBlock)success failure:(APIFailureBlock)failure;

@end
