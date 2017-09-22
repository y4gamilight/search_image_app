//
//  SearchImageAPI.h
//  SearchImageApp
//
//  Created by DELL7447 on 9/21/17.
//  Copyright © 2017 y4gamilight. All rights reserved.
//
#import "API.h"


@interface SearchImageAPI : API

@property (nonatomic, readonly) NSMutableArray *responseArray;

#pragma mark - Singleton

+ (instancetype)sharedObject;

#pragma mark - Public Methods

- (void)requestWithOptions:(NSDictionary *)options success:(APISuccessBlock)success failure:(APIFailureBlock)failure;
@end


