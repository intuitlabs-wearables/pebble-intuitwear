//
//  AppDelegate.h
//  IntuitWear
//
//  Created by Maidasani, Hitesh on 9/29/14.
//  Copyright (c) 2014 intuit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate,UIAlertViewDelegate>

@property (strong, nonatomic) UIWindow *window;

- (void) loginChecks;
- (void) loginUser: NSString;
- (void) logout;
@end

