//
//  DetailedViewController.m
//  CloudKit-demo
//
//  Created by Maksim Usenko on 3/16/15.
//  Copyright (c) 2015 Yalantis. All rights reserved.
//

#import "DetailedViewController.h"
#import "CloudKitManager.h"

static NSString * const kUnwindId = @"unwindToMainId";

@interface DetailedViewController ()

@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;
@property (nonatomic, weak) IBOutlet UIImageView *cityImageView;
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UITextView *descriptionTextView;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *indicatorView;

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
    
    [self shouldAnimateIndicator:YES];
    __weak typeof(self) weakSelf = self;
    [CloudKitManager updateRecordTextWithId:self.city.identifier
                                       text:[self.descriptionTextView.text copy]
                          completionHandler:^(NSArray *results, NSError *error) {
                              
                              if (error) {
                                  [weakSelf shouldAnimateIndicator:NO];
                                  [weakSelf presentMessage:error.userInfo[NSLocalizedDescriptionKey]];
                              } else {
                                  [weakSelf presentMessage:NSLocalizedString(@"City has been updated successfully", nil)];
                                  [weakSelf shouldAnimateIndicator:NO];
                              }
    }];
}

- (IBAction)removeButtonDidPress:(id)sender {
    
    [self shouldAnimateIndicator:YES];
    __weak typeof(self) weakSelf = self;
    [CloudKitManager removeRecordWithId:self.city.identifier completionHandler:^(NSArray *results, NSError *error) {
        
        if (error) {
            [weakSelf shouldAnimateIndicator:NO];
            [weakSelf presentMessage:error.userInfo[NSLocalizedDescriptionKey]];
        } else {
            [weakSelf performSegueWithIdentifier:kUnwindId sender:self];
        }
    }];
}

#pragma mark - Private

- (void)setupView {
    self.cityImageView.image = self.city.image;
    self.nameLabel.text = self.city.name;
    self.descriptionTextView.text = self.city.text;
}

- (void)shouldAnimateIndicator:(BOOL)animate {
    if (animate) {
        [self.indicatorView startAnimating];
    } else {
        [self.indicatorView stopAnimating];
    }
    
    self.view.userInteractionEnabled = !animate;
    self.navigationController.navigationBar.userInteractionEnabled = !animate;
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
