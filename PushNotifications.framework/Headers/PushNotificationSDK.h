//
//  PushNotificationSDK.h
//  PushNotificationSDK
//
//  Created by Sinu Sekhar on 2/12/13.
//  Copyright (c) 2013 Intuit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PushNotificationSDK : NSObject
{
    NSString *senderId;
    BOOL dryRun;
}

+(PushNotificationSDK*) sharedPushManager;

/* Getters and Setters*/
- (BOOL)isDryRun;
- (void) setDryRun : (BOOL) theDryRunFlag;

/* Registration related functions */
- (void) setSenderId:(NSString*) theSenderId;
- (void) registerUser:(NSString *)username withDeviceToken: (NSData *) deviceToken error:(NSError **) error;
- (void) registerUser:(NSString *)username inGroups: (NSArray *) usergroups withDeviceToken: (NSData *) deviceToken
                error:(NSError **) error;
- (void) registerUser:(NSString *)username inGroups: (NSArray *) usergroups withDeviceToken: (NSData *) deviceToken
       callbackObject: (id) responseTarget callbackMethodName: (NSString *) responseTargetMethodName
       error:(NSError **) error;


/* This is a private method, used for internal testing ONLY. */
- (void) overrideServiceEndpoint: (NSString *) theURL;
@end
