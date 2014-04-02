//
//  ViewController.m
//  CardIODemo
//
//  Created by mike.tihonchik on 3/31/14.
//  Copyright (c) 2014 mike.tihonchik. All rights reserved.
//

#import "ViewController.h"
#import "CardIO.h"
#import "Helpers.h"

@interface ViewController () <CardIOPaymentViewControllerDelegate>

@property (retain, nonatomic) UIButton *addNewCCBtn;
@property (retain, nonatomic) UILabel *ccNumberLabel;
@property (retain, nonatomic) UILabel *ccNumber;
@property (retain, nonatomic) UILabel *expirationLabel;
@property (retain, nonatomic) UILabel *expiration;
@property (retain, nonatomic) UILabel *cvvLabel;
@property (retain, nonatomic) UILabel *cvv;

@end

@implementation ViewController

#pragma mark - View Lifecycle
#pragma mark -

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupGuiStyle];
    [self setupLabels];
}

#pragma mark - User Actions

- (void)scanCardClicked:(id)sender {
    CardIOPaymentViewController *scanViewController = [[CardIOPaymentViewController alloc] initWithPaymentDelegate:self];
    scanViewController.modalPresentationStyle = UIModalPresentationFormSheet;
    scanViewController.appToken = @"ec637aaed7e4446da73c385fbbf67aab";
    [self presentViewController:scanViewController animated:YES completion:nil];
}

#pragma mark - CardIOPaymentViewControllerDelegate

- (void)userDidProvideCreditCardInfo:(CardIOCreditCardInfo *)info inPaymentViewController:(CardIOPaymentViewController *)paymentViewController {
    NSLog(@"Scan succeeded with info: %@", info);
    // Do whatever needs to be done to deliver the purchased items.
    [self dismissViewControllerAnimated:YES completion:nil];
    
    self.ccNumber.text = info.redactedCardNumber;
    self.expiration.text = [NSString stringWithFormat:@"%02lu/%lu", (unsigned long)info.expiryMonth, (unsigned long)info.expiryYear];
    self.cvv.text = info.cvv;
}

- (void)userDidCancelPaymentViewController:(CardIOPaymentViewController *)paymentViewController {
    NSLog(@"User cancelled scan");
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Setup GUI

- (void)setupGuiStyle {
    NSString *backgroundImage = @"view-background.png";
    int screenHeight = 480;
    if(IS_IPHONE_5) {
        backgroundImage = @"view-background-i5.png";
        screenHeight = 568;
    }
    
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:backgroundImage]];
    backgroundView.frame = self.view.bounds;
    [self.view addSubview:backgroundView];
    
    _addNewCCBtn = [[UIButton alloc] init];
    [_addNewCCBtn setTitle:@"SCAN CREDIT CARD" forState:UIControlStateNormal];
    [_addNewCCBtn.titleLabel setFont:EFFRA_MEDIUM(20)];
    [_addNewCCBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_addNewCCBtn setBackgroundImage:[UIImage imageNamed:@"primButton.png"] forState:UIControlStateNormal];
    _addNewCCBtn.frame = CGRectMake(20.0, 60, 280, 40);
    [_addNewCCBtn addTarget:self action:@selector(scanCardClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_addNewCCBtn];

    UIImageView *logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cardio.png"]];
    logo.frame = CGRectMake(5, screenHeight - 220, logo.frame.size.width, logo.frame.size.height);
    [self.view addSubview:logo];
    
    UIImageView *cornerImage =  [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"view-background-left-corner.png"]];
    cornerImage.frame = CGRectMake(0.0, screenHeight - 60, 60.0, 60.0);
    [self.view addSubview:cornerImage];
    
    UIImageView *demoView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"demo.png"]];
    demoView.frame = CGRectMake(200.0, screenHeight - 110, 100.0, 100.0);;
    [self.view addSubview:demoView];
    
}

- (void)setupLabels {
    _ccNumberLabel = [[UILabel alloc] init];
    _ccNumberLabel.text = @"Credit Card #:";
    [_ccNumberLabel setFont:EFFRA_LIGHT(16)];
    [_ccNumberLabel setTextColor:[self darkGrayColor]];
    _ccNumberLabel.frame = CGRectMake(20.0, 110, 160, 20);
    [self.view addSubview:_ccNumberLabel];

    _ccNumber = [[UILabel alloc] init];
    _ccNumber.text = @"";
    [_ccNumber setFont:EFFRA_LIGHT(14)];
    [_ccNumber setTextColor:[UIColor blackColor]];
    _ccNumber.frame = CGRectMake(40.0, 130, 200, 20);
    [self.view addSubview:_ccNumber];

    _expirationLabel = [[UILabel alloc] init];
    _expirationLabel.text = @"Expiration:";
    [_expirationLabel setFont:EFFRA_LIGHT(16)];
    [_expirationLabel setTextColor:[self darkGrayColor]];
    _expirationLabel.frame = CGRectMake(20.0, 150, 160, 20);
    [self.view addSubview:_expirationLabel];

    _expiration = [[UILabel alloc] init];
    _expiration.text = @"";
    [_expiration setFont:EFFRA_LIGHT(14)];
    [_expiration setTextColor:[UIColor blackColor]];
    _expiration.frame = CGRectMake(40.0, 170, 160, 20);
    [self.view addSubview:_expiration];

    _cvvLabel = [[UILabel alloc] init];
    _cvvLabel.text = @"CVV #:";
    [_cvvLabel setFont:EFFRA_LIGHT(16)];
    [_cvvLabel setTextColor:[self darkGrayColor]];
    _cvvLabel.frame = CGRectMake(20.0, 190, 160, 20);
    [self.view addSubview:_cvvLabel];

    _cvv = [[UILabel alloc] init];
    _cvv.text = @"";
    [_cvv setFont:EFFRA_LIGHT(14)];
    [_cvv setTextColor:[UIColor blackColor]];
    _cvv.frame = CGRectMake(40.0, 210, 160, 20);
    [self.view addSubview:_cvv];
}

-(UIColor *)darkGrayColor {
    return HEXCOLOR(0x3F3F40FF);
}

@end
