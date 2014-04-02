//
//  ViewController.m
//  CardIODemo
//
//  Created by mike.tihonchik on 3/31/14.
//  Copyright (c) 2014 mike.tihonchik. All rights reserved.
//

#import "ViewController.h"
#import "CardIO.h"
#import "Constants.h"

@interface ViewController () <CardIOPaymentViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *infoLabel;

@end

@implementation ViewController

#pragma mark - View Lifecycle
#pragma mark -

- (void)viewDidLoad {
    [super viewDidLoad];
    self.infoLabel.text = @"";

    [self setupGuiStyle];
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
    
    self.infoLabel.text = [NSString stringWithFormat:@"Received card info. Number: %@, expiry: %02lu/%lu, cvv: %@.", info.redactedCardNumber, (unsigned long)info.expiryMonth, (unsigned long)info.expiryYear, info.cvv];
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

@end
