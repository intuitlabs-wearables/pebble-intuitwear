//
//  PushNotificationSDK.h
//  PushNotificationSDK
//
//  Created by Sinu Sekhar on 2/12/13.
//  Copyright (c) 2013 Intuit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PushNotificationSDK : NSObject

@property BOOL automatedTestMode;
@property (strong,nonatomic) NSMutableDictionary *automatedTestData;
@property (strong, nonatomic) NSString *senderId;
@property BOOL dryRun;

+(PushNotificationSDK*) sharedPushManager;

- (BOOL)isDryRun;
- (void) resetSenderId;

/* Registration related functions */
- (void) registerUser:(NSString *)username withDeviceToken: (NSData *) deviceToken error:(NSError **) error;
- (void) registerUser:(NSString *)username inGroups: (NSArray *) usergroups withDeviceToken: (NSData *) deviceToken
                error:(NSError **) error;
- (void) registerUser:(NSString *)username inGroups: (NSArray *) usergroups withDeviceToken: (NSData *) deviceToken
       callbackObject: (id) responseTarget callbackMethodName: (NSString *) responseTargetMethodName
                error:(NSError **) error;

/**
 Check if a deviceToken should be registered by calling  -registerUser:inGroups:withDeviceToken:completionHandler.
 
 This check only needs to be done when inside  -application:didRegisterForRemoteNotificationsWithDeviceToken.
 
 The purpose is to ensure we capture and register the latest deviceToken from Apple.
 
 Example usage:
 @code
 -(void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
 {
     BOOL isRegRequired = [[PushNotificationSDK sharedPushManager] isRegistrationRequired:deviceToken];
     if (isRegRequired)
     {
         [[PushNotificationSDK sharedPushManager] registerUser:@"jgeisler"
             inGroups:[NSArray arrayWithObjects:@"AdminGroup", nil]
             withDeviceToken:deviceToken
             completionHandler:^(NSURLResponse *urlResp, NSData *respData, NSError *respErr) {
             NSString* respDataStr = [[NSString alloc] initWithData:respData encoding:NSUTF8StringEncoding];
             NSLog(@"RegisterUserAPI: urlResp: %@, respData: %@, respErr: %@", urlResp, respDataStr, respErr);
         }];
     }
 }
 @endcode
 @param deviceToken
    The deviceToken which is passed to the delegate callback -application:didRegisterForRemoteNotificationsWithDeviceToken 
 @return YES if the deviceToken should be passed to the -registerUser:inGroups:withDeviceToken:completionHandler
 */
- (BOOL) isRegistrationRequired:(NSData *)deviceToken;


/**
 Register a deviceToken with the Push Notification Gateway
 
 Example usage:
 @code
 [[PushNotificationSDK sharedPushManager] registerUser:@"jgeisler"
                 inGroups:[NSArray arrayWithObjects:@"AdminGroup", nil]
                 withDeviceToken:deviceToken
                 completionHandler:^(NSURLResponse *urlResp, NSData *respData, NSError *respErr) {
                 NSString* respDataStr = [[NSString alloc] initWithData:respData encoding:NSUTF8StringEncoding];
                 NSLog(@"RegisterUserAPI: urlResp: %@, respData: %@, respErr: %@", urlResp, respDataStr, respErr);
                 }];

 @endcode
 @param username
    A username alias that will be associated with the deviceToken
 @param usergroups
    An optional list of group names that can be associated with the deviceToken
 @param deviceToken
    The deviceToken to be registered
 @param completionHandler
    A completion handler block that you can use to find out the success or failure of the method call
 */
- (void) registerUser:(NSString *)username
             inGroups:(NSArray *)usergroups
      withDeviceToken: (NSData *) deviceToken
    completionHandler:(void (^)(NSURLResponse*, NSData*, NSError*))handler;

/* Remove User API */
- (void)removeUser:(NSString*)user
         fromGroup:(NSString*)group
 completionHandler:(void (^)(NSURLResponse*, NSData*, NSError*))handler;

/* Unregister Device API */
- (void) unregisterDeviceWithDeviceToken:(NSData *) deviceToken completionHandler:(void (^)(NSURLResponse*, NSData*, NSError*))handler;

/* This is a private method, used for internal testing ONLY. */
- (void) overrideServiceEndpoint: (NSString *) theURL;
@end
