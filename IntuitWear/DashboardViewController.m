//
//  DashboardViewController.m
//  IntuitWear
//
//  Created by Maidasani, Hitesh on 10/10/14.
//  Copyright (c) 2014 intuit. All rights reserved.
//

#import "DashboardViewController.h"
#import "KeychainItemWrapper.h"
#import "AppDelegate.h"

@interface DashboardViewController ()

@end

@implementation DashboardViewController

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

- (IBAction)logoutPressed:(id)sender {    
//    [self.navigationController popViewControllerAnimated:YES];
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] logout];
}
@end
