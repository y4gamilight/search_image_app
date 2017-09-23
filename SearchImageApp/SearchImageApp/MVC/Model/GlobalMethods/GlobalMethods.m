//
//  GlobalMethods.m
//  SearchImageApp
//
//  Created by admin on 3/10/16.
//  Copyright © 2016 admin. All rights reserved.
//

#import "GlobalMethods.h"

@implementation GlobalMethods
#pragma mark - Show Message Methods

/*!
 *  @author hoangnn, 03/23/16
 *  Description: Show alert message
 */
+ (void)showMessage:(NSString *)message {
    // IOS8 and later
    if (IS_IOS8) {
        UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@""
                                                                                  message:message
                                                                           preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"OK", nil)
                                                                style:UIAlertActionStyleDefault
                                                              handler:nil];
        [alertController addAction:cancelAction];
        [DEVICE_WINDOW.rootViewController presentViewController:alertController animated:YES completion:nil];
        alertController = nil;
        cancelAction = nil;
    }
}

/*!
 *  Description: Show alert message with title
 */
+ (void)showMessageWithTitle:(NSString *)message withTitle:(NSString *)title {
    // IOS8 and later
    if (IS_IOS8) {
        UIAlertController * alertController = [UIAlertController alertControllerWithTitle:title
                                                                                  message:message
                                                                           preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"OK", nil)
                                                                style:UIAlertActionStyleDefault
                                                              handler:nil];
        [alertController addAction:cancelAction];
        [DEVICE_WINDOW.rootViewController presentViewController:alertController animated:YES completion:nil];
        alertController = nil;
        cancelAction = nil;
    }
}

/*!
 *  Description: Show alert message
 */
+ (void)showRetryMessage:(NSString *)message withHandler:(void (^)(UIAlertAction *action))handler {
    // IOS8 and later
    if (IS_IOS8) {
        UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@""
                                                                                  message:message
                                                                           preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * retryAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Retry", nil)
                                                               style:UIAlertActionStyleDefault
                                                             handler:handler];
        [alertController addAction:retryAction];
        UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", nil)
                                                                style:UIAlertActionStyleDefault
                                                              handler:nil];
        [alertController addAction:cancelAction];
        [DEVICE_WINDOW.rootViewController presentViewController:alertController animated:YES completion:nil];
        alertController = nil;
        retryAction = nil;
        cancelAction = nil;
    }
}

#pragma mark - API Support Methods


/**
 *  Description: Check internet is available
 *  @return YES: internet is available. NO: internet isn't available
 */
+ (BOOL)isConnectionAvailable {
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    return networkStatus != NotReachable;
}

/**
 *
 *  warning when connection isn't available
  *  @return YES: internet is available. NO: internet isn't available
 */
+ (BOOL)warningLossConnection {
    if (![GlobalMethods isConnectionAvailable]) {
        // Show alert network error
        [GlobalMethods showMessageWithTitle:NSLocalizedString(@"MessageNoNetwork", nil) withTitle:NSLocalizedString(@"TitleNoNetwork", nil)];
        return YES;
    }
    return NO;
}

+(BOOL) isEnableKeyGoogleAPI {
    
    NSLog(@"***Global Method ****");
    NSLog(@"isEnableKeyGoogleAPI %ld",[AppManager share].numberkeyGoogleAPIChecked);
    if ([AppManager share].numberkeyGoogleAPIChecked > [AppManager share].arrayKeyGoogleAPI.count - 1) {
        return false;
    }
    
    [AppManager share].keyGoogleAPICurrent = [AppManager share].arrayKeyGoogleAPI[[AppManager share].numberkeyGoogleAPIChecked];
    [AppManager share].numberkeyGoogleAPIChecked ++;
    return true;
}

+(void)resetStatusKeyGoogleAPI {
    NSLog(@"***Global Method ****");
    NSLog(@"reset status key API");
    NSLog(@"*********************");
    [AppManager share].numberkeyGoogleAPIChecked  = 0;
}
@end
