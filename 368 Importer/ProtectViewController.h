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

@property (strong, nonatomic) IBOutlet UILabel *passcodeLabel;
@property (strong, nonatomic) IBOutlet UIButton *oneBtn;
@property (strong, nonatomic) IBOutlet UIButton *twoBtn;
@property (strong, nonatomic) IBOutlet UIButton *threeBtn;
@property (strong, nonatomic) IBOutlet UIButton *fourBtn;
@property (strong, nonatomic) IBOutlet UIButton *fiveBtn;
@property (strong, nonatomic) IBOutlet UIButton *sixBtn;
@property (strong, nonatomic) IBOutlet UIButton *sevenBtn;
@property (strong, nonatomic) IBOutlet UIButton *eightBtn;
@property (strong, nonatomic) IBOutlet UIButton *nineBtn;
@property (strong, nonatomic) IBOutlet UIButton *zeroBtn;
@property (strong, nonatomic) IBOutlet UIButton *delBtn;
@property (strong, nonatomic) IBOutlet UIButton *okBtn;
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
