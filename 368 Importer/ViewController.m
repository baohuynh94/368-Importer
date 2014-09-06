//
//  ViewController.m
//  368 Importer
//
//  Created by Dino Phan on 8/30/14.
//  Copyright (c) 2014 Dino Phan. All rights reserved.
//

#import "ViewController.h"
#import "ViewerViewController.h"

@interface ViewController ()

@end

@implementation ViewController {
    NSString *strCache;
    int intCache;
    UIImageView *playImg;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Set customize
    [self setTitle:@"368 Importer"];
    _tableMedia.delegate = self;
    _tableMedia.dataSource = self;
    
    // Set UIImage no file if no image/video in Document dir
    noFileImage = [[UIImageView alloc] initWithFrame:_tableMedia.frame];
    [noFileImage setContentMode:UIViewContentModeCenter];
    [noFileImage setImage:[UIImage imageNamed:@"noimage.png"]];
    float screenSizeWidth = self.view.frame.size.width;
    float screenSizeHeight = self.view.frame.size.height;
    UIImageView *imageLogo = [[UIImageView alloc] initWithFrame:CGRectMake((screenSizeWidth/2)-60, (screenSizeHeight/2)-100, 120, 120)];
    [imageLogo setImage:[UIImage imageNamed:@"logo.png"]];
    [noFileImage addSubview:imageLogo];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((screenSizeWidth/2)-100, imageLogo.frame.size.height+imageLogo.frame.origin.y+20, 200, 18)];
    [titleLabel setText:@"Không có ảnh hoặc video"];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:16.0]];
    [titleLabel setTextColor:[UIColor whiteColor]];
    [noFileImage addSubview:titleLabel];
    UILabel *subtitleLabel = [[UILabel alloc] initWithFrame:CGRectMake((screenSizeWidth/2)-110, titleLabel.frame.size.height+titleLabel.frame.origin.y, 220, 100)];
    [subtitleLabel setNumberOfLines:4];
    [subtitleLabel setText:@"Hãy bắt đầu thêm ảnh bằng cách:\n- Cắm thiết bị vào iTunes.\n- Thêm ảnh và/hoặc video trong mục File Sharing của app 368 importer."];
    [subtitleLabel setTextAlignment:NSTextAlignmentCenter];
    [subtitleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size:14.0]];
    [subtitleLabel setTextColor:[UIColor whiteColor]];
    [noFileImage addSubview:subtitleLabel];
    
    // Create refresh UI when user pull down table to refresh
    refreshButton = [[UIButton alloc] initWithFrame:CGRectMake((screenSizeWidth / 2) - 42, screenSizeHeight - 60, 84, 30)];
    refreshButton.layer.cornerRadius = 5.0f;
    refreshButton.clipsToBounds = YES;
    refreshButton.layer.borderWidth = 1.0f;
    refreshButton.layer.borderColor = [UIColor whiteColor].CGColor;
    [refreshButton setTitle:@"Làm mới" forState:UIControlStateNormal];
    [refreshButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [refreshButton setTitleColor:[UIColor colorWithRed:67 green:87 blue:112 alpha:1.0] forState:UIControlStateSelected];
    [refreshButton setShowsTouchWhenHighlighted:YES];
    [refreshButton addTarget:self action:@selector(refreshData) forControlEvents:UIControlEventTouchUpInside];
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [_tableMedia addSubview:refreshControl];
    
    // Load data to table
    [self loadData];
    NSLog(@"%@", [[FileManager getSharedInstance] documentsPath]);
}

// Refresh tableView
- (void)refresh:(UIRefreshControl *)refreshControl {
    [self loadData];
    [refreshControl endRefreshing];
}

// Set number of section: 2 (one for images, one for videos)
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

// Set rows for each section
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
            [(UILabel *)[cell viewWithTag:105] setText:[[FileManager getSharedInstance] dateCreateAndSize:[videoList objectAtIndex:indexPath.row]]];
        }
            break;
        default:
            break;
    }
    return cell;
}

// Title for each section
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section==0) {
        NSString *total = [[NSString alloc] initWithFormat:@"Số ảnh: %d", (int)[imageList count]];
        return total;
    }
    else {
        NSString *total = [[NSString alloc] initWithFormat:@"Số clip: %d", (int)[videoList count]];
        return total;
    }
    
}

// Refresh data
- (void)refreshData {
    [self loadData];
}

// Load data from documents dir to NSArray
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

// Import button
- (IBAction)importMedia:(id)sender {
    UIAlertView *importAlert = [[UIAlertView alloc] initWithTitle:@"Chọn hành động" message:@"\n\n" delegate:self cancelButtonTitle:@"Đóng" otherButtonTitles:@"Nhập tất cả", @"Chỉ nhập ảnh", @"Chỉ nhập video", @"Xóa tất cả", @"Chỉ xóa ảnh", @"Chỉ xóa video", nil];
    [importAlert setTag:200];
    [importAlert show];
}

// AlertView Delegate
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

// Set slide to delete
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        if (indexPath.section == 0) {
            [[FileManager getSharedInstance] removeFile:[imageList objectAtIndex:indexPath.row]];
        }
        else if (indexPath.section == 1) {
            [[FileManager getSharedInstance] removeFile:[videoList objectAtIndex:indexPath.row]];
        }
        [self loadData];
    }
}

// AppUtils - AlertView
- (void)alertOKWithMessage:(NSString *)message {
    UIAlertView *alertOK = [[UIAlertView alloc] initWithTitle:message message:@"" delegate:self cancelButtonTitle:@"Đồng ý" otherButtonTitles:nil, nil];
    [alertOK show];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

// Create data for next view (preview image/video)
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"viewer"]) {
        ViewerViewController *viewerView = [segue destinationViewController];
        UITableViewCell *cell = (UITableViewCell *)sender;
        NSIndexPath *indexPath = [_tableMedia indexPathForCell:cell];
        if (indexPath.section==0) {
            viewerView.filepath = [imageList objectAtIndex:indexPath.row];
        }
        else if (indexPath.section==1) {
            viewerView.filepath = [videoList objectAtIndex:indexPath.row];
        }
        else {
            viewerView.filepath = @"(trống)";
        }
    }
}

@end
