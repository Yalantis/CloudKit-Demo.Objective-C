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
#import "SelectCityViewController.h"

static NSString * const kShowDetailSegueId = @"showDetailSegueId";

@interface MainViewController ()
<
UITableViewDataSource,
UITableViewDelegate
>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *indicatorView;

@property (nonatomic, strong) NSArray *cities;

@end

@implementation MainViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    [self updateData];
}

#pragma mark - Segue methods

- (IBAction)unwindToMainViewController:(UIStoryboardSegue *)segue {

    if ([segue.sourceViewController isMemberOfClass:[SelectCityViewController class]]) {
        SelectCityViewController *selectCityVC = (SelectCityViewController *)[segue sourceViewController];
        City *newCity = selectCityVC.selectedCity;
        [self addCity:newCity];
    } else if ([segue.sourceViewController isMemberOfClass:[DetailedViewController class]]) {
        DetailedViewController *detailedVC = (DetailedViewController *)[segue sourceViewController];
        [self removeCity:detailedVC.city];
    }
    
    [self.navigationController popToViewController:self animated:YES];
}

#pragma mark - Private

- (void)setupView {
    UINib *cityCell = [UINib nibWithNibName:[CityTableViewCell nibName] bundle:nil];
    [self.tableView registerNib:cityCell forCellReuseIdentifier:[CityTableViewCell reuseIdentifier]];
}

- (void)updateData {
    [self shouldAnimateIndicator:YES];
    __weak typeof(self) weakSelf = self;
    [CloudKitManager fetchAllCitiesWithCompletionHandler:^(NSArray *results, NSError *error) {
        __strong typeof(self) strongSelf = weakSelf;
        if (error) {
            if (error.code == 6) {
                [strongSelf presentMessage:NSLocalizedString(@"Add City from the default list", nil)];
            } else {
                [strongSelf presentMessage:error.userInfo[NSLocalizedDescriptionKey]];
            }
        } else {
            strongSelf.cities = results;
            [strongSelf.tableView reloadData];
        }
        [strongSelf shouldAnimateIndicator:NO];
    }];
}

- (void)shouldAnimateIndicator:(BOOL)animate {
    if (animate) {
        [self.indicatorView startAnimating];
    } else {
        [self.indicatorView stopAnimating];
    }
    
    self.tableView.userInteractionEnabled = !animate;
    self.navigationController.navigationBar.userInteractionEnabled = !animate;
}

- (void)addCity:(City *)city {
    NSMutableArray *temp = [[NSMutableArray alloc] initWithArray:self.cities];
    [temp insertObject:city atIndex:0];
    self.cities = temp;
    
    [self.tableView reloadData];
}

- (void)removeCity:(City *)city {
    
    if (![self.cities containsObject:city]) return;
    
    NSMutableArray *temp = [[NSMutableArray alloc] initWithArray:self.cities];
    [temp removeObject:city];
    self.cities = temp;
    
    [self.tableView reloadData];
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
