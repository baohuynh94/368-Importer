//
//  FileManager.m
//  368 Importer
//
//  Created by Dino Phan on 8/30/14.
//  Copyright (c) 2014 Dino Phan. All rights reserved.
//

#import "FileManager.h"
FileManager *sharedInstance = nil;

@implementation FileManager

// Shared instance
+ (FileManager *)getSharedInstance {
    if (!sharedInstance) {
        sharedInstance = [[FileManager allocWithZone:NULL] init];
    }
    return sharedInstance;
}

// Get full file name in documents dir
- (NSString *)nameInDocumentsDirectory:(NSString *)filename {
    NSArray *rootDirs = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = rootDirs[0];
    NSString *filePath = [documentsDir stringByAppendingPathComponent:filename];
    return filePath;
}

// Create list of image to NSArray from files in Documents path
- (NSArray *)listOfImages {
    NSArray *rootDirs = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = rootDirs[0];
    NSArray *dirs = [[NSFileManager defaultManager]contentsOfDirectoryAtPath:documentsDir error:NULL];
    NSMutableArray *imageFiles = [[NSMutableArray alloc] init];
    [dirs enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *filename = (NSString *)obj;
        NSString *extension = [[filename pathExtension] lowercaseString];
        if ([extension isEqualToString:@"jpg"]||[extension isEqualToString:@"jpeg"]||[extension isEqualToString:@"png"]) {
            [imageFiles addObject:filename];
        }
    }];
    return imageFiles;
}

// Remove file in document path
- (BOOL)removeFile:(NSString *)fileName {
    NSString *fileToRemove = [self nameInDocumentsDirectory:fileName];
    if ([[NSFileManager defaultManager] removeItemAtPath:fileToRemove error:nil]) {
        [alert dismissWithClickedButtonIndex:0 animated:YES];
        return YES;
    }
    [alert dismissWithClickedButtonIndex:0 animated:YES];
    return NO;
}

// Remove all files in document path
- (void)removeAllFile {
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    NSArray *rootDirs = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = rootDirs[0];
    NSArray *fileArray = [fileMgr contentsOfDirectoryAtPath:documentsDir error:nil];
    for (NSString *filename in fileArray)  {
        [fileMgr removeItemAtPath:[documentsDir stringByAppendingPathComponent:filename] error:NULL];
    }
}

// List all videos extension .mp4 or .mov from document path to NSArray
- (NSArray *)listOfVideos {
    NSArray *rootDirs = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = rootDirs[0];
    NSArray *dirs = [[NSFileManager defaultManager]contentsOfDirectoryAtPath:documentsDir error:NULL];
    NSMutableArray *imageFiles = [[NSMutableArray alloc] init];
    [dirs enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *filename = (NSString *)obj;
        NSString *extension = [[filename pathExtension] lowercaseString];
        if ([extension isEqualToString:@"mov"]||[extension isEqualToString:@"mp4"]) {
            [imageFiles addObject:filename];
        }
    }];
    return imageFiles;
}

// Copy files in Inbox dir to Documents dir when another App open images/videos from 368 importer
- (void)copyInboxFiles {
    NSString *docPath = [self documentsPath];
    NSString *inboxPath = [docPath stringByAppendingPathComponent:@"Inbox"];
    NSArray *allFileInbox = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:inboxPath error:nil];
    
    for (NSString *fileName in allFileInbox) {
        NSString *filePath = [inboxPath stringByAppendingPathComponent:fileName];
        NSString *toPath = [docPath stringByAppendingPathComponent:fileName];
        
        while ([[NSFileManager defaultManager] fileExistsAtPath:toPath]) {
            NSString *name = [toPath pathExtension];
            toPath = [toPath stringByAppendingFormat:@"-copy.%@", name];
        }
        
        [[NSFileManager defaultManager] copyItemAtPath:filePath toPath:toPath error:nil];
        [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
    }
}

// Create file att
- (NSString *)dateCreateAndSize:(NSString *)fileName {
    NSString *returnData = [[NSString alloc] init];
    NSString *docPath = [self documentsPath];
    NSString *filePath = [docPath stringByAppendingPathComponent:fileName];
    NSDictionary *fileAtt = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
    NSString *date = [fileAtt objectForKey:NSFileCreationDate];
    double bytes = [[fileAtt objectForKey:NSFileSize] integerValue];
    NSString *fileSize = (NSString *)[self convertByte:bytes];
    returnData = [NSString stringWithFormat:@"Ngày tạo: %@\nKích thước: %@", date, fileSize];
    return returnData;
}

// Convert byte to other filesize
- (id)convertByte:(double)value {
    double convertedValue = value;
    int multiplyFactor = 0;
    NSArray *tokens = [NSArray arrayWithObjects:@"bytes",@"KB",@"MB",@"GB",@"TB",nil];
    while (convertedValue > 1024) {
        convertedValue /= 1024;
        multiplyFactor++;
    }
    return [NSString stringWithFormat:@"%4.2f %@",convertedValue, [tokens objectAtIndex:multiplyFactor]];
}

// Get document path
- (NSString *)documentsPath {
    NSArray *rootDirs = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = rootDirs[0];
    return documentsDir;
}

@end
