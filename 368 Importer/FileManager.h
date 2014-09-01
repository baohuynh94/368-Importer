//
//  FileManager.h
//  368 Importer
//
//  Created by Dino Phan on 8/30/14.
//  Copyright (c) 2014 Dino Phan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileManager : NSObject {
    UIAlertView *alert;
}

+ (FileManager *)getSharedInstance;
- (BOOL)removeFile:(NSString *)fileName;
- (void)removeAllFile;
- (NSArray *)listOfImages;
- (NSArray *)listOfVideos;
- (NSString *)nameInDocumentsDirectory:(NSString *)filename;
- (NSString *)documentsPath;
- (void)copyInboxFiles;
- (NSString *)dateCreateAndSize:(NSString *)fileName;

@end
