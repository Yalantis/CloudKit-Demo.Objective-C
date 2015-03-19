//
//  City.h
//  CloudKit-demo
//
//  Created by Maksim Usenko on 3/16/15.
//  Copyright (c) 2015 Yalantis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

extern const struct CloudKitCityFields {
    __unsafe_unretained NSString *identifier;
    __unsafe_unretained NSString *name;
    __unsafe_unretained NSString *text;
    __unsafe_unretained NSString *picture;
} CloudKitCityFields;

@interface City : NSObject

@property (nonatomic, copy, readonly) NSString *identifier;
@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly) NSString *text;
//@property (nonatomic, copy, readonly) NSString *imageURL;
@property (nonatomic, strong) UIImage *image;

+ (NSDictionary *)defaultContent;

- (instancetype)initWithInputData:(id)inputData;

@end
