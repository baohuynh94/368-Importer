//
//  ViewerViewController.h
//  368 Importer
//
//  Created by Dino Phan on 9/2/14.
//  Copyright (c) 2014 Dino Phan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FileManager.h"
#import <AVFoundation/AVFoundation.h>
#import "ImportMedia.h"
#import <MediaPlayer/MediaPlayer.h>

@interface ViewerViewController : UIViewController <UIScrollViewDelegate> {
    NSString *filepath;
    FileManager *fileManager;
    MPMoviePlayerViewController *playerViewController;
    MPMoviePlayerController *player;
}

@property (strong, nonatomic) NSString *filepath;

@end
