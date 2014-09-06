//
//  ProtectViewController.h
//  368 Importer
//
//  Created by Dino Phan on 9/1/14.
//  Copyright (c) 2014 Dino Phan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"

@interface ProtectViewController : UIViewController {
    NSInteger passcodeNumber;
}

@property (readwrite) IBOutlet UILabel *passcodeLabel;
@property (readwrite) IBOutlet UIButton *oneBtn;
@property (readwrite) IBOutlet UIButton *twoBtn;
@property (readwrite) IBOutlet UIButton *threeBtn;
@property (readwrite) IBOutlet UIButton *fourBtn;
@property (readwrite) IBOutlet UIButton *fiveBtn;
@property (readwrite) IBOutlet UIButton *sixBtn;
@property (readwrite) IBOutlet UIButton *sevenBtn;
@property (readwrite) IBOutlet UIButton *eightBtn;
@property (readwrite) IBOutlet UIButton *nineBtn;
@property (readwrite) IBOutlet UIButton *zeroBtn;
@property (readwrite) IBOutlet UIButton *delBtn;
@property (readwrite) IBOutlet UIButton *okBtn;
- (IBAction)oneBtn:(id)sender;
- (IBAction)twoBtn:(id)sender;
- (IBAction)threeBtn:(id)sender;
- (IBAction)fourBtn:(id)sender;
- (IBAction)fiveBtn:(id)sender;
- (IBAction)sixBtn:(id)sender;
- (IBAction)sevenBtn:(id)sender;
- (IBAction)eightBtn:(id)sender;
- (IBAction)nineBtn:(id)sender;
- (IBAction)zeroBtn:(id)sender;
- (IBAction)delBtn:(id)sender;
- (NSInteger)passcodeNumberCheck;

@end
