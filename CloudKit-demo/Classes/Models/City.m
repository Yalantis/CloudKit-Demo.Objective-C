//
//  City.m
//  CloudKit-demo
//
//  Created by Maksim Usenko on 3/16/15.
//  Copyright (c) 2015 Yalantis. All rights reserved.
//

#import "City.h"
#import <CloudKit/CloudKit.h>

const struct CloudKitCityFields CloudKitCityFields = {
    .identifier = @"id",
    .name = @"name",
    .text = @"text",
    .picture = @"picture"
};

@implementation City

#pragma mark - init/dealloc methods

- (instancetype)initWithInputData:(id)inputData {
    self = [super init];
    if (self) {
        [self mapObject:inputData];
    }
    
    return self;
}

#pragma mark - methods

- (void)mapObject:(CKRecord *)object {
    _name = [object valueForKeyPath:CloudKitCityFields.name];
    _text = [object valueForKeyPath:CloudKitCityFields.text];
    _identifier = object.recordID.recordName;
    CKAsset *asset = [object valueForKeyPath:CloudKitCityFields.picture];
    _imageURL = [asset.fileURL absoluteString];
}

@end
