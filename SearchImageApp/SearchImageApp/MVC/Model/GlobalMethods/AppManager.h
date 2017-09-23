//
//  AppManager.h
//  SearchImageApp
//
//  Created by DELL7447 on 9/23/17.
//  Copyright © 2017 y4gamilight. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppManager : NSObject

@property (nonatomic,strong) NSString *keyGoogleAPICurrent;
@property (nonatomic) NSInteger numberkeyGoogleAPIChecked;
@property (nonatomic, strong) NSArray *arrayKeyGoogleAPI;

+(AppManager*)share;
@end
