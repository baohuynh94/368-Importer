//
//  ImportMedia.h
//  368 Importer
//
//  Created by Dino Phan on 8/31/14.
//  Copyright (c) 2014 Dino Phan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface ImportMedia : NSObject {
    UIAlertView *alert;
}

- (BOOL)isAllow;
- (void)importMedia:(NSString *)filename;

@end
