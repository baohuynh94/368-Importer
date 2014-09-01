//
//  ImportMedia.m
//  368 Importer
//
//  Created by Dino Phan on 8/31/14.
//  Copyright (c) 2014 Dino Phan. All rights reserved.
//

#import "ImportMedia.h"

@implementation ImportMedia

- (BOOL)isAllow {
    ALAssetsLibrary *lib = [[ALAssetsLibrary alloc] init];
    
    [lib enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
    } failureBlock:^(NSError *error) {
        if (error.code == ALAssetsLibraryAccessUserDeniedError) {
            NSLog(@"user denied access, code: %li",(long)error.code);
        }else{
            NSLog(@"Other error code: %li",(long)error.code);
        }
    }];
    ALAuthorizationStatus status = [ALAssetsLibrary authorizationStatus];
    
    if (status != ALAuthorizationStatusAuthorized) {
        alert = [[UIAlertView alloc] initWithTitle:@"Cảnh báo" message:@"Hãy cho phép 368 importer có quyền truy cập vào kho ảnh của bạn trong phần cài đặt!" delegate:nil cancelButtonTitle:@"Đóng" otherButtonTitles:nil, nil];
        [alert show];
        return NO;
    }
    else {
        return YES;
    }
}

- (void)importMedia:(NSString *)filename {
    if ([self isAllow]) {
        alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Đang nhập %@...", filename] message:@"" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
        [alert show];
        NSArray *homePath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *docPath = homePath[0];
        NSString *fileName = [docPath stringByAppendingPathComponent:filename];
        NSString *fileExtension = [[fileName pathExtension] lowercaseString];
        if ([fileExtension isEqualToString:@"mov"]||[fileExtension isEqualToString:@"mp4"]) {
            UISaveVideoAtPathToSavedPhotosAlbum(fileName,nil,nil,nil);
        }
        else if ([fileExtension isEqualToString:@"jpg"]||[fileExtension isEqualToString:@"jpeg"]||[fileExtension isEqualToString:@"png"]) {
            UIImage *imgToImport = [[UIImage alloc] initWithContentsOfFile:fileName];
            UIImageWriteToSavedPhotosAlbum(imgToImport, nil, nil, nil);
        }
        [alert dismissWithClickedButtonIndex:0 animated:YES];
        [self alertOKWithMessage:[NSString stringWithFormat:@"Đã nhập %@", filename]];
    }
    else {
        [self alertOKWithMessage:@"Lỗi xảy ra do ứng dụng không có quyền truy cập kho ảnh của bạn."];
    }
}

- (void)alertOKWithMessage:(NSString *)message {
    UIAlertView *alertOK = [[UIAlertView alloc] initWithTitle:message message:@"" delegate:self cancelButtonTitle:@"Đồng ý" otherButtonTitles:nil, nil];
    [alertOK show];
}



@end
