//
//  CloudKitManager.m
//  CloudKit-demo
//
//  Created by Maksim Usenko on 3/16/15.
//  Copyright (c) 2015 Yalantis. All rights reserved.
//

#import "CloudKitManager.h"
#import <CloudKit/CloudKit.h>
#import "City.h"

NSString * const kContainerId = @"iCloud.com.yalantis.cloudkit-demo";
NSString * const kCitiesRecord = @"Cities";

@implementation CloudKitManager

#pragma mark - Class methods

+ (void)fetchAllCitiesWithCompletionHandler:(CloudKitCompletionHandler)handler {
    
    CKDatabase *publicDatabase = [[CKContainer containerWithIdentifier:kContainerId] publicCloudDatabase];
    
    NSPredicate *predicate = [NSPredicate predicateWithValue:YES];
    CKQuery *query = [[CKQuery alloc] initWithRecordType:kCitiesRecord predicate:predicate];
    
    [publicDatabase performQuery:query
                    inZoneWithID:nil
               completionHandler:^(NSArray *results, NSError *error) {
        
        if (!handler) return;
        
        if (error) {
            handler (nil, error);
        } else {
            handler ([self mapCities:results], error);
        }
    }];
}

+ (NSArray *)mapCities:(NSArray *)cities {
    NSMutableArray *temp = [[NSMutableArray alloc] init];
    [cities enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        City *city = [[City alloc] initWithInputData:obj];
        [temp addObject:city];
    }];
    
    return [NSArray arrayWithArray:temp];
}

@end
