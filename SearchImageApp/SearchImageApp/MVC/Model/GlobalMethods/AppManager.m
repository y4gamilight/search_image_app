//
//  AppManager.m
//  SearchImageApp
//
//  Created by DELL7447 on 9/23/17.
//  Copyright © 2017 y4gamilight. All rights reserved.
//

#import "AppManager.h"


@implementation AppManager
+(AppManager*)share {
    static AppManager *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[AppManager alloc] init];
        _instance.keyGoogleAPICurrent = GOOGLE_KEY_API_ENABLE;
        
        _instance.arrayKeyGoogleAPI = @[GOOGLE_KEY_API_ENABLE,
                                        GOOGLE_KEY_API_ENABLE_2,
                                        GOOGLE_KEY_API_ENABLE_3,
                                        GOOGLE_KEY_API_ENABLE_4,
                                        GOOGLE_KEY_API_ENABLE_5];
        _instance.numberkeyGoogleAPIChecked = 0;
    });
    return _instance;
}

@end
