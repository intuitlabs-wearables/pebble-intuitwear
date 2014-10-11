//
//  UserModel.m
//  IntuitWear
//
//  Created by Maidasani, Hitesh on 10/10/14.
//  Copyright (c) 2014 intuit. All rights reserved.
//

#import "UserModel.h"
#import <PushNotifications/PushNotificationSDK.h>
#import "KeychainItemWrapper.h"

@implementation UserModel


-(void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
    
    [[PushNotificationSDK sharedPushManager] registerUser:@"hitesh"
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

@end
