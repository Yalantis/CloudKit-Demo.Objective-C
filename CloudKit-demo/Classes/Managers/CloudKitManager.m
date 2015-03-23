//
//  CloudKitManager.m
//  CloudKit-demo
//
//  Created by Maksim Usenko on 3/16/15.
//  Copyright (c) 2015 Yalantis. All rights reserved.
//

#import "CloudKitManager.h"
#import <CloudKit/CloudKit.h>
#import <UIKit/UIKit.h>
#import "City.h"

NSString * const kCitiesRecord = @"Cities";

@implementation CloudKitManager

+ (CKDatabase *)publicCloudDatabase {
    return [[CKContainer defaultContainer] publicCloudDatabase];
}

+ (void)fetchAllCitiesWithCompletionHandler:(CloudKitCompletionHandler)handler {
    
    NSPredicate *predicate = [NSPredicate predicateWithValue:YES];
    CKQuery *query = [[CKQuery alloc] initWithRecordType:kCitiesRecord predicate:predicate];
    
    [[self publicCloudDatabase] performQuery:query
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

+ (void)createRecord:(NSDictionary *)recordDic completionHandler:(CloudKitCompletionHandler)handler {
    
    CKRecord *record = [[CKRecord alloc] initWithRecordType:kCitiesRecord];

    [[recordDic allKeys] enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL *stop) {
        
        if ([key isEqualToString:CloudKitCityFields.picture]) {
            NSString *path = [[NSBundle mainBundle] pathForResource:recordDic[key] ofType:@"png"];
            NSData *data = [NSData dataWithContentsOfFile:path];
            record[key] = data;
        } else {
            record[key] = recordDic[key];
        }
    }];
    
    [[self publicCloudDatabase] saveRecord:record completionHandler:^(CKRecord *record, NSError *error) {
        
        if (!handler) return;
        
        if(error) {
            handler (nil, error);
        } else {
            handler (@[record], error);
        }
    }];
}

+ (void)updateRecordTextWithId:(NSString *)recordId text:(NSString *)text completionHandler:(CloudKitCompletionHandler)handler {
    
    CKRecordID *recordID = [[CKRecordID alloc] initWithRecordName:recordId];
    [[self publicCloudDatabase] fetchRecordWithID:recordID completionHandler:^(CKRecord *record, NSError *error) {
        
        if (!handler) return;
        
        if (error) {
            handler (@[record], error);
            return;
        }
        
        record[CloudKitCityFields.text] = text;
        [[self publicCloudDatabase] saveRecord:record completionHandler:^(CKRecord *record, NSError *error) {
            handler (@[record], error);
        }];
    }];
}

+ (void)removeRecordWithId:(NSString *)recordId completionHandler:(CloudKitCompletionHandler)handler {
    
    CKRecordID *recordID = [[CKRecordID alloc] initWithRecordName:recordId];
    [[self publicCloudDatabase] deleteRecordWithID:recordID completionHandler:^(CKRecordID *recordID, NSError *error) {
        
        if (!handler) return;
        
        handler (nil, error);
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
