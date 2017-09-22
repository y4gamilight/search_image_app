//
//  SearchImageAPI.m
//  SearchImageApp
//
//  Created by DELL7447 on 9/21/17.
//  Copyright © 2017 y4gamilight. All rights reserved.
//

#import "SearchImageAPI.h"

@implementation SearchImageAPI

#pragma mark - Singleton

/**
 *
 *  share GetSearchDataAPI instance
 *  @return GetSearchDataAPI instance
 */
+ (instancetype)sharedObject {
    static SearchImageAPI *sharedObject = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedObject = [[self alloc] init];
    });
    return sharedObject;
}

#pragma mark - Initialization

/*!
 *  @brief  Initialize GetSearchDataAPI
 *
 *  @return GetSearchDataAPI object
 */
- (instancetype)init {
    self = [super init];
    if (self) {
        self.sessionManager = [AFHTTPSessionManager manager];
        _responseArray = [[NSMutableArray alloc] init];
    }
    return self;
}

#pragma mark - Request API

/**
 *  send a GET request
 *  @param options contains: parameters
 *  @param success success block
 *  @param failure failure block
 */
- (void)requestWithOptions:(NSDictionary *)options success:(APISuccessBlock)success failure:(APIFailureBlock)failure {
    
//    [MBProgressHUD showHUDAddedTo:DEVICE_WINDOW animated:YES];
    
    // Check network and return if "have a warning"
    if ([GlobalMethods warningLossConnection]) {
//        [MBProgressHUD hideHUDForView:DEVICE_WINDOW animated:YES];
        return;
    }
    
    [AFHTTPSessionManager manager].responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    
    // Get URL
    NSString *urlString = [URL_DOMAIN_ROOT stringByAppendingString:CUSTOM_SEARCH_WITH_KEY];
    
    // Call GET method
    [[AFHTTPSessionManager manager] GET:urlString parameters:options progress:nil success:^(NSURLSessionDataTask *operation, id responseObject) {
        
        // Check the API response and handle it (code = ERROR)
        APIResponseCode code = (int)((NSHTTPURLResponse *)operation.response).statusCode;
        if (code != APIResponseCodeOK) {
            [self handleAPIErrorWithCode:code userInfo:@{}.mutableCopy];
            [MBProgressHUD hideHUDForView:DEVICE_WINDOW animated:YES];
            return;
        }
        
        // Handle response data (code = APIResponseCodeOK)
        
        if(success) {
            success(self, responseObject);
        }
//        [MBProgressHUD hideHUDForView:DEVICE_WINDOW animated:YES];
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        if (failure) {
            failure(self, error);
        }
        
//        [MBProgressHUD hideHUDForView:DEVICE_WINDOW animated:YES];
        // Show retry alert
//        [GlobalMethods showRetryMessage:NSLocalizedString(@"ErrorAPIMessage", nil) withHandler:^(UIAlertAction *action) {
//            [self requestWithOptions:nil success:success failure:failure];
//        }];
    }];
}


@end
