//
//  City.m
//  CloudKit-demo
//
//  Created by Maksim Usenko on 3/16/15.
//  Copyright (c) 2015 Yalantis. All rights reserved.
//

#import "City.h"
#import <CloudKit/CloudKit.h>

static NSString * const kCitiesPlistName = @"Cities";

const struct CloudKitCityFields CloudKitCityFields = {
    .identifier = @"id",
    .name = @"name",
    .text = @"text",
    .picture = @"picture"
};

@implementation City

#pragma mark - Class methods

+ (NSDictionary *)defaultContent {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:kCitiesPlistName ofType:@"plist"];
    NSData *plistData = [NSData dataWithContentsOfFile:path];
    
    NSAssert(plistData, @"Source doesn't exist");
    
    NSPropertyListFormat format;
    NSError *error = nil;
    NSDictionary *plistDic = [NSPropertyListSerialization propertyListWithData:plistData
                                                                       options:NSPropertyListMutableContainersAndLeaves
                                                                        format:&format
                                                                         error:&error];
    
    NSAssert(!error, @"Can not read data from the plist");
    
    return plistDic;
}

#pragma mark - Lifecycle

- (instancetype)initWithInputData:(id)inputData {
    self = [super init];
    if (self) {
        [self mapObject:inputData];
    }
    
    return self;
}

#pragma mark - Private

- (void)mapObject:(CKRecord *)object {
    _name = [object valueForKeyPath:CloudKitCityFields.name];
    _text = [object valueForKeyPath:CloudKitCityFields.text];
    _image = [UIImage imageWithData:(NSData *)[object valueForKeyPath:CloudKitCityFields.picture]];
    _identifier = object.recordID.recordName;
}

@end
