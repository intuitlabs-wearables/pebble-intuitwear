//
//  ViewController.m
//  IntuitWear
//
//  Created by Maidasani, Hitesh on 9/29/14.
//  Copyright (c) 2014 intuit. All rights reserved.
//

#import "ViewController.h"
#import "KeychainItemWrapper.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showLoginAlert:(id)sender {
    KeychainItemWrapper *keychainItem = [[KeychainItemWrapper alloc] initWithIdentifier:@"IntuitWearLogin" accessGroup:nil];
    NSString *username = [keychainItem objectForKey:(__bridge id)(kSecAttrAccount)];
    NSLog(@"username: %@", username);
    
    if([username length] > 0) {
        //        [self performSegueWithIdentifier:@"loginSegue" sender:self];
        NSLog(@"username: %@", username);
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
        [self performSegueWithIdentifier:@"loginSegue" sender:self];
    }
}
@end
