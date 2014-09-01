//
//  AppDelegate.h
//  368 Importer
//
//  Created by Dino Phan on 8/30/14.
//  Copyright (c) 2014 Dino Phan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FileManager.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    FileManager *fileManager;
}

@property (strong, nonatomic) UIWindow *window;

@end
