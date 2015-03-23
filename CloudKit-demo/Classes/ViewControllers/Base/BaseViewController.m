//
//  BaseViewController.m
//  CloudKit-demo
//
//  Created by Maksim Usenko on 3/23/15.
//  Copyright (c) 2015 Yalantis. All rights reserved.
//

#import "BaseViewController.h"

@implementation BaseViewController

#pragma mark - Public

- (void)presentMessage:(NSString *)msg {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"CloudKit", nil)
                                                    message:msg
                                                   delegate:nil
                                          cancelButtonTitle:NSLocalizedString(@"Ok", nil)
                                          otherButtonTitles:nil];
    [alert show];
}

@end
