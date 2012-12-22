//
//  CalculatorBrain.h
//  Calculator
//
//  Created by Hai-Tan Le on 10/25/12.
//  Copyright (c) 2012 Hai-Tan Le. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject

-(void) pushOperand: (double) operand;
-(double) performOperation: (NSString *) operation;
-(void) clearStack; 

@property (readonly) id program;

+(double) runProgram:(id)program
 usingVariableValues:(NSDictionary *)variableValues;
+(NSString *)descriptionOfProgram: (id)program;


@end
