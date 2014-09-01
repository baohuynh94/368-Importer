//
//  ViewController.m
//  368 Importer
//
//  Created by Dino Phan on 8/30/14.
//  Copyright (c) 2014 Dino Phan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController {
    NSString *strCache;
    int intCache;
    UIImageView *playImg;
}

// Khi app vừa start lên
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Set customize
    [self setTitle:@"368 Importer"];
    _tableMedia.delegate = self;
    _tableMedia.dataSource = self;
    
    noFileImage = [[UIImageView alloc] initWithFrame:_tableMedia.frame];
    [noFileImage setContentMode:UIViewContentModeCenter];
    [noFileImage setImage:[UIImage imageNamed:@"nodata.png"]];
    float screenSizeWidth = self.view.frame.size.width;
    float screenSizeHeight = self.view.frame.size.height;
    refreshButton = [[BButton alloc] initWithFrame:CGRectMake((screenSizeWidth / 2) - 42, screenSizeHeight - 60, 84, 30)];
    [refreshButton setColor:[UIColor orangeColor]];
    [refreshButton setTitle:@"Làm mới" forState:UIControlStateNormal];
    [refreshButton addTarget:self action:@selector(refreshData) forControlEvents:UIControlEventTouchUpInside];
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [_tableMedia addSubview:refreshControl];
    [self loadData];
}

// Làm mới danh sách
- (void)refresh:(UIRefreshControl *)refreshControl {
    [self loadData];
    [refreshControl endRefreshing];
}

// Số section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

// Số dòng trong mỗi section
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return imageList.count;
            break;
            
        case 1:
            return videoList.count;
            break;
            
        default:
            return 0;
            break;
    }
}

// Custom cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    switch (indexPath.section) {
        case 0:
        {
            NSString *filePath = [[FileManager getSharedInstance] nameInDocumentsDirectory:[imageList objectAtIndex:indexPath.row]];
            [(UIImageView *)[cell viewWithTag:100] setImage:[UIImage imageWithContentsOfFile:filePath]];
            [(UILabel *)[cell viewWithTag:101] setText:[imageList objectAtIndex:indexPath.row]];
            [(UILabel *)[cell viewWithTag:105] setText:[[FileManager getSharedInstance] dateCreateAndSize:[imageList objectAtIndex:indexPath.row]]];
        }
            break;
            case 1:
        {
            NSString *filePath = [[FileManager getSharedInstance] nameInDocumentsDirectory:[videoList objectAtIndex:indexPath.row]];
            AVURLAsset *asset = [AVURLAsset URLAssetWithURL:[NSURL fileURLWithPath:filePath] options:nil];
            AVAssetImageGenerator *imageGenerator = [AVAssetImageGenerator assetImageGeneratorWithAsset:asset];
            UIImage *image = [UIImage imageWithCGImage:[imageGenerator copyCGImageAtTime:CMTimeMake(0, 1) actualTime:nil error:nil]];
            [(UIImageView*)[cell viewWithTag:100] setImage:image];
            [(UILabel *)[cell viewWithTag:101] setText:[videoList objectAtIndex:indexPath.row]];
            [(UILabel *)[cell viewWithTag:105] setText:[[FileManager getSharedInstance] dateCreateAndSize:[imageList objectAtIndex:indexPath.row]]];
        }
            break;
        default:
            break;
    }
    
//    UIButton *optionBtn = [[UIButton alloc] initWithFrame:CGRectMake(233, 0, 87, 30)];
//    [optionBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [optionBtn setBackgroundColor:[UIColor blackColor]];
//    [optionBtn setTitle:@"Tùy chọn" forState:UIControlStateNormal];
//    [optionBtn addTarget:self action:@selector(onCustomAccessoryTapped:) forControlEvents:UIControlEventTouchUpInside];
//    [cell addSubview:optionBtn];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        strCache = [imageList objectAtIndex:indexPath.row];
    }
    else if (indexPath.section == 1) {
        strCache = [videoList objectAtIndex:indexPath.row];
    }
    UIAlertView *alr = [[UIAlertView alloc] initWithTitle:strCache message:@"" delegate:self cancelButtonTitle:@"Đóng" otherButtonTitles:@"Nhập", @"Xóa", nil];
    [alr setTag:201];
    [alr show];
}

//-(UITableViewCell *)parentCellForView:(id)theView
//{
//    id viewSuperView = [theView superview];
//    while (viewSuperView != nil) {
//        if ([viewSuperView isKindOfClass:[UITableViewCell class]]) {
//            return (UITableViewCell *)viewSuperView;
//        }
//        else {
//            viewSuperView = [viewSuperView superview];
//        }
//    }
//    return nil;
//}
//
//- (void)onCustomAccessoryTapped:(UIButton *)sender {
//    UIButton *butn = (UIButton *)sender;
//    UITableViewCell *cell = [self parentCellForView:butn];
//    if (cell != nil) {
//        NSIndexPath *indexPath = [_tableMedia indexPathForCell:cell];
//        NSLog(@"show detail for item at row %d and section: %d", indexPath.row, indexPath.section);
//    }
//}

// Tiêu đề mỗi section ảnh và video
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section==0) {
        NSString *total = [[NSString alloc] initWithFormat:@"Số ảnh: %d - trong tổng số: %d", (int)[imageList count], (int)([imageList count]+[videoList count])];
        return total;
    }
    else {
        NSString *total = [[NSString alloc] initWithFormat:@"Số clip: %d - trong tổng số: %d", (int)[videoList count], (int)([imageList count]+[videoList count])];
        return total;
    }
    
}

// Làm mới data
- (void)refreshData {
    [self loadData];
}

// Tải danh sách vào dữ liệu
- (void)loadData {
    [[FileManager getSharedInstance] copyInboxFiles];
    imageList = [[NSArray alloc] initWithArray:[[FileManager getSharedInstance] listOfImages]];
    videoList = [[NSArray alloc] initWithArray:[[FileManager getSharedInstance] listOfVideos]];
    if (imageList.count == 0 && videoList.count == 0) {
        [_importMedia setEnabled:NO];
        [self.view addSubview:noFileImage];
        [self.view addSubview:refreshButton];
    }
    else {
        [_importMedia setEnabled:YES];
        [refreshButton removeFromSuperview];
        [noFileImage removeFromSuperview];
    }
    [_tableMedia reloadData];
}

// Nút nhập ảnh và video
- (IBAction)importMedia:(id)sender {
    UIAlertView *importAlert = [[UIAlertView alloc] initWithTitle:@"Chọn hành động" message:@"\n\n" delegate:self cancelButtonTitle:@"Đóng" otherButtonTitles:@"Nhập tất cả", @"Chỉ nhập ảnh", @"Chỉ nhập video", @"Xóa tất cả", @"Chỉ xóa ảnh", @"Chỉ xóa video", nil];
    [importAlert setTag:200];
    [importAlert show];
}

// Quản lý nút trên thông báo
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 200) {
        switch (buttonIndex) {
            case 0:
                break;
            case 1: {
                ImportMedia *importMedia = [[ImportMedia alloc] init];
                for (NSString *imgStr in imageList) {
                    [importMedia importMedia:imgStr];
                }
                for (NSString *videoStr in videoList) {
                    [importMedia importMedia:videoStr];
                }
            }
                break;
            case 2: {
                ImportMedia *importMedia = [[ImportMedia alloc] init];
                for (NSString *imgStr in imageList) {
                    [importMedia importMedia:imgStr];
                }
            }
                break;
            case 3: {
                ImportMedia *importMedia = [[ImportMedia alloc] init];
                for (NSString *videoStr in videoList) {
                    [importMedia importMedia:videoStr];
                }
            }
                break;
            case 4: {
                [[FileManager getSharedInstance] removeAllFile];
                [self alertOKWithMessage:[NSString stringWithFormat:@"Đã xóa hết ảnh và video"]];
                [self loadData];
            }
                break;
            case 5: {
                FileManager *fileMan = [[FileManager alloc] init];
                for (NSString *str in imageList) {
                    [fileMan removeFile:str];
                }
                [self alertOKWithMessage:[NSString stringWithFormat:@"Đã xóa hết ảnh"]];
                [self loadData];
            }
                break;
            case 6: {
                FileManager *fileMan = [[FileManager alloc] init];
                for (NSString *str in videoList) {
                    [fileMan removeFile:str];
                }
                [self alertOKWithMessage:[NSString stringWithFormat:@"Đã xóa hết video"]];
                [self loadData];
            }
                break;
                default:
                break;
        }
    }
    else if (alertView.tag == 201) {
        switch (buttonIndex) {
            case 0:
                // Close
                
                break;
            case 1: {
                // Import
                imprtMedia = [[ImportMedia alloc] init];
                [imprtMedia importMedia:strCache];
                strCache = @"";
            }
                break;
            case 2: {
                // Delete
                filMng = [[FileManager alloc] init];
                [filMng removeFile:strCache];
                strCache = @"";
                [self loadData];
            }
                break;
            default:
                break;
        }
    }
}

- (void)alertOKWithMessage:(NSString *)message {
    UIAlertView *alertOK = [[UIAlertView alloc] initWithTitle:message message:@"" delegate:self cancelButtonTitle:@"Đồng ý" otherButtonTitles:nil, nil];
    [alertOK show];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
