//
//  SelectCitiesViewController.h
//  CloudKit-demo
//
//  Created by Maksim Usenko on 3/18/15.
//  Copyright (c) 2015 Yalantis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "City.h"

@interface SelectCityViewController : BaseViewController

@property (nonatomic, strong) City *selectedCity;

@end
