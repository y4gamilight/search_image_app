//
//  API.m
//  SearchImageApp
//
//  Created by DELL7447 on 9/21/17.
//  Copyright © 2017 y4gamilight. All rights reserved.
//

#import "API.h"

// General parameters
NSString * const APIResponseResultKey = @"Response";
NSString * const APIResponseErrorKey = @"error";
NSString * const APIResponseStatusKey = @"status";

@interface API ()

@end

@implementation API

#pragma mark - Initialization

/*!
 *  @brief  Initial APIManager
 *
 *  @return APIManager object
 */
- (instancetype)init {
    self = [super init];
    return self;
}

/**
 *
 *  Return a common request parameters.
 *  @return common request parameters.
 */
- (NSDictionary *)commonRequestParameters {
    
    NSMutableDictionary *paramters = @{}.mutableCopy;
    return paramters;
}

/**
 *
 *  Methods for child class implement
 *  @param code     ResposeCode with Error Code
 *  @param userInfo user Infomation
 */
- (void)handleAPIErrorWithCode:(APIResponseCode)code userInfo:(NSDictionary *)userInfo {
    switch (code) {
        case APIResponseCodeAppVersionError:
        case APIResponseCodeDBError:
        case APIResponseCodeMaintenance:
        case APIResponseCodeAppAuthError:
        case APIResponseCodeAPIVersionError:
        case APIResponseCodeParameterError:
        case APIResponseCodeUserNotExist:
        case APIResponseCodeUnexpectedError:
        default: {
            // Show error dialog
            NSString *error = userInfo[APIResponseErrorKey];
            if (error) {
                error = NSLocalizedString(@"ErrorAPIMessage", nil);
            }
            
            [GlobalMethods showMessageWithTitle:error withTitle:NSLocalizedString(@"ErrorAPITitle", nil)];
        }
            break;
    }
}

#pragma mark - Request API

/**
 *  Methods for child class implement
 *  @param options parameters
 *  @param success success block
 *  @param failure failure block
 */
- (void)requestWithOptions:(NSDictionary *)options success:(APISuccessBlock)success failure:(APIFailureBlock)failure {
}

@end
