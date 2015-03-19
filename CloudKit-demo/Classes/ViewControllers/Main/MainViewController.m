//
//  ViewController.m
//  CloudKit-demo
//
//  Created by Maksim Usenko on 3/11/15.
//  Copyright (c) 2015 Yalantis. All rights reserved.
//

#import "MainViewController.h"
#import "CloudKitManager.h"
#import "CityTableViewCell.h"
#import "DetailedViewController.h"

static NSString * const kShowDetailSegueId = @"showDetailSegueId";

@interface MainViewController ()
<
UITableViewDataSource,
UITableViewDelegate
>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *indicatorView;

@property (nonatomic, copy) NSArray *cities;

@end

@implementation MainViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self updateData];
}

#pragma mark - Private

- (void)setupView {
    UINib *cityCell = [UINib nibWithNibName:[CityTableViewCell nibName] bundle:nil];
    [self.tableView registerNib:cityCell forCellReuseIdentifier:[CityTableViewCell reuseIdentifier]];
}

- (void)updateData {
    [self.indicatorView startAnimating];
    __weak typeof(self) weakSelf = self;
    [CloudKitManager fetchAllCitiesWithCompletionHandler:^(NSArray *results, NSError *error) {
        if (error) {
//            NSAssert(NO, @"error");
        } else {
            weakSelf.cities = results;
            [weakSelf.indicatorView stopAnimating];
            [weakSelf.tableView reloadData];
        }
    }];
}

#pragma mark - Segue methods

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:kShowDetailSegueId]) {
        DetailedViewController *detailedVC = segue.destinationViewController;
        detailedVC.city = [self.cities objectAtIndex:self.tableView.indexPathForSelectedRow.item];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.cities count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[CityTableViewCell reuseIdentifier]];
    
    [cell setCity:[self.cities objectAtIndex:indexPath.item]];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:kShowDetailSegueId sender:nil];
}

@end
