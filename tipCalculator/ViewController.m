//
//  ViewController.m
//  tipCalculator
//
//  Created by Li Pan on 2016-01-22.
//  Copyright © 2016 Li Pan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITextFieldDelegate>
@property (nonatomic, assign) BOOL clearsOnBeginEditing;
@property (nonatomic, strong) UITextField *tipAmountTextField;
@property (nonatomic, strong) UIButton *calculateTipButton;
@property (nonatomic, assign) float billAmount;
@property (nonatomic, assign) float tipAmount;
@property (nonatomic, assign) float totalAmount;
@property (nonatomic, assign) int tipPercentage;
@property (nonatomic, strong) UILabel *tipAmountDisplay;
@property (nonatomic, strong) UILabel *totalAmountDisplay;
@property (nonatomic, strong) UITextField *tipPercentDisplay;
@property (nonatomic, strong) UISlider *tipPercentSlider;
@property (nonatomic, strong) UIImageView *background;


@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor colorWithRed:(243.0/255.0) green:235.0/255.0 blue:232.0/255.0 alpha:1.0];
    self.tipPercentage = 15;
    
    self.tipAmountTextField = [[UITextField alloc] initWithFrame:CGRectZero];
    self.tipAmountTextField.translatesAutoresizingMaskIntoConstraints = NO;
    self.tipAmountTextField.delegate = self;
    self.tipAmountTextField.borderStyle = UITextBorderStyleLine;
    self.tipAmountTextField.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6813];
    self.tipAmountTextField.textAlignment = NSTextAlignmentCenter;
    self.tipAmountTextField.placeholder = @"your bill";
    self.tipAmountTextField.keyboardType = UIKeyboardTypeDecimalPad;
    [self.tipAmountTextField becomeFirstResponder];
    [self.view addSubview:self.tipAmountTextField];
    
    self.calculateTipButton = [[UIButton alloc] initWithFrame:CGRectZero];
    self.calculateTipButton.translatesAutoresizingMaskIntoConstraints = NO;
    self.calculateTipButton.backgroundColor= [UIColor blackColor];
    [self.calculateTipButton setTitle:@"calculate" forState:UIControlStateNormal];
    [self.calculateTipButton setTitleColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.6813] forState:UIControlStateNormal];
    [self.calculateTipButton addTarget:self action:@selector(caluclateButtonPushed:) forControlEvents:UIControlEventTouchUpInside];
    self.calculateTipButton.alpha = 0.6813;
    
    self.tipAmountDisplay = [[UILabel alloc] initWithFrame:CGRectZero];
    self.tipAmountDisplay.translatesAutoresizingMaskIntoConstraints = NO;
    self.tipAmountDisplay.numberOfLines = 2;
    self.tipAmountDisplay.text = @"tip amount:";
    self.tipAmountDisplay.textAlignment = NSTextAlignmentCenter;
    self.tipAmountDisplay.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6813];
    
    self.tipPercentSlider = [[UISlider alloc] initWithFrame:CGRectZero];
    [self.tipPercentSlider setUserInteractionEnabled:YES];
    [self.tipPercentSlider setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.tipPercentSlider addTarget:self action:@selector(adjusttipPercentage:) forControlEvents:UIControlEventTouchDragInside];
    [self.tipPercentSlider setMinimumValue:0];
    [self.tipPercentSlider setMaximumValue:50];
    [self.tipPercentSlider setValue:15];
    
    self.totalAmountDisplay = [[UILabel alloc] initWithFrame:CGRectZero];
    self.totalAmountDisplay.translatesAutoresizingMaskIntoConstraints = NO;
    self.totalAmountDisplay.numberOfLines = 2;
    self.totalAmountDisplay.text = @"total amount:";
    self.totalAmountDisplay.textAlignment = NSTextAlignmentCenter;
    self.totalAmountDisplay.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6813];
    
    self.tipPercentDisplay = [[UITextField alloc] initWithFrame:CGRectZero];
    self.tipPercentDisplay.translatesAutoresizingMaskIntoConstraints = NO;
    self.tipPercentDisplay.text = [[NSString alloc] initWithFormat:@"tip %d%%", 15];
    self.tipPercentDisplay.clearsOnBeginEditing = YES;
    self.tipPercentDisplay.textAlignment = NSTextAlignmentCenter;
    self.tipPercentDisplay.keyboardType = UIKeyboardTypeDecimalPad;
    self.tipPercentDisplay.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6813];
    [self.tipPercentDisplay setNeedsDisplay];
    
    self.background = [[UIImageView alloc] init];
    self.background.image = [UIImage imageNamed:@"glass.png"];

    [self.view addSubview:self.calculateTipButton];
    [self.view addSubview:self.tipAmountDisplay];
    [self.view addSubview:self.tipAmountTextField];
    [self.view addSubview:self.totalAmountDisplay];
    [self.view addSubview:self.tipPercentSlider];
    [self.view addSubview:self.tipPercentDisplay];
    [self.view addSubview:self.self.background];
    
#pragma backgroundConstraints
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.background attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.background attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.618 constant:0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.background attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:200]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.background attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:300]];
    
#pragma mark-tipAmountTextFieldConstraints
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.tipAmountTextField attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.tipAmountTextField attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:0.618 constant:0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.tipAmountTextField attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:200]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.tipAmountTextField attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30]];

#pragma mark-calculateTipButtonLayoutConstraints
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.calculateTipButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.calculateTipButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:0.618 constant:40]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.calculateTipButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:200]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.calculateTipButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30]];
    
#pragma mark-tipAmountDisplayConstraints
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.tipAmountDisplay attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.tipAmountDisplay attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:0.618 constant:102]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.tipAmountDisplay attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:200]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.tipAmountDisplay attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:60]];
    
#pragma mark-totalAmountDisplayConstraints
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.totalAmountDisplay attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.totalAmountDisplay attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:0.618 constant:153]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.totalAmountDisplay attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:200]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.totalAmountDisplay attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:60]];

#pragma mark-percentTipSliderConstraint
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.tipPercentSlider attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.tipPercentSlider attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:0.618 constant:236]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.tipPercentSlider attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:323.6]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.tipPercentSlider attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:60]];
    
#pragma mark-percentTipDisplayConstraint
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.tipPercentDisplay attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:150]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.tipPercentDisplay attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:0.618 constant:186]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.tipPercentDisplay attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:323.6]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.tipPercentDisplay attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:60]];
}


    



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.tipAmountTextField resignFirstResponder];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    self.billAmount = [self.tipAmountTextField.text floatValue];
    self.tipPercentage = [self.tipPercentDisplay.text floatValue];
    [self.tipAmountTextField resignFirstResponder];
    
    return YES;
}

- (void)caluclateButtonPushed: (UIButton *)calculateButton {
    self.tipPercentage = self.tipPercentSlider.value;
    self.tipAmount = self.billAmount * self.tipPercentage / 100;
    self.tipAmountDisplay.text = [[NSString alloc] initWithFormat:@"tip amount:\n$%0.2f", self.tipAmount];
    self.tipAmountDisplay.alpha = 0.1;
    [UIView animateWithDuration:0.75 animations:^{
         self.tipAmountDisplay.alpha = 1.0;
        
            //self.tipAmountDisplay.textColor = [UIColor colorWithRed:243.0/255.0 green:170.0/255.0 blue:59.0/255.0 alpha:1.0];
            self.tipAmountDisplay.textColor = [UIColor colorWithRed:166.0/255.0 green:40.0/255.0 blue:40.0/255.0 alpha:1.0];
    [self.tipAmountTextField resignFirstResponder];

    }];
    NSLog(@"%f", self.tipAmount);
    
    self.totalAmount = self.billAmount + self.tipAmount;
    self.totalAmountDisplay.text = [[NSString alloc] initWithFormat:@"total amount:\n$%0.2f", self.totalAmount];
    self.totalAmountDisplay.alpha = 0;
    [UIView animateWithDuration:2.3 animations:^{
        self.totalAmountDisplay.alpha = 1.0;
        self.totalAmountDisplay.textColor = [UIColor blackColor];
//        self.totalAmountDisplay.textColor = [UIColor colorWithRed:166.0/255.0 green:40.0/255.0 blue:40.0/255.0 alpha:1.0];
        
    }];
    NSLog(@"%f", self.totalAmount);
    
}

- (void)adjusttipPercentage: (UISlider *)sliderValue {
    self.tipPercentage = sliderValue.value;
    self.tipPercentDisplay.text = [[NSString alloc] initWithFormat:@"tip %d%%", self.tipPercentage];
    self.tipAmountDisplay.text = [[NSString alloc] initWithFormat:@"tip amount:\n$%0.2f", self.tipAmount];
    self.tipAmount = self.billAmount * self.tipPercentage / 100.0;
    self.tipAmountDisplay.text = [[NSString alloc] initWithFormat:@"tip amount:\n$%0.2f", self.tipAmount];
    self.totalAmount = self.billAmount + self.tipAmount;
    self.totalAmountDisplay.text = [[NSString alloc] initWithFormat:@"total amount:\n$%0.2f", self.totalAmount];

    
}
@end
