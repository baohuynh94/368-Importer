//
//  InfoViewController.m
//  368 Importer
//
//  Created by Dino Phan on 9/1/14.
//  Copyright (c) 2014 Dino Phan. All rights reserved.
//

#import "InfoViewController.h"

@interface InfoViewController ()

@end

@implementation InfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Screen
    [self.navigationController.navigationBar setAlpha:0];
    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         [self.navigationController.navigationBar setAlpha:1];
                     }
                     completion:^(BOOL finished){}
     ];
    [self.view setBackgroundColor:[UIColor blackColor]];
    CGSize screenSize = self.view.frame.size;
    UIImageView *bgImg = [[UIImageView alloc] initWithFrame:self.view.frame];
    [bgImg setImage:[UIImage imageNamed:@"IMG_00093.JPG"]];
    [self.view addSubview:bgImg];
    [UIView animateWithDuration:0.1
                          delay:0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         [bgImg setAlpha:0.6];
                     }
                     completion:^(BOOL finished){}
     ];
    
    // ImageView
    UIImageView *authorImage = [[UIImageView alloc] initWithFrame:CGRectMake((screenSize.width/2)-70, -140, 140, 140)];
    [authorImage setImage:[UIImage imageNamed:@"IMG_0756.PNG"]];
    authorImage.layer.cornerRadius = authorImage.frame.size.width / 2;
    authorImage.clipsToBounds = YES;
    authorImage.layer.borderWidth = 3.0f;
    authorImage.layer.borderColor = [UIColor whiteColor].CGColor;
    [authorImage setUserInteractionEnabled:YES];
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    panGesture.delegate = self;
    [authorImage addGestureRecognizer:panGesture];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap:)];
    [tapGesture setNumberOfTapsRequired:2];
    tapGesture.delegate = self;
    [authorImage addGestureRecognizer:tapGesture];
    
    [self.view addSubview:authorImage];
    CGRect authorRect = authorImage.bounds;
    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         [authorImage setFrame:CGRectMake((screenSize.width/2)-70, 80, 140, 140)];
                     }
                     completion:^(BOOL finished){
                         [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                             [authorImage setFrame:CGRectMake(authorRect.origin.x - 10, 80, 140, 140)];
                         } completion:^(BOOL finished) {
                             [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                                 [authorImage setFrame:CGRectMake(authorRect.origin.x + 20, 80, 140, 140)];
                             } completion:^(BOOL finished) {
                                 [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
                                     [authorImage setFrame:CGRectMake((screenSize.width/2)-70, 80, 140, 140)];
                                 } completion:^(BOOL finished) {
                                 }];
                             }];
                         }];
                     }
     ];
    
    // Facebook
    BButton *facebookBtn = [[BButton alloc] initWithFrame:CGRectMake(-300, (authorImage.frame.origin.y+authorImage.frame.size.height+10), 300, 30) type:BButtonTypeFacebook icon:FAIconFacebook fontSize:8.0];
    [facebookBtn setTitle:@"facebook.com/dinophanhk" forState:UIControlStateNormal];
    [facebookBtn addTarget:self action:@selector(buttonClickedFB:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:facebookBtn];
    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         [facebookBtn setFrame:CGRectMake((screenSize.width/2)-150, (authorImage.frame.origin.y+authorImage.frame.size.height+40), 300, 30)];
                     }
                     completion:^(BOOL finished){}
     ];
    
    // Instagram
    BButton *instaBtn = [[BButton alloc] initWithFrame:CGRectMake(screenSize.width, (facebookBtn.frame.origin.y+facebookBtn.frame.size.height+5), 300, 30) type:BButtonTypeDefault icon:FAIconFacebook fontSize:8.0];
    [instaBtn setColor:[UIColor brownColor]];
    [instaBtn setTitle:@"instagram.com/dinophanhk" forState:UIControlStateNormal];
    [instaBtn addTarget:self action:@selector(buttonClickedTW:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:instaBtn];
    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         [instaBtn setFrame:CGRectMake((screenSize.width/2)-150, (facebookBtn.frame.origin.y+facebookBtn.frame.size.height+5), 300, 30)];
                     }
                     completion:^(BOOL finished){}
     ];
    
    // TextView
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake((screenSize.width/2)-150, screenSize.height, 300, screenSize.height-315)];
    [textView setEditable:NO];
    [textView setScrollEnabled:YES];
    [textView setTextAlignment:NSTextAlignmentCenter];
    [textView setTextColor:[UIColor whiteColor]];
    [textView setBackgroundColor:[UIColor colorWithWhite:0.0 alpha:0.0]];
    [textView setText:[NSString stringWithFormat:@"Tên ứng dụng: 368 importer\nPhiên bản: 1.0\nBy: @dino_phan\nPhiên bản iOS đang dùng: %@\n\nMọi đóp góp cho ứng dụng, bạn hãy liên hệ với mình qua email: baohuynh94@icloud.com hoặc số máy: 0917.451.500.\nXin cảm ơn!", [[UIDevice currentDevice] systemVersion]]];
    
    [textView setFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size:14.0]];
    [self.view addSubview:textView];
    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         [textView setFrame:CGRectMake((screenSize.width/2)-150, (instaBtn.frame.origin.y+instaBtn.frame.size.height+10), 300, 170)];
                     }
                     completion:^(BOOL finished){}
     ];
    
    // History
    historyView = [[UITextView alloc] initWithFrame:CGRectMake(facebookBtn.frame.origin.x, authorImage.frame.origin.y, 300, authorImage.frame.size.height+25)];
    [historyView setEditable:NO];
    [historyView setScrollEnabled:YES];
    [historyView setTextAlignment:NSTextAlignmentCenter];
    [historyView setTextColor:[UIColor whiteColor]];
    [historyView setBackgroundColor:[UIColor colorWithWhite:0.0 alpha:0.5]];
    [historyView setText:[NSString stringWithFormat:@"LỊCH SỬ PHIÊN BẢN\n\n30/08/2014:\n+ Khởi tạo ứng dụng.\n\n31/08/2014:\n+ Thêm tính năng nhập video và nhập từng phần, gở một số lỗi khi nhập ảnh.\n+ Thêm tính năng xem trước ảnh video.\n+ Đổi giao diện màu sáng.\n\n01/09/2014:\n+ Thêm tính năng nhập vào ảnh từ ứng dụng khác (như Mail,...)."]];
    
    [historyView setFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size:14.0]];
    [historyView setAlpha:0];
    [self.view addSubview:historyView];
    
    [self.view bringSubviewToFront:authorImage];
}

- (void)buttonClickedFB:(id)sender {
    
    NSURL *url = [NSURL URLWithString:@"fb://profile/100004013520159"];
    
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    }
    else {
        UIAlertView *alrt = [[UIAlertView alloc] initWithTitle:@"Facebook" message:@"Bạn chưa cài ứng dụng Facebook nên không thể mở profile của mình." delegate:self cancelButtonTitle:@"Đồng ý" otherButtonTitles:nil, nil];
        [alrt show];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://facebook.com/dinophanhk"]];
    }
    
}

- (void)buttonClickedTW:(id)sender {
    
    NSURL *url = [NSURL URLWithString:@"instagram://user?username=DINOPHANHK"];
    
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    }
    else {
        UIAlertView *alrt = [[UIAlertView alloc] initWithTitle:@"Facebook" message:@"Bạn chưa cài ứng dụng Instagram nên không thể mở profile của mình." delegate:self cancelButtonTitle:@"Đồng ý" otherButtonTitles:nil, nil];
        [alrt show];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://instagram.com/dinophanhk"]];
    }
    
}

- (IBAction)handlePan:(UIPanGestureRecognizer *)recognizer {
    
    CGPoint translation = [recognizer translationInView:self.view];
    recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x,
                                         recognizer.view.center.y + translation.y);
    [recognizer setTranslation:CGPointMake(0, 0) inView:self.view];
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        if (recognizer.view.center.y >= 220) {
        CGSize screenSize = self.view.frame.size;
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            [recognizer.view setFrame:CGRectMake((screenSize.width/2)-70, 80, 140, 140)];
        } completion:nil];
        }
    }
    if (recognizer.view.frame.origin.x <= 0) {
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            [historyView setAlpha:1];
        } completion:^(BOOL finished) {}];
    }
    else {
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            [historyView setAlpha:0];
        } completion:^(BOOL finished) {}];
    }
}

- (IBAction)doubleTap:(UITapGestureRecognizer *)recognizer {
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        [historyView setAlpha:0];
    } completion:^(BOOL finished) {}];
    CGSize screenSize = self.view.frame.size;
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        [recognizer.view setFrame:CGRectMake((screenSize.width/2)-70, 80, 140, 140)];
    } completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)passcodeChange:(id)sender {
    UIAlertView *alertChangePasscode = [[UIAlertView alloc] initWithTitle:@"Đổi Passcode" message:@"Nhập passcode mới của bạn:" delegate:self cancelButtonTitle:@"Bỏ qua" otherButtonTitles:@"Thay đổi", nil];
    [alertChangePasscode setAlertViewStyle:UIAlertViewStylePlainTextInput];
    [[alertChangePasscode textFieldAtIndex:0] setKeyboardType:UIKeyboardTypeNumberPad];
    [alertChangePasscode show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        UITextField *textField = [alertView textFieldAtIndex:0];
        if ([textField.text integerValue] > 9999) {
            [self alertOKWithMessage:@"Bạn chỉ được đặt Passcode 4 số!\nXin vui lòng thực hiện lại!"];
        }
        else {
            NSUserDefaults *defaultUser = [NSUserDefaults standardUserDefaults];
            [defaultUser setInteger:[textField.text integerValue] forKey:@"pc"];
            [defaultUser synchronize];
        }
    }
}

- (void)alertOKWithMessage:(NSString *)message {
    UIAlertView *alertOK = [[UIAlertView alloc] initWithTitle:message message:@"" delegate:self cancelButtonTitle:@"Đồng ý" otherButtonTitles:nil, nil];
    [alertOK show];
}

@end
