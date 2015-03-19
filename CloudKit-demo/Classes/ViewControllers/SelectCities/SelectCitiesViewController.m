//
//  SelectCitiesViewController.m
//  CloudKit-demo
//
//  Created by Maksim Usenko on 3/18/15.
//  Copyright (c) 2015 Yalantis. All rights reserved.
//

#import "SelectCitiesViewController.h"
#import "City.h"
#import "CloudKitManager.h"

static NSString * const kSelectCitiesCellReuseId = @"SelectCitiesCellReuseId";

@interface SelectCitiesViewController ()
<
UITableViewDataSource,
UITableViewDelegate
>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *listOfCities;
@property (nonatomic, strong) NSArray *defaultContent;

@end

@implementation SelectCitiesViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [self.tableView reloadData];
}

#pragma mark - Custom Accessors

- (NSArray *)listOfCities {
    if (!_listOfCities) {
        _listOfCities = [[City defaultContent] allKeys];
    }
    
    return _listOfCities;
}

- (NSArray *)defaultContent {
    if (!_defaultContent) {
        _defaultContent = [[City defaultContent] allValues];
    }
    
    return _defaultContent;
}

#pragma mark - IBActions

- (IBAction)doneButtonDidPress:(id)sender {
    NSArray *selectedRows = self.tableView.indexPathsForSelectedRows;
    NSIndexPath *lastIndexPath = [selectedRows lastObject];
    [CloudKitManager createRecords:@[self.defaultContent[lastIndexPath.item]]];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.listOfCities count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kSelectCitiesCellReuseId];
    
    cell.textLabel.text = self.listOfCities[indexPath.item];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    
//    if (cell.accessoryType == UITableViewCellAccessoryNone) {
//        cell.accessoryType = UITableViewCellAccessoryCheckmark;
//    } else {
//        cell.accessoryType = UITableViewCellAccessoryNone;
//    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    cell.accessoryType = UITableViewCellAccessoryNone;
}

@end
