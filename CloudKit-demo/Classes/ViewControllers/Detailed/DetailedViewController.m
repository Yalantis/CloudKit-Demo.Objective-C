//
//  DetailedViewController.m
//  CloudKit-demo
//
//  Created by Maksim Usenko on 3/16/15.
//  Copyright (c) 2015 Yalantis. All rights reserved.
//

#import "DetailedViewController.h"

@interface DetailedViewController ()

@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;
@property (nonatomic, weak) IBOutlet UIImageView *cityImageView;
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UITextView *descriptionTextView;

@end

@implementation DetailedViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    [self setupView];
}

#pragma mark - IBActions

- (IBAction)saveButtonDidPress:(id)sender {
    [self.view endEditing:YES];
}

#pragma mark - Private

- (void)setupView {
    self.cityImageView.image = self.city.image;
    self.nameLabel.text = self.city.name;
    self.descriptionTextView.text = self.city.text;
}

- (void)keyboardWillShow:(NSNotification *)notification {
    self.scrollView.contentOffset = CGPointMake(0, 110.f);
}

- (void)keyboardWillHide:(NSNotification *)notification {
    [UIView animateWithDuration:.25 animations:^{
        self.scrollView.contentOffset = CGPointZero;
    }];
}

@end
