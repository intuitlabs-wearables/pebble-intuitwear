//
//  AppDelegate.m
//  IntuitWear
//
//  Created by Maidasani, Hitesh on 9/29/14.
//  Copyright (c) 2014 intuit. All rights reserved.
//

#import "AppDelegate.h"
#import <PushNotifications/PushNotificationSDK.h>
#import "KeychainItemWrapper.h"
#import "LoginViewController.h"
#import "DashboardViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

NSData* globaldeviceToken;
UIViewController* root;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    root = self.window.rootViewController;
    
    // request for push notification permission first time
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
    {
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
    else
    {
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
         (UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert)];
    }
    
    // register this application with Intuit's Push Notification Gateway application with associated sender id
    [[PushNotificationSDK sharedPushManager] setSenderId:@"your_senderId"];
    [[PushNotificationSDK sharedPushManager] setDryRun:YES];
    

    [self loginChecks];
    
    return YES;
}

/*
 Method that checks if user is already logged in within by checking the keychain at launch. If already logged in, skip login view and go to Dashboard view.
 */
- (void) loginChecks {
    KeychainItemWrapper *keychainItem = [[KeychainItemWrapper alloc] initWithIdentifier:@"IntuitWearLogin" accessGroup:nil];
    NSString *username = [keychainItem objectForKey:(__bridge id)(kSecAttrAccount)];
    NSLog(@"username: %@", username);
    
    if([username length] > 0) {
        self.window.rootViewController = [self.window.rootViewController.storyboard instantiateViewControllerWithIdentifier:@"DashboardViewController"];
    }
}

/*
 Method that logs in user by saving username to keychain and changing the view to the dashboard view. Also, registers username with Intuit's Push Notification Gateway application. To be called by LoginViewController's login callback.
 */
- (void) loginUser:(NSString*) username {
        KeychainItemWrapper *keychainItem = [[KeychainItemWrapper alloc] initWithIdentifier:@"IntuitWearLogin" accessGroup:nil];
        [keychainItem setObject:username forKey:(__bridge id)(kSecAttrAccount)];
    
    self.window.rootViewController = [self.window.rootViewController.storyboard instantiateViewControllerWithIdentifier:@"DashboardViewController"];
    
    [[PushNotificationSDK sharedPushManager] registerUser:username
                                                     inGroups:[NSArray arrayWithObjects:@"iosusergroup",@"group1",nil]
                                              withDeviceToken:globaldeviceToken error:nil];
}

/*
 Method that logs out user by deleting username from keychain and changing the view to the login view. To be called by DashboardViewController's logout callback.
 */
- (void) logout {
    KeychainItemWrapper *keychainItem = [[KeychainItemWrapper alloc] initWithIdentifier:@"IntuitWearLogin" accessGroup:nil];
    [keychainItem resetKeychainItem];
    
    self.window.rootViewController = [self.window.rootViewController.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
}

/*
 Callback for Intuit's Push Notification Gateway application to register username.
 */
-(void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
    globaldeviceToken = deviceToken;
    KeychainItemWrapper *keychainItem = [[KeychainItemWrapper alloc] initWithIdentifier:@"IntuitWearLogin" accessGroup:nil];
    NSString *username = [keychainItem objectForKey:(__bridge id)(kSecAttrAccount)];
    if([username length] > 0) {
        [[PushNotificationSDK sharedPushManager] registerUser:username
                                                inGroups:[NSArray arrayWithObjects:@"iosusergroup",@"hello",nil]
                                         withDeviceToken:deviceToken error:nil];
    }
}

/*
 Callback to display notification when received.
 */
-    (void)application:(UIApplication*)application didReceiveRemoteNotification:(NSDictionary*)userInfo{
    NSDictionary*pushObject=[userInfo valueForKey:@"aps"];
    UIAlertView*alert=[[UIAlertView alloc] initWithTitle:@"Notification"
                                                message:[pushObject objectForKey:@"alert"]
                                               delegate:nil
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil];
    [alert show];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
