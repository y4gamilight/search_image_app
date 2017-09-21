//
//  GlobalMethods.h
//  SearchImageApp
//
//  Created by admin on 3/10/16.
//  Copyright © 2016 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
//Libraries
#import "CheckNetwork.h"

@interface GlobalMethods : NSObject

#pragma mark - Show Message Methods
+ (void)showMessage:(NSString *)message;
+ (void)showMessageWithTitle:(NSString *)message withTitle:(NSString *)title;
+ (void)showRetryMessage:(NSString *)message withHandler:(void (^)(UIAlertAction *action))handler;

#pragma mark - API Support Methods
+ (BOOL)isConnectionAvailable;
+ (BOOL)warningLossConnection;

@end
