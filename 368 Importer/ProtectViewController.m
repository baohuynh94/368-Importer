//
//  ProtectViewController.m
//  368 Importer
//
//  Created by Dino Phan on 9/1/14.
//  Copyright (c) 2014 Dino Phan. All rights reserved.
//

#import "ProtectViewController.h"

@interface ProtectViewController ()

@end

@implementation ProtectViewController

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
    passcodeNumber = 0;
    [_okBtn setEnabled:NO];
    
    [self setBorderColor:_okBtn];
    [self setBorderColor:_delBtn];
    [self setBorderColor:_oneBtn];
    [self setBorderColor:_twoBtn];
    [self setBorderColor:_threeBtn];
    [self setBorderColor:_fourBtn];
    [self setBorderColor:_fiveBtn];
    [self setBorderColor:_sixBtn];
    [self setBorderColor:_sevenBtn];
    [self setBorderColor:_eightBtn];
    [self setBorderColor:_nineBtn];
    [self setBorderColor:_zeroBtn];
    
}

- (void)setBorderColor:(UIView *)sender {
    UIButton *view = (UIButton *)sender;
    view.layer.cornerRadius = view.frame.size.width / 2;
    view.clipsToBounds = YES;
    view.layer.borderWidth = 3.0f;
    view.layer.borderColor = [UIColor blackColor].CGColor;
    [view setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [view setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    [view setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [view setBackgroundImage:[UIImage imageNamed:@"black_fx.png"] forState:UIControlStateHighlighted];
    [view setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
}

- (void)checkFourDigits {
    if (passcodeNumber >= 1000) {
        passcodeNumber = 0;
        [_passcodeLabel setText:[NSString stringWithFormat:@"%d", (int)passcodeNumber]];
    }
}

- (void)setOkBtnEnabled {
    if (passcodeNumber == [self passcodeNumberCheck]) {
        [_okBtn setEnabled:YES];
    }
    else {
        [_okBtn setEnabled:NO];
    }
}

- (NSString *)labelHideText:(NSInteger)number {
    if (number >= 1000) {
        return @"****";
    }
    else if (number >= 100) {
        return @"***";
    }
    else if (number >= 10) {
        return @"**";
    }
    else {
        return @"*";
    }
}

- (IBAction)oneBtn:(id)sender {
    [self checkFourDigits];
    passcodeNumber = (passcodeNumber * 10) + 1;
    [_passcodeLabel setText:[self labelHideText:passcodeNumber]];
    [self setOkBtnEnabled];
}
- (IBAction)twoBtn:(id)sender {
    [self checkFourDigits];
    passcodeNumber = (passcodeNumber * 10) + 2;
    [_passcodeLabel setText:[self labelHideText:passcodeNumber]];
    [self setOkBtnEnabled];
}
- (IBAction)threeBtn:(id)sender {
    [self checkFourDigits];
    passcodeNumber = (passcodeNumber * 10) + 3;
    [_passcodeLabel setText:[self labelHideText:passcodeNumber]];
    [self setOkBtnEnabled];
}
- (IBAction)fourBtn:(id)sender {
    [self checkFourDigits];
    passcodeNumber = (passcodeNumber * 10) + 4;
    [_passcodeLabel setText:[self labelHideText:passcodeNumber]];
    [self setOkBtnEnabled];
}
- (IBAction)fiveBtn:(id)sender {
    [self checkFourDigits];
    passcodeNumber = (passcodeNumber * 10) + 5;
    [_passcodeLabel setText:[self labelHideText:passcodeNumber]];
    [self setOkBtnEnabled];
}
- (IBAction)sixBtn:(id)sender {
    [self checkFourDigits];
    passcodeNumber = (passcodeNumber * 10) + 6;
    [_passcodeLabel setText:[self labelHideText:passcodeNumber]];
    [self setOkBtnEnabled];
}
- (IBAction)sevenBtn:(id)sender {
    [self checkFourDigits];
    passcodeNumber = (passcodeNumber * 10) + 7;
    [_passcodeLabel setText:[self labelHideText:passcodeNumber]];
    [self setOkBtnEnabled];
}
- (IBAction)eightBtn:(id)sender {
    [self checkFourDigits];
    passcodeNumber = (passcodeNumber * 10) + 8;
    [_passcodeLabel setText:[self labelHideText:passcodeNumber]];
    [self setOkBtnEnabled];
}
- (IBAction)nineBtn:(id)sender {
    [self checkFourDigits];
    passcodeNumber = (passcodeNumber * 10) + 9;
    [_passcodeLabel setText:[self labelHideText:passcodeNumber]];
    [self setOkBtnEnabled];
}
- (IBAction)zeroBtn:(id)sender {
    [self checkFourDigits];
    passcodeNumber = (passcodeNumber * 10) + 0;
    [_passcodeLabel setText:[self labelHideText:passcodeNumber]];
    [self setOkBtnEnabled];
}
- (IBAction)delBtn:(id)sender {
    passcodeNumber = 0;
    [_passcodeLabel setText:@""];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)passcodeNumberCheck {
    return [[[NSUserDefaults standardUserDefaults] objectForKey:@"pc"] integerValue];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
}

@end
