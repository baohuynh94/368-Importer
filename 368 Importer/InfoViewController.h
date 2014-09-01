//
//  InfoViewController.h
//  368 Importer
//
//  Created by Dino Phan on 9/1/14.
//  Copyright (c) 2014 Dino Phan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BButton/BButton.h"

@interface InfoViewController : UIViewController <UIGestureRecognizerDelegate, UIAlertViewDelegate> {
    UITextView *historyView;
}

- (IBAction)handlePan:(UIPanGestureRecognizer *)recognizer;
- (IBAction)doubleTap:(UITapGestureRecognizer *)recognizer;
- (IBAction)passcodeChange:(id)sender;

@end
