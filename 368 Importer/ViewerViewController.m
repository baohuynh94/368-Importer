//
//  ViewerViewController.m
//  368 Importer
//
//  Created by Dino Phan on 9/2/14.
//  Copyright (c) 2014 Dino Phan. All rights reserved.
//

#import "ViewerViewController.h"

@interface ViewerViewController ()

@end

@implementation ViewerViewController
@synthesize filepath;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:filepath];
    [self.navigationController.view setTintColor:[UIColor whiteColor]];
    
    // Find file extension to player/viewer
    NSString *fileExtension = [[filepath pathExtension] lowercaseString];
    if ([fileExtension isEqualToString:@"jpg"]||[fileExtension isEqualToString:@"png"]||[fileExtension isEqualToString:@"jpeg"]) {
        [self createImageView];
    }
    else {
        [self createVideoView];
    }
    
    // Create export button in right navigation bar
    UIBarButtonItem *importBtn = [[UIBarButtonItem alloc] initWithTitle:@"Lưu" style:UIBarButtonItemStyleDone target:self action:@selector(btnExport:)];
    self.navigationItem.rightBarButtonItem = importBtn;
}

// Export UIButton
- (IBAction)btnExport:(id)sender {
    ImportMedia *importClass = [[ImportMedia alloc] init];
    [importClass importMedia:filepath];
}

// Create UIImage object when file extension is .jpg .jpeg or .png
- (void)createImageView {
    NSString *fullPath = [[FileManager getSharedInstance] nameInDocumentsDirectory:filepath];
    NSLog(@"%@", fullPath);
    CGRect screenRect = self.view.frame;
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, (screenRect.size.height / 2)-120, 320, 240)];
    [imgView setImage:[UIImage imageWithContentsOfFile:fullPath]];
    [imgView setContentMode:UIViewContentModeScaleAspectFill];
    [self.view addSubview:imgView];
    NSLog(@"%@", fullPath);
}

// Create video file Path
- (void)createVideoView {
    NSLog(@"Video");
    
    NSString *fullPath = [[FileManager getSharedInstance] nameInDocumentsDirectory:filepath];
    [self playVideo:fullPath];
}

// Open player when file extension is mp4 or mov
- (void) playVideo:(NSString *)fileName
{
    AVURLAsset *asset = [AVURLAsset URLAssetWithURL:[NSURL fileURLWithPath:fileName] options:nil];
    AVAssetImageGenerator *imageGenerator = [AVAssetImageGenerator assetImageGeneratorWithAsset:asset];
    UIImage *image = [UIImage imageWithCGImage:[imageGenerator copyCGImageAtTime:CMTimeMake(0, 1) actualTime:nil error:nil]];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    CGRect screenRect = self.view.frame;
    [imageView setFrame:CGRectMake(0, (screenRect.size.height / 2)-120, 320, 240)];
    [imageView setContentMode:UIViewContentModeScaleAspectFill];
    
    [self.view addSubview:imageView];
    playerViewController = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL fileURLWithPath:fileName]];
    NSLog(@"%@", fileName);
    [[NSNotificationCenter defaultCenter]
	 addObserver:self
	 selector:@selector(movieFinishedCallback:)
	 name:MPMoviePlayerPlaybackDidFinishNotification
	 object:[playerViewController moviePlayer]];
    [self.view addSubview:playerViewController.view];
    [self play];
}

// Play video file
- (void)play {
    player = [playerViewController moviePlayer];
    [self.navigationController.navigationBar setAlpha:0];
    [player play];
}

// Close player when finish playback
- (void) movieFinishedCallback:(NSNotification*) aNotification {
    player = [aNotification object];
    [[NSNotificationCenter defaultCenter]
	 removeObserver:self
	 name:MPMoviePlayerPlaybackDidFinishNotification
	 object:player];
    [player stop];
    [self.navigationController.navigationBar setAlpha:1];
	[player.view removeFromSuperview];
}

// Close player when change view to mainView
- (void)viewWillDisappear:(BOOL)animated {
    [player stop];
    [player.view removeFromSuperview];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

@end
