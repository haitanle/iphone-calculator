//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Hai-Tan Le on 10/25/12.
//  Copyright (c) 2012 Hai-Tan Le. All rights reserved.
//

#import "CalculatorBrain.h"
#include <math.h>

@interface CalculatorBrain()
@property (nonatomic, strong) NSMutableArray *programStack;
@end

@implementation CalculatorBrain
@synthesize programStack=_programStack;

-(NSMutableArray *)programStack 
{
    if (_programStack==nil)_programStack= [[NSMutableArray alloc]init];
    return _programStack;
}

- (id)program
{
    return [self.programStack copy];
}

+ (NSString *)descriptionOfProgram:(id)program
{
    return @"Implement this in Homework #2";
}


-(void) pushOperand: (double) operand
{
    [self.programStack addObject:[NSNumber numberWithDouble:operand]];
}


-(double) performOperation: (NSString *) operation
{
    [self.programStack addObject:operation];
    return [[self class] runProgram:self.program];
}

+ (double)popOperandOffProgramStack:(NSMutableArray *)stack{
    
    double result = 0;
    
    id topOfStack = [stack lastObject];
    if (topOfStack) [stack removeLastObject];
    
    if ([topOfStack isKindOfClass:[NSNumber class]])
    {
        result = [topOfStack doubleValue];
    }
    else if ([topOfStack isKindOfClass:[NSString class]])
    {
        NSString *operation = topOfStack;
        if ([operation isEqualToString: @"+"]){
            result = [self popOperandOffProgramStack:stack] + [self popOperandOffProgramStack:stack];
        } else if([@"*" isEqualToString:operation]){
            result = [self popOperandOffProgramStack:stack] * [self popOperandOffProgramStack:stack];
        } else if ([operation isEqualToString:@"-"]){
            double subtrahend = [self popOperandOffProgramStack:stack];
            result = [self popOperandOffProgramStack:stack] - subtrahend;
        } else if ([operation isEqualToString:@"/"]){
            double divisor = [self popOperandOffProgramStack:stack];
            if(divisor) result = [self popOperandOffProgramStack:stack] / divisor;
        } else if ([operation isEqualToString:@"sin"]){
            result = sin([self popOperandOffProgramStack:stack]);
        } else if ([operation isEqualToString:@"cos"]){
            result = cos([self popOperandOffProgramStack:stack]);
        } else if ([operation isEqualToString:@"sqrt"]){
            result = sqrt([self popOperandOffProgramStack:stack]);
        } else if ([operation isEqualToString:@"π"]){
            result=3.14159265359;
        }
    }
    return result;
}

+(NSDictionary *) variablesValues{
    NSMutableDictionary *test1 = [NSMutableDictionary dictionary];
    [test1 setObject: @"1"
              forKey: @"x"];
    [test1 setObject: @"1"
              forKey: @"a"];
    [test1 setObject: @"1"
              forKey: @"b"];
    
    NSMutableDictionary *test2 = [NSMutableDictionary dictionary];
    [test1 setObject: @"1"
              forKey: @"x"];
    [test1 setObject: @"1"
              forKey: @"a"];
    [test1 setObject: @"1"
              forKey: @"b"];
    
    NSMutableDictionary *test3 = [NSMutableDictionary dictionary];
    [test1 setObject: @"1"
              forKey: @"x"];
    [test1 setObject: @"1"
              forKey: @"a"];
    [test1 setObject: @"1"
              forKey: @"b"];

}



+ (double)runProgram:(id)program
 usingVariableValues:(NSDictionary *)variableValues
{
    NSMutableArray *stack;
    if ([program isKindOfClass:[NSArray class]]) {
        stack = [program mutableCopy];
    }
    return [self popOperandOffProgramStack:stack];
}


-(void) clearStack
{
    self.programStack = nil;
}

@end
