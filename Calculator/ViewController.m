//
//  ViewController.m
//  Calculator
//
//  Created by Hai-Tan Le on 10/20/12.
//  Copyright (c) 2012 Hai-Tan Le. All rights reserved.
//

#import "ViewController.h"
#import "CalculatorBrain.h"


@interface ViewController ()
@property (nonatomic) BOOL userIsInTheMiddleOfEnteringANumber;
@property (nonatomic, strong) CalculatorBrain *brain;
@property (nonatomic) BOOL dotEntered;
@property (nonatomic) BOOL firstNumberAlreadySet;
@end

@implementation ViewController

@synthesize display;
@synthesize friendlyDisplay;
@synthesize userIsInTheMiddleOfEnteringANumber;
@synthesize firstNumberAlreadySet;
@synthesize dotEntered;
@synthesize brain = _brain;

-(CalculatorBrain *)brain
{
    if (!_brain) _brain = [[CalculatorBrain alloc] init];
    return _brain;
}

- (IBAction)digitPressed:(UIButton *)sender
{
  
    NSString *digit = [sender currentTitle];
    
    if (self.userIsInTheMiddleOfEnteringANumber) {
        if (![digit isEqualToString:@"."]){
            self.display.text = [self.display.text stringByAppendingString:digit];
            self.friendlyDisplay.text =[self.friendlyDisplay.text stringByAppendingString:digit];
        } else {
            if (self.dotEntered== YES){
                //self.display.text = Nil;
            }else if (self.dotEntered==NO){
                self.display.text = [self.display.text stringByAppendingString:digit];
                self.friendlyDisplay.text =[self.friendlyDisplay.text stringByAppendingString:digit];
                self.dotEntered=YES;            }
        }
    } else {
        self.display.text = digit;
        if (firstNumberAlreadySet==NO) {
            self.friendlyDisplay.text = digit;  //checks for 0 when starting out
            self.firstNumberAlreadySet =YES;
        } else {
            self.friendlyDisplay.text = [self.friendlyDisplay.text stringByAppendingString:digit];
        }
        if ([digit isEqualToString:@"."]){
            self.dotEntered = YES;
        }
        self.userIsInTheMiddleOfEnteringANumber =  YES;
    }
}

- (IBAction)enterPressed
{
    [self.brain pushOperand:[self.display.text doubleValue]];
    self.userIsInTheMiddleOfEnteringANumber = NO;
    self.dotEntered = NO;
    self.friendlyDisplay.text = [self.friendlyDisplay.text stringByAppendingString:@" , "];
}

- (IBAction)clearPressed {
    [self.brain clearStack];
    self.friendlyDisplay.text = @"";      //Clear memory
    self.display.text = @"";
}

- (IBAction)operationPressed:(UIButton *)sender
{
    if (self.userIsInTheMiddleOfEnteringANumber){
        [self enterPressed];
    }
    NSString *operation = [sender currentTitle];
    double result = [self.brain performOperation:operation];
    self.display.text = [NSString stringWithFormat:@"%g",result];
    self.friendlyDisplay.text = [self.friendlyDisplay.text stringByAppendingString:operation];
    self.friendlyDisplay.text = [self.friendlyDisplay.text stringByAppendingString:@" "];
}

- (IBAction)testPressed:(UIButton *)sender {

    NSString *test = [sender currentTitle];
    if [test isEqual: @"Test 1"]{
        
    }
    
}

@end
