//
//  UserModel.h
//  IntuitWear
//
//  Created by Maidasani, Hitesh on 10/10/14.
//  Copyright (c) 2014 intuit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UserModel : NSObject<UIApplicationDelegate> {
    
}

@property (copy) NSString *username;

- (bool) isLoggedIn;

- (bool) login;

-(bool) logout;


@end
