//
//  LoginViewController.m
//  IntuitWear
//
//  Created by Maidasani, Hitesh on 10/10/14.
//  Copyright (c) 2014 intuit. All rights reserved.
//

#import "LoginViewController.h"
#import "KeychainItemWrapper.h"
#import "AppDelegate.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)loginClick:(id)sender {
//    KeychainItemWrapper *keychainItem = [[KeychainItemWrapper alloc] initWithIdentifier:@"IntuitWearLogin" accessGroup:nil];
//    NSString *username = [keychainItem objectForKey:(__bridge id)(kSecAttrAccount)];
//    NSLog(@"username: %@", username);
//    
//    if([username length] > 0) {
//        [self performSegueWithIdentifier:@"loginSegue" sender:self];
//    } else {
//        //login alert
//        UIAlertView *alert =[[UIAlertView alloc ] initWithTitle:@"Log In" message:@"Enter your username" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles: nil];
//        alert.alertViewStyle = UIAlertViewStylePlainTextInput;
//        [alert addButtonWithTitle:@"Log In"];
//        [alert show];
//    }
    
    
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] loginChecks];
    
}

//- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
//{
//    if (buttonIndex == 1) {  //Login
//        UITextField *username = [alertView textFieldAtIndex:0];
//        NSLog(@"username: %@", username.text);
//        KeychainItemWrapper *keychainItem = [[KeychainItemWrapper alloc] initWithIdentifier:@"IntuitWearLogin" accessGroup:nil];
//        [keychainItem setObject:username.text forKey:(__bridge id)(kSecAttrAccount)];
//        [self performSegueWithIdentifier:@"loginSegue" sender:self];
//    }
//}

@end
