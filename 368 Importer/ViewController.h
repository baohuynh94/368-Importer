//
//  ViewController.h
//  368 Importer
//
//  Created by Dino Phan on 8/30/14.
//  Copyright (c) 2014 Dino Phan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FileManager.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVFoundation.h>
#import "BButton.h"
#import "ImportMedia.h"

@interface ViewController : UIViewController <UIAlertViewDelegate, UITableViewDataSource, UITableViewDelegate> {
    NSArray *imageList;
    NSArray *videoList;
    UIImageView *noFileImage;
    BButton *refreshButton;
    ImportMedia *imprtMedia;
    FileManager *filMng;
}

@property (strong, nonatomic) IBOutlet UIBarButtonItem *importMedia;
@property (strong, nonatomic) IBOutlet UITableView *tableMedia;
- (IBAction)importMedia:(id)sender;

@end
