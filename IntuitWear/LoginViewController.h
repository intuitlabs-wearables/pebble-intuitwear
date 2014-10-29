//
//  LoginViewController.h
//  IntuitWear
//
//  Created by Maidasani, Hitesh on 10/10/14.
//  Copyright (c) 2014 intuit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface LoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UIButton *signInButton;



- (IBAction)loginClick:(id)sender;
@end
