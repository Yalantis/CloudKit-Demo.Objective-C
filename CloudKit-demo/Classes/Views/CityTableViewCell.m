//
//  CityTableViewCell.m
//  CloudKit-demo
//
//  Created by Maksim Usenko on 3/16/15.
//  Copyright (c) 2015 Yalantis. All rights reserved.
//

#import "CityTableViewCell.h"

static NSString * const kCityCellReuseId = @"CityTableViewCellReuseId";

@interface CityTableViewCell ()

@property (nonatomic, weak) IBOutlet UIImageView *pictureImageView;
@property (nonatomic, weak) IBOutlet UILabel *nameLable;

@end

@implementation CityTableViewCell

#pragma mark - class methods

+ (NSString *)reuseIdentifier {
    return kCityCellReuseId;
}

+ (NSString *)nibName {
    return NSStringFromClass([self class]);
}

#pragma mark - Public

- (void)setCity:(City *)city {
    self.nameLable.text = city.name;
    self.pictureImageView.alpha = 0.f;
    self.pictureImageView.image = city.image;
    
    [UIView animateWithDuration:.3 animations:^{
        self.pictureImageView.alpha = 1.f;
    }];
    
}

@end
