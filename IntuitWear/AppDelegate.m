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

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
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

    
    [self loginChecks];
    

    return YES;
}

- (void) loginChecks {
    // Get the stored data before the view loads
    KeychainItemWrapper *keychainItem = [[KeychainItemWrapper alloc] initWithIdentifier:@"IntuitWearLogin" accessGroup:nil];
    NSString *username = [keychainItem objectForKey:(__bridge id)(kSecAttrAccount)];
    NSLog(@"username: %@", username);
    
    if([username length] > 0) {
        self.window.rootViewController = [self.window.rootViewController.storyboard instantiateViewControllerWithIdentifier:@"DashboardViewController"];
    } else {
        //login alert
        UIAlertView *alert =[[UIAlertView alloc ] initWithTitle:@"Log In" message:@"Enter your username" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles: nil];
        alert.alertViewStyle = UIAlertViewStylePlainTextInput;
        [alert addButtonWithTitle:@"Log In"];
        [alert show];
    }
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {  //Login
        UITextField *username = [alertView textFieldAtIndex:0];
        NSLog(@"username: %@", username.text);
        KeychainItemWrapper *keychainItem = [[KeychainItemWrapper alloc] initWithIdentifier:@"IntuitWearLogin" accessGroup:nil];
        [keychainItem setObject:username.text forKey:(__bridge id)(kSecAttrAccount)];
        [self.window.rootViewController performSegueWithIdentifier:@"loginSegue" sender:self];
        [[PushNotificationSDK sharedPushManager] setSenderId:@"1f6f955a-153b-4a11-9afa-4068f7eca0f0"];
        [[PushNotificationSDK sharedPushManager] setDryRun:YES];
    }
}

-(void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
    KeychainItemWrapper *keychainItem = [[KeychainItemWrapper alloc] initWithIdentifier:@"IntuitWearLogin" accessGroup:nil];
    NSString *username = [keychainItem objectForKey:(__bridge id)(kSecAttrAccount)];
    [[PushNotificationSDK sharedPushManager] registerUser:username
                                                inGroups:[NSArray arrayWithObjects:@"iosusergroup",@"hello",nil]
                                         withDeviceToken:deviceToken error:nil];
}

-    (void)application:(UIApplication*)application didReceiveRemoteNotification:(NSDictionary*)userInfo{
    
    NSDictionary*pushObject=[userInfo valueForKey:@"aps"];
    UIAlertView*alert=[[UIAlertView alloc] initWithTitle:@"Push Message"
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
